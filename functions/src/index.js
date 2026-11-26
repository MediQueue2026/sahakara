import { getApps, initializeApp } from 'firebase-admin/app';
import { getDataConnect } from 'firebase-admin/data-connect';
import { getMessaging } from 'firebase-admin/messaging';
import { logger } from 'firebase-functions';
import { onMutationExecuted } from 'firebase-functions/dataconnect';
import {
  connectorConfig,
  removeInvalidFcmToken,
  taskNotificationDetails,
} from '@dataconnect/admin-generated';

if (getApps().length === 0) initializeApp();

const dataConnect = getDataConnect(connectorConfig);
const connector = 'sahakara';
const service = 'sahakara-f78dd-service';

export const notifyAssignedMaid = onMutationExecuted(
  {
    region: 'asia-southeast1',
    service,
    connector,
    operation: 'AssignDailyTask',
  },
  async (event) => {
    if (event.authType !== 'app_user' || event.data.payload.errors.length > 0) {
      return;
    }

    const { id, assignedToId } = event.data.payload.variables;
    await notifyTaskAssignee(id, assignedToId);
  },
);

export const notifyNewAssignedTask = onMutationExecuted(
  {
    region: 'asia-southeast1',
    service,
    connector,
    operation: 'AddDailyTask',
  },
  async (event) => {
    const { assignedToId } = event.data.payload.variables;
    if (
      event.authType !== 'app_user' ||
      event.data.payload.errors.length > 0 ||
      !assignedToId
    ) {
      return;
    }

    const taskId = event.data.payload.data.task_insert?.id;
    if (!taskId) {
      logger.error('AddDailyTask event did not include its task ID', {
        eventId: event.id,
      });
      return;
    }
    await notifyTaskAssignee(taskId, assignedToId);
  },
);

async function notifyTaskAssignee(taskId, expectedMemberId) {
  const result = await taskNotificationDetails(dataConnect, { taskId });
  const task = result.data.tasks[0];
  if (
    !task?.assignedTo ||
    (expectedMemberId && task.assignedTo.id !== expectedMemberId)
  ) {
    return;
  }

  const user = task.assignedTo.user;
  const deviceTokens = user.userDeviceTokens_on_user.map(({ token }) => token);
  if (deviceTokens.length === 0) return;

  const title = (
    user.language === 'si'
      ? task.template.library?.nameSi ?? task.template.customTitleSi
      : user.language === 'ta'
        ? task.template.library?.nameTa ?? task.template.customTitleTa
        : task.template.library?.nameEn ?? task.template.customTitle
  ) ?? task.template.customTitle ?? task.template.library?.nameEn ?? 'A new task';
  const body = `Assigned by ${task.template.household.name}`;

  for (let offset = 0; offset < deviceTokens.length; offset += 500) {
    const tokens = deviceTokens.slice(offset, offset + 500);
    const response = await getMessaging().sendEachForMulticast({
      tokens,
      notification: { title, body },
      data: { type: 'task_assigned', taskId },
      android: { priority: 'high' },
    });

    const invalidTokenCodes = new Set([
      'messaging/registration-token-not-registered',
      'messaging/invalid-registration-token',
    ]);
    const invalidTokens = [];
    let failedCount = 0;
    response.responses.forEach((sendResponse, index) => {
      if (!sendResponse.error) return;
      failedCount++;
      if (invalidTokenCodes.has(sendResponse.error.code)) {
        invalidTokens.push(tokens[index]);
      }
    });
    if (failedCount > invalidTokens.length) {
      logger.warn('Some task-assignment notifications could not be sent', {
        taskId,
        failedCount,
      });
    }
    await Promise.all(
      invalidTokens.map((token) =>
        removeInvalidFcmToken(dataConnect, { token }),
      ),
    );
  }
}
