const { validateAdminArgs } = require('firebase-admin/data-connect');

const AccountType = {
  owner: "owner",
  maid: "maid",
  admin: "admin",
}
exports.AccountType = AccountType;

const AdvanceRequestStatus = {
  pending: "pending",
  approved: "approved",
  rejected: "rejected",
}
exports.AdvanceRequestStatus = AdvanceRequestStatus;

const AppLanguage = {
  si: "si",
  ta: "ta",
  en: "en",
}
exports.AppLanguage = AppLanguage;

const AttendanceDayType = {
  full: "full",
  half: "half",
  late: "late",
  early_leave: "early_leave",
  leave: "leave",
  absent: "absent",
  holiday: "holiday",
}
exports.AttendanceDayType = AttendanceDayType;

const BillingPeriod = {
  monthly: "monthly",
  yearly: "yearly",
}
exports.BillingPeriod = BillingPeriod;

const CantDoReason = {
  no_supplies: "no_supplies",
  power_cut: "power_cut",
  water_cut: "water_cut",
  sick: "sick",
  no_time: "no_time",
  other: "other",
}
exports.CantDoReason = CantDoReason;

const HolidayType = {
  poya: "poya",
  public: "public",
  festival: "festival",
}
exports.HolidayType = HolidayType;

const LeaveStatus = {
  pending: "pending",
  approved: "approved",
  rejected: "rejected",
}
exports.LeaveStatus = LeaveStatus;

const LeaveType = {
  paid: "paid",
  unpaid: "unpaid",
  sick: "sick",
}
exports.LeaveType = LeaveType;

const MemberRole = {
  owner: "owner",
  adult: "adult",
  maid: "maid",
  driver: "driver",
  cook: "cook",
  gardener: "gardener",
}
exports.MemberRole = MemberRole;

const MembershipStatus = {
  pending: "pending",
  accepted: "accepted",
  declined: "declined",
}
exports.MembershipStatus = MembershipStatus;

const PayType = {
  monthly: "monthly",
  daily: "daily",
  hourly: "hourly",
  per_visit: "per_visit",
}
exports.PayType = PayType;

const PaymentMethod = {
  cash: "cash",
  bank: "bank",
  mobile_wallet: "mobile_wallet",
}
exports.PaymentMethod = PaymentMethod;

const RecurrenceType = {
  once: "once",
  daily: "daily",
  weekly: "weekly",
  fortnightly: "fortnightly",
  monthly: "monthly",
  quarterly: "quarterly",
}
exports.RecurrenceType = RecurrenceType;

const SalaryPaymentStatus = {
  scheduled: "scheduled",
  paid: "paid",
}
exports.SalaryPaymentStatus = SalaryPaymentStatus;

const TaskCategory = {
  kitchen: "kitchen",
  cleaning: "cleaning",
  laundry: "laundry",
  cooking: "cooking",
  childcare: "childcare",
  elderly_care: "elderly_care",
  newborn_care: "newborn_care",
  pet_care: "pet_care",
  other: "other",
}
exports.TaskCategory = TaskCategory;

const TaskLogAction = {
  started: "started",
  done: "done",
  help: "help",
  cant_do: "cant_do",
}
exports.TaskLogAction = TaskLogAction;

const TaskPriority = {
  high: "high",
  medium: "medium",
  low: "low",
}
exports.TaskPriority = TaskPriority;

const TaskStatus = {
  pending: "pending",
  started: "started",
  done: "done",
  need_help: "need_help",
  cant_do: "cant_do",
  carried_forward: "carried_forward",
}
exports.TaskStatus = TaskStatus;

const connectorConfig = {
  connector: 'sahakara',
  serviceId: 'sahakara-f78dd-service',
  location: 'asia-southeast1'
};
exports.connectorConfig = connectorConfig;

function claimInvitedProfile(dcOrOptions, options) {
  const { dc: dcInstance, options: inputOpts} = validateAdminArgs(connectorConfig, dcOrOptions, options, undefined);
  dcInstance.useGen(true);
  return dcInstance.executeMutation('ClaimInvitedProfile', undefined, inputOpts);
}
exports.claimInvitedProfile = claimInvitedProfile;

function createMyProfile(dcOrVarsOrOptions, varsOrOptions, options) {
  const { dc: dcInstance, vars: inputVars, options: inputOpts} = validateAdminArgs(connectorConfig, dcOrVarsOrOptions, varsOrOptions, options, true, true);
  dcInstance.useGen(true);
  return dcInstance.executeMutation('CreateMyProfile', inputVars, inputOpts);
}
exports.createMyProfile = createMyProfile;

function setMyName(dcOrVarsOrOptions, varsOrOptions, options) {
  const { dc: dcInstance, vars: inputVars, options: inputOpts} = validateAdminArgs(connectorConfig, dcOrVarsOrOptions, varsOrOptions, options, true, true);
  dcInstance.useGen(true);
  return dcInstance.executeMutation('SetMyName', inputVars, inputOpts);
}
exports.setMyName = setMyName;

function setMyProfile(dcOrVarsOrOptions, varsOrOptions, options) {
  const { dc: dcInstance, vars: inputVars, options: inputOpts} = validateAdminArgs(connectorConfig, dcOrVarsOrOptions, varsOrOptions, options, true, true);
  dcInstance.useGen(true);
  return dcInstance.executeMutation('SetMyProfile', inputVars, inputOpts);
}
exports.setMyProfile = setMyProfile;

function setMyLanguage(dcOrVarsOrOptions, varsOrOptions, options) {
  const { dc: dcInstance, vars: inputVars, options: inputOpts} = validateAdminArgs(connectorConfig, dcOrVarsOrOptions, varsOrOptions, options, true, true);
  dcInstance.useGen(true);
  return dcInstance.executeMutation('SetMyLanguage', inputVars, inputOpts);
}
exports.setMyLanguage = setMyLanguage;

function saveMyFcmToken(dcOrVarsOrOptions, varsOrOptions, options) {
  const { dc: dcInstance, vars: inputVars, options: inputOpts} = validateAdminArgs(connectorConfig, dcOrVarsOrOptions, varsOrOptions, options, true, true);
  dcInstance.useGen(true);
  return dcInstance.executeMutation('SaveMyFcmToken', inputVars, inputOpts);
}
exports.saveMyFcmToken = saveMyFcmToken;

function removeMyFcmToken(dcOrVarsOrOptions, varsOrOptions, options) {
  const { dc: dcInstance, vars: inputVars, options: inputOpts} = validateAdminArgs(connectorConfig, dcOrVarsOrOptions, varsOrOptions, options, true, true);
  dcInstance.useGen(true);
  return dcInstance.executeMutation('RemoveMyFcmToken', inputVars, inputOpts);
}
exports.removeMyFcmToken = removeMyFcmToken;

function removeInvalidFcmToken(dcOrVarsOrOptions, varsOrOptions, options) {
  const { dc: dcInstance, vars: inputVars, options: inputOpts} = validateAdminArgs(connectorConfig, dcOrVarsOrOptions, varsOrOptions, options, true, true);
  dcInstance.useGen(true);
  return dcInstance.executeMutation('RemoveInvalidFcmToken', inputVars, inputOpts);
}
exports.removeInvalidFcmToken = removeInvalidFcmToken;

function setHouseholdArea(dcOrVarsOrOptions, varsOrOptions, options) {
  const { dc: dcInstance, vars: inputVars, options: inputOpts} = validateAdminArgs(connectorConfig, dcOrVarsOrOptions, varsOrOptions, options, true, true);
  dcInstance.useGen(true);
  return dcInstance.executeMutation('SetHouseholdArea', inputVars, inputOpts);
}
exports.setHouseholdArea = setHouseholdArea;

function createHousehold(dcOrVarsOrOptions, varsOrOptions, options) {
  const { dc: dcInstance, vars: inputVars, options: inputOpts} = validateAdminArgs(connectorConfig, dcOrVarsOrOptions, varsOrOptions, options, true, true);
  dcInstance.useGen(true);
  return dcInstance.executeMutation('CreateHousehold', inputVars, inputOpts);
}
exports.createHousehold = createHousehold;

function addHouseholdMember(dcOrVarsOrOptions, varsOrOptions, options) {
  const { dc: dcInstance, vars: inputVars, options: inputOpts} = validateAdminArgs(connectorConfig, dcOrVarsOrOptions, varsOrOptions, options, true, true);
  dcInstance.useGen(true);
  return dcInstance.executeMutation('AddHouseholdMember', inputVars, inputOpts);
}
exports.addHouseholdMember = addHouseholdMember;

function inviteHouseholdMember(dcOrVarsOrOptions, varsOrOptions, options) {
  const { dc: dcInstance, vars: inputVars, options: inputOpts} = validateAdminArgs(connectorConfig, dcOrVarsOrOptions, varsOrOptions, options, true, true);
  dcInstance.useGen(true);
  return dcInstance.executeMutation('InviteHouseholdMember', inputVars, inputOpts);
}
exports.inviteHouseholdMember = inviteHouseholdMember;

function reinviteHouseholdMember(dcOrVarsOrOptions, varsOrOptions, options) {
  const { dc: dcInstance, vars: inputVars, options: inputOpts} = validateAdminArgs(connectorConfig, dcOrVarsOrOptions, varsOrOptions, options, true, true);
  dcInstance.useGen(true);
  return dcInstance.executeMutation('ReinviteHouseholdMember', inputVars, inputOpts);
}
exports.reinviteHouseholdMember = reinviteHouseholdMember;

function acceptHouseholdInvite(dcOrVarsOrOptions, varsOrOptions, options) {
  const { dc: dcInstance, vars: inputVars, options: inputOpts} = validateAdminArgs(connectorConfig, dcOrVarsOrOptions, varsOrOptions, options, true, true);
  dcInstance.useGen(true);
  return dcInstance.executeMutation('AcceptHouseholdInvite', inputVars, inputOpts);
}
exports.acceptHouseholdInvite = acceptHouseholdInvite;

function declineHouseholdInvite(dcOrVarsOrOptions, varsOrOptions, options) {
  const { dc: dcInstance, vars: inputVars, options: inputOpts} = validateAdminArgs(connectorConfig, dcOrVarsOrOptions, varsOrOptions, options, true, true);
  dcInstance.useGen(true);
  return dcInstance.executeMutation('DeclineHouseholdInvite', inputVars, inputOpts);
}
exports.declineHouseholdInvite = declineHouseholdInvite;

function cancelHouseholdInvite(dcOrVarsOrOptions, varsOrOptions, options) {
  const { dc: dcInstance, vars: inputVars, options: inputOpts} = validateAdminArgs(connectorConfig, dcOrVarsOrOptions, varsOrOptions, options, true, true);
  dcInstance.useGen(true);
  return dcInstance.executeMutation('CancelHouseholdInvite', inputVars, inputOpts);
}
exports.cancelHouseholdInvite = cancelHouseholdInvite;

function removeHouseholdMember(dcOrVarsOrOptions, varsOrOptions, options) {
  const { dc: dcInstance, vars: inputVars, options: inputOpts} = validateAdminArgs(connectorConfig, dcOrVarsOrOptions, varsOrOptions, options, true, true);
  dcInstance.useGen(true);
  return dcInstance.executeMutation('RemoveHouseholdMember', inputVars, inputOpts);
}
exports.removeHouseholdMember = removeHouseholdMember;

function saveContract(dcOrVarsOrOptions, varsOrOptions, options) {
  const { dc: dcInstance, vars: inputVars, options: inputOpts} = validateAdminArgs(connectorConfig, dcOrVarsOrOptions, varsOrOptions, options, true, true);
  dcInstance.useGen(true);
  return dcInstance.executeMutation('SaveContract', inputVars, inputOpts);
}
exports.saveContract = saveContract;

function addDailyTask(dcOrVarsOrOptions, varsOrOptions, options) {
  const { dc: dcInstance, vars: inputVars, options: inputOpts} = validateAdminArgs(connectorConfig, dcOrVarsOrOptions, varsOrOptions, options, true, true);
  dcInstance.useGen(true);
  return dcInstance.executeMutation('AddDailyTask', inputVars, inputOpts);
}
exports.addDailyTask = addDailyTask;

function assignDailyTask(dcOrVarsOrOptions, varsOrOptions, options) {
  const { dc: dcInstance, vars: inputVars, options: inputOpts} = validateAdminArgs(connectorConfig, dcOrVarsOrOptions, varsOrOptions, options, true, true);
  dcInstance.useGen(true);
  return dcInstance.executeMutation('AssignDailyTask', inputVars, inputOpts);
}
exports.assignDailyTask = assignDailyTask;

function deleteDailyTask(dcOrVarsOrOptions, varsOrOptions, options) {
  const { dc: dcInstance, vars: inputVars, options: inputOpts} = validateAdminArgs(connectorConfig, dcOrVarsOrOptions, varsOrOptions, options, true, true);
  dcInstance.useGen(true);
  return dcInstance.executeMutation('DeleteDailyTask', inputVars, inputOpts);
}
exports.deleteDailyTask = deleteDailyTask;

function updateMyTaskStatus(dcOrVarsOrOptions, varsOrOptions, options) {
  const { dc: dcInstance, vars: inputVars, options: inputOpts} = validateAdminArgs(connectorConfig, dcOrVarsOrOptions, varsOrOptions, options, true, true);
  dcInstance.useGen(true);
  return dcInstance.executeMutation('UpdateMyTaskStatus', inputVars, inputOpts);
}
exports.updateMyTaskStatus = updateMyTaskStatus;

function addLibraryTask(dcOrVarsOrOptions, varsOrOptions, options) {
  const { dc: dcInstance, vars: inputVars, options: inputOpts} = validateAdminArgs(connectorConfig, dcOrVarsOrOptions, varsOrOptions, options, true, true);
  dcInstance.useGen(true);
  return dcInstance.executeMutation('AddLibraryTask', inputVars, inputOpts);
}
exports.addLibraryTask = addLibraryTask;

function deleteLibraryTask(dcOrVarsOrOptions, varsOrOptions, options) {
  const { dc: dcInstance, vars: inputVars, options: inputOpts} = validateAdminArgs(connectorConfig, dcOrVarsOrOptions, varsOrOptions, options, true, true);
  dcInstance.useGen(true);
  return dcInstance.executeMutation('DeleteLibraryTask', inputVars, inputOpts);
}
exports.deleteLibraryTask = deleteLibraryTask;

function addHoliday(dcOrVarsOrOptions, varsOrOptions, options) {
  const { dc: dcInstance, vars: inputVars, options: inputOpts} = validateAdminArgs(connectorConfig, dcOrVarsOrOptions, varsOrOptions, options, true, true);
  dcInstance.useGen(true);
  return dcInstance.executeMutation('AddHoliday', inputVars, inputOpts);
}
exports.addHoliday = addHoliday;

function deleteHoliday(dcOrVarsOrOptions, varsOrOptions, options) {
  const { dc: dcInstance, vars: inputVars, options: inputOpts} = validateAdminArgs(connectorConfig, dcOrVarsOrOptions, varsOrOptions, options, true, true);
  dcInstance.useGen(true);
  return dcInstance.executeMutation('DeleteHoliday', inputVars, inputOpts);
}
exports.deleteHoliday = deleteHoliday;

function addPaymentPlan(dcOrVarsOrOptions, varsOrOptions, options) {
  const { dc: dcInstance, vars: inputVars, options: inputOpts} = validateAdminArgs(connectorConfig, dcOrVarsOrOptions, varsOrOptions, options, true, true);
  dcInstance.useGen(true);
  return dcInstance.executeMutation('AddPaymentPlan', inputVars, inputOpts);
}
exports.addPaymentPlan = addPaymentPlan;

function deletePaymentPlan(dcOrVarsOrOptions, varsOrOptions, options) {
  const { dc: dcInstance, vars: inputVars, options: inputOpts} = validateAdminArgs(connectorConfig, dcOrVarsOrOptions, varsOrOptions, options, true, true);
  dcInstance.useGen(true);
  return dcInstance.executeMutation('DeletePaymentPlan', inputVars, inputOpts);
}
exports.deletePaymentPlan = deletePaymentPlan;

function setHouseholdPlan(dcOrVarsOrOptions, varsOrOptions, options) {
  const { dc: dcInstance, vars: inputVars, options: inputOpts} = validateAdminArgs(connectorConfig, dcOrVarsOrOptions, varsOrOptions, options, true, true);
  dcInstance.useGen(true);
  return dcInstance.executeMutation('SetHouseholdPlan', inputVars, inputOpts);
}
exports.setHouseholdPlan = setHouseholdPlan;

function checkIn(dcOrVarsOrOptions, varsOrOptions, options) {
  const { dc: dcInstance, vars: inputVars, options: inputOpts} = validateAdminArgs(connectorConfig, dcOrVarsOrOptions, varsOrOptions, options, true, true);
  dcInstance.useGen(true);
  return dcInstance.executeMutation('CheckIn', inputVars, inputOpts);
}
exports.checkIn = checkIn;

function checkOut(dcOrVarsOrOptions, varsOrOptions, options) {
  const { dc: dcInstance, vars: inputVars, options: inputOpts} = validateAdminArgs(connectorConfig, dcOrVarsOrOptions, varsOrOptions, options, true, true);
  dcInstance.useGen(true);
  return dcInstance.executeMutation('CheckOut', inputVars, inputOpts);
}
exports.checkOut = checkOut;

function addAttendanceRecord(dcOrVarsOrOptions, varsOrOptions, options) {
  const { dc: dcInstance, vars: inputVars, options: inputOpts} = validateAdminArgs(connectorConfig, dcOrVarsOrOptions, varsOrOptions, options, true, true);
  dcInstance.useGen(true);
  return dcInstance.executeMutation('AddAttendanceRecord', inputVars, inputOpts);
}
exports.addAttendanceRecord = addAttendanceRecord;

function updateAttendanceRecord(dcOrVarsOrOptions, varsOrOptions, options) {
  const { dc: dcInstance, vars: inputVars, options: inputOpts} = validateAdminArgs(connectorConfig, dcOrVarsOrOptions, varsOrOptions, options, true, true);
  dcInstance.useGen(true);
  return dcInstance.executeMutation('UpdateAttendanceRecord', inputVars, inputOpts);
}
exports.updateAttendanceRecord = updateAttendanceRecord;

function deleteAttendanceRecord(dcOrVarsOrOptions, varsOrOptions, options) {
  const { dc: dcInstance, vars: inputVars, options: inputOpts} = validateAdminArgs(connectorConfig, dcOrVarsOrOptions, varsOrOptions, options, true, true);
  dcInstance.useGen(true);
  return dcInstance.executeMutation('DeleteAttendanceRecord', inputVars, inputOpts);
}
exports.deleteAttendanceRecord = deleteAttendanceRecord;

function submitLeaveRequest(dcOrVarsOrOptions, varsOrOptions, options) {
  const { dc: dcInstance, vars: inputVars, options: inputOpts} = validateAdminArgs(connectorConfig, dcOrVarsOrOptions, varsOrOptions, options, true, true);
  dcInstance.useGen(true);
  return dcInstance.executeMutation('SubmitLeaveRequest', inputVars, inputOpts);
}
exports.submitLeaveRequest = submitLeaveRequest;

function scheduleSalaryPayment(dcOrVarsOrOptions, varsOrOptions, options) {
  const { dc: dcInstance, vars: inputVars, options: inputOpts} = validateAdminArgs(connectorConfig, dcOrVarsOrOptions, varsOrOptions, options, true, true);
  dcInstance.useGen(true);
  return dcInstance.executeMutation('ScheduleSalaryPayment', inputVars, inputOpts);
}
exports.scheduleSalaryPayment = scheduleSalaryPayment;

function markSalaryPaymentPaid(dcOrVarsOrOptions, varsOrOptions, options) {
  const { dc: dcInstance, vars: inputVars, options: inputOpts} = validateAdminArgs(connectorConfig, dcOrVarsOrOptions, varsOrOptions, options, true, true);
  dcInstance.useGen(true);
  return dcInstance.executeMutation('MarkSalaryPaymentPaid', inputVars, inputOpts);
}
exports.markSalaryPaymentPaid = markSalaryPaymentPaid;

function requestAdvance(dcOrVarsOrOptions, varsOrOptions, options) {
  const { dc: dcInstance, vars: inputVars, options: inputOpts} = validateAdminArgs(connectorConfig, dcOrVarsOrOptions, varsOrOptions, options, true, true);
  dcInstance.useGen(true);
  return dcInstance.executeMutation('RequestAdvance', inputVars, inputOpts);
}
exports.requestAdvance = requestAdvance;

function approveAdvanceRequest(dcOrVarsOrOptions, varsOrOptions, options) {
  const { dc: dcInstance, vars: inputVars, options: inputOpts} = validateAdminArgs(connectorConfig, dcOrVarsOrOptions, varsOrOptions, options, true, true);
  dcInstance.useGen(true);
  return dcInstance.executeMutation('ApproveAdvanceRequest', inputVars, inputOpts);
}
exports.approveAdvanceRequest = approveAdvanceRequest;

function rejectAdvanceRequest(dcOrVarsOrOptions, varsOrOptions, options) {
  const { dc: dcInstance, vars: inputVars, options: inputOpts} = validateAdminArgs(connectorConfig, dcOrVarsOrOptions, varsOrOptions, options, true, true);
  dcInstance.useGen(true);
  return dcInstance.executeMutation('RejectAdvanceRequest', inputVars, inputOpts);
}
exports.rejectAdvanceRequest = rejectAdvanceRequest;

function reviewLeaveRequest(dcOrVarsOrOptions, varsOrOptions, options) {
  const { dc: dcInstance, vars: inputVars, options: inputOpts} = validateAdminArgs(connectorConfig, dcOrVarsOrOptions, varsOrOptions, options, true, true);
  dcInstance.useGen(true);
  return dcInstance.executeMutation('ReviewLeaveRequest', inputVars, inputOpts);
}
exports.reviewLeaveRequest = reviewLeaveRequest;

function deleteLeaveRequest(dcOrVarsOrOptions, varsOrOptions, options) {
  const { dc: dcInstance, vars: inputVars, options: inputOpts} = validateAdminArgs(connectorConfig, dcOrVarsOrOptions, varsOrOptions, options, true, true);
  dcInstance.useGen(true);
  return dcInstance.executeMutation('DeleteLeaveRequest', inputVars, inputOpts);
}
exports.deleteLeaveRequest = deleteLeaveRequest;

function addGroceryItem(dcOrVarsOrOptions, varsOrOptions, options) {
  const { dc: dcInstance, vars: inputVars, options: inputOpts} = validateAdminArgs(connectorConfig, dcOrVarsOrOptions, varsOrOptions, options, true, true);
  dcInstance.useGen(true);
  return dcInstance.executeMutation('AddGroceryItem', inputVars, inputOpts);
}
exports.addGroceryItem = addGroceryItem;

function updateGroceryItemStatus(dcOrVarsOrOptions, varsOrOptions, options) {
  const { dc: dcInstance, vars: inputVars, options: inputOpts} = validateAdminArgs(connectorConfig, dcOrVarsOrOptions, varsOrOptions, options, true, true);
  dcInstance.useGen(true);
  return dcInstance.executeMutation('UpdateGroceryItemStatus', inputVars, inputOpts);
}
exports.updateGroceryItemStatus = updateGroceryItemStatus;

function deleteGroceryItem(dcOrVarsOrOptions, varsOrOptions, options) {
  const { dc: dcInstance, vars: inputVars, options: inputOpts} = validateAdminArgs(connectorConfig, dcOrVarsOrOptions, varsOrOptions, options, true, true);
  dcInstance.useGen(true);
  return dcInstance.executeMutation('DeleteGroceryItem', inputVars, inputOpts);
}
exports.deleteGroceryItem = deleteGroceryItem;

function createTaskFromTemplate(dcOrVarsOrOptions, varsOrOptions, options) {
  const { dc: dcInstance, vars: inputVars, options: inputOpts} = validateAdminArgs(connectorConfig, dcOrVarsOrOptions, varsOrOptions, options, true, true);
  dcInstance.useGen(true);
  return dcInstance.executeMutation('CreateTaskFromTemplate', inputVars, inputOpts);
}
exports.createTaskFromTemplate = createTaskFromTemplate;

function myProfile(dcOrOptions, options) {
  const { dc: dcInstance, options: inputOpts} = validateAdminArgs(connectorConfig, dcOrOptions, options, undefined);
  dcInstance.useGen(true);
  return dcInstance.executeQuery('MyProfile', undefined, inputOpts);
}
exports.myProfile = myProfile;

function taskNotificationDetails(dcOrVarsOrOptions, varsOrOptions, options) {
  const { dc: dcInstance, vars: inputVars, options: inputOpts} = validateAdminArgs(connectorConfig, dcOrVarsOrOptions, varsOrOptions, options, true, true);
  dcInstance.useGen(true);
  return dcInstance.executeQuery('TaskNotificationDetails', inputVars, inputOpts);
}
exports.taskNotificationDetails = taskNotificationDetails;

function myMembership(dcOrOptions, options) {
  const { dc: dcInstance, options: inputOpts} = validateAdminArgs(connectorConfig, dcOrOptions, options, undefined);
  dcInstance.useGen(true);
  return dcInstance.executeQuery('MyMembership', undefined, inputOpts);
}
exports.myMembership = myMembership;

function pendingMyMembership(dcOrOptions, options) {
  const { dc: dcInstance, options: inputOpts} = validateAdminArgs(connectorConfig, dcOrOptions, options, undefined);
  dcInstance.useGen(true);
  return dcInstance.executeQuery('PendingMyMembership', undefined, inputOpts);
}
exports.pendingMyMembership = pendingMyMembership;

function myMembershipById(dcOrVarsOrOptions, varsOrOptions, options) {
  const { dc: dcInstance, vars: inputVars, options: inputOpts} = validateAdminArgs(connectorConfig, dcOrVarsOrOptions, varsOrOptions, options, true, true);
  dcInstance.useGen(true);
  return dcInstance.executeQuery('MyMembershipById', inputVars, inputOpts);
}
exports.myMembershipById = myMembershipById;

function myHouseholdInvites(dcOrOptions, options) {
  const { dc: dcInstance, options: inputOpts} = validateAdminArgs(connectorConfig, dcOrOptions, options, undefined);
  dcInstance.useGen(true);
  return dcInstance.executeQuery('MyHouseholdInvites', undefined, inputOpts);
}
exports.myHouseholdInvites = myHouseholdInvites;

function householdMembers(dcOrVarsOrOptions, varsOrOptions, options) {
  const { dc: dcInstance, vars: inputVars, options: inputOpts} = validateAdminArgs(connectorConfig, dcOrVarsOrOptions, varsOrOptions, options, true, true);
  dcInstance.useGen(true);
  return dcInstance.executeQuery('HouseholdMembers', inputVars, inputOpts);
}
exports.householdMembers = householdMembers;

function userIdByEmail(dcOrVarsOrOptions, varsOrOptions, options) {
  const { dc: dcInstance, vars: inputVars, options: inputOpts} = validateAdminArgs(connectorConfig, dcOrVarsOrOptions, varsOrOptions, options, true, true);
  dcInstance.useGen(true);
  return dcInstance.executeQuery('UserIdByEmail', inputVars, inputOpts);
}
exports.userIdByEmail = userIdByEmail;

function maidProfileByEmail(dcOrVarsOrOptions, varsOrOptions, options) {
  const { dc: dcInstance, vars: inputVars, options: inputOpts} = validateAdminArgs(connectorConfig, dcOrVarsOrOptions, varsOrOptions, options, true, true);
  dcInstance.useGen(true);
  return dcInstance.executeQuery('MaidProfileByEmail', inputVars, inputOpts);
}
exports.maidProfileByEmail = maidProfileByEmail;

function availableMaids(dcOrOptions, options) {
  const { dc: dcInstance, options: inputOpts} = validateAdminArgs(connectorConfig, dcOrOptions, options, undefined);
  dcInstance.useGen(true);
  return dcInstance.executeQuery('AvailableMaids', undefined, inputOpts);
}
exports.availableMaids = availableMaids;

function currentContract(dcOrVarsOrOptions, varsOrOptions, options) {
  const { dc: dcInstance, vars: inputVars, options: inputOpts} = validateAdminArgs(connectorConfig, dcOrVarsOrOptions, varsOrOptions, options, true, true);
  dcInstance.useGen(true);
  return dcInstance.executeQuery('CurrentContract', inputVars, inputOpts);
}
exports.currentContract = currentContract;

function householdTasksForDay(dcOrVarsOrOptions, varsOrOptions, options) {
  const { dc: dcInstance, vars: inputVars, options: inputOpts} = validateAdminArgs(connectorConfig, dcOrVarsOrOptions, varsOrOptions, options, true, true);
  dcInstance.useGen(true);
  return dcInstance.executeQuery('HouseholdTasksForDay', inputVars, inputOpts);
}
exports.householdTasksForDay = householdTasksForDay;

function myTasksForDay(dcOrVarsOrOptions, varsOrOptions, options) {
  const { dc: dcInstance, vars: inputVars, options: inputOpts} = validateAdminArgs(connectorConfig, dcOrVarsOrOptions, varsOrOptions, options, true, true);
  dcInstance.useGen(true);
  return dcInstance.executeQuery('MyTasksForDay', inputVars, inputOpts);
}
exports.myTasksForDay = myTasksForDay;

function libraryTasks(dcOrOptions, options) {
  const { dc: dcInstance, options: inputOpts} = validateAdminArgs(connectorConfig, dcOrOptions, options, undefined);
  dcInstance.useGen(true);
  return dcInstance.executeQuery('LibraryTasks', undefined, inputOpts);
}
exports.libraryTasks = libraryTasks;

function holidays(dcOrOptions, options) {
  const { dc: dcInstance, options: inputOpts} = validateAdminArgs(connectorConfig, dcOrOptions, options, undefined);
  dcInstance.useGen(true);
  return dcInstance.executeQuery('Holidays', undefined, inputOpts);
}
exports.holidays = holidays;

function myAttendance(dcOrOptions, options) {
  const { dc: dcInstance, options: inputOpts} = validateAdminArgs(connectorConfig, dcOrOptions, options, undefined);
  dcInstance.useGen(true);
  return dcInstance.executeQuery('MyAttendance', undefined, inputOpts);
}
exports.myAttendance = myAttendance;

function householdAttendance(dcOrVarsOrOptions, varsOrOptions, options) {
  const { dc: dcInstance, vars: inputVars, options: inputOpts} = validateAdminArgs(connectorConfig, dcOrVarsOrOptions, varsOrOptions, options, true, true);
  dcInstance.useGen(true);
  return dcInstance.executeQuery('HouseholdAttendance', inputVars, inputOpts);
}
exports.householdAttendance = householdAttendance;

function myLeaveRequests(dcOrOptions, options) {
  const { dc: dcInstance, options: inputOpts} = validateAdminArgs(connectorConfig, dcOrOptions, options, undefined);
  dcInstance.useGen(true);
  return dcInstance.executeQuery('MyLeaveRequests', undefined, inputOpts);
}
exports.myLeaveRequests = myLeaveRequests;

function householdLeaveRequests(dcOrVarsOrOptions, varsOrOptions, options) {
  const { dc: dcInstance, vars: inputVars, options: inputOpts} = validateAdminArgs(connectorConfig, dcOrVarsOrOptions, varsOrOptions, options, true, true);
  dcInstance.useGen(true);
  return dcInstance.executeQuery('HouseholdLeaveRequests', inputVars, inputOpts);
}
exports.householdLeaveRequests = householdLeaveRequests;

function mySalaryPayments(dcOrOptions, options) {
  const { dc: dcInstance, options: inputOpts} = validateAdminArgs(connectorConfig, dcOrOptions, options, undefined);
  dcInstance.useGen(true);
  return dcInstance.executeQuery('MySalaryPayments', undefined, inputOpts);
}
exports.mySalaryPayments = mySalaryPayments;

function householdSalaryPayments(dcOrVarsOrOptions, varsOrOptions, options) {
  const { dc: dcInstance, vars: inputVars, options: inputOpts} = validateAdminArgs(connectorConfig, dcOrVarsOrOptions, varsOrOptions, options, true, true);
  dcInstance.useGen(true);
  return dcInstance.executeQuery('HouseholdSalaryPayments', inputVars, inputOpts);
}
exports.householdSalaryPayments = householdSalaryPayments;

function myAdvanceRequests(dcOrOptions, options) {
  const { dc: dcInstance, options: inputOpts} = validateAdminArgs(connectorConfig, dcOrOptions, options, undefined);
  dcInstance.useGen(true);
  return dcInstance.executeQuery('MyAdvanceRequests', undefined, inputOpts);
}
exports.myAdvanceRequests = myAdvanceRequests;

function householdAdvanceRequests(dcOrVarsOrOptions, varsOrOptions, options) {
  const { dc: dcInstance, vars: inputVars, options: inputOpts} = validateAdminArgs(connectorConfig, dcOrVarsOrOptions, varsOrOptions, options, true, true);
  dcInstance.useGen(true);
  return dcInstance.executeQuery('HouseholdAdvanceRequests', inputVars, inputOpts);
}
exports.householdAdvanceRequests = householdAdvanceRequests;

function adminHouseholds(dcOrOptions, options) {
  const { dc: dcInstance, options: inputOpts} = validateAdminArgs(connectorConfig, dcOrOptions, options, undefined);
  dcInstance.useGen(true);
  return dcInstance.executeQuery('AdminHouseholds', undefined, inputOpts);
}
exports.adminHouseholds = adminHouseholds;

function adminPaymentPlans(dcOrOptions, options) {
  const { dc: dcInstance, options: inputOpts} = validateAdminArgs(connectorConfig, dcOrOptions, options, undefined);
  dcInstance.useGen(true);
  return dcInstance.executeQuery('AdminPaymentPlans', undefined, inputOpts);
}
exports.adminPaymentPlans = adminPaymentPlans;

function getGroceryItems(dcOrVarsOrOptions, varsOrOptions, options) {
  const { dc: dcInstance, vars: inputVars, options: inputOpts} = validateAdminArgs(connectorConfig, dcOrVarsOrOptions, varsOrOptions, options, true, true);
  dcInstance.useGen(true);
  return dcInstance.executeQuery('GetGroceryItems', inputVars, inputOpts);
}
exports.getGroceryItems = getGroceryItems;

function activeTaskTemplates(dcOrVarsOrOptions, varsOrOptions, options) {
  const { dc: dcInstance, vars: inputVars, options: inputOpts} = validateAdminArgs(connectorConfig, dcOrVarsOrOptions, varsOrOptions, options, true, true);
  dcInstance.useGen(true);
  return dcInstance.executeQuery('ActiveTaskTemplates', inputVars, inputOpts);
}
exports.activeTaskTemplates = activeTaskTemplates;

