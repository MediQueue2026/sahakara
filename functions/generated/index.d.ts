import { ConnectorConfig, DataConnect, OperationOptions, ExecuteOperationResponse } from 'firebase-admin/data-connect';

export const connectorConfig: ConnectorConfig;

export type TimestampString = string;
export type UUIDString = string;
export type Int64String = string;
export type DateString = string;

export enum AccountType {
  owner = "owner",
  maid = "maid",
  admin = "admin",
}
export enum AdvanceRequestStatus {
  pending = "pending",
  approved = "approved",
  rejected = "rejected",
}
export enum AppLanguage {
  si = "si",
  ta = "ta",
  en = "en",
}
export enum AttendanceDayType {
  full = "full",
  half = "half",
  late = "late",
  early_leave = "early_leave",
  leave = "leave",
  absent = "absent",
  holiday = "holiday",
}
export enum BillingPeriod {
  monthly = "monthly",
  yearly = "yearly",
}
export enum CantDoReason {
  no_supplies = "no_supplies",
  power_cut = "power_cut",
  water_cut = "water_cut",
  sick = "sick",
  no_time = "no_time",
  other = "other",
}
export enum HolidayType {
  poya = "poya",
  public = "public",
  festival = "festival",
}
export enum LeaveStatus {
  pending = "pending",
  approved = "approved",
  rejected = "rejected",
}
export enum LeaveType {
  paid = "paid",
  unpaid = "unpaid",
  sick = "sick",
}
export enum MemberRole {
  owner = "owner",
  adult = "adult",
  maid = "maid",
  driver = "driver",
  cook = "cook",
  gardener = "gardener",
}
export enum MembershipStatus {
  pending = "pending",
  accepted = "accepted",
  declined = "declined",
}
export enum PayType {
  monthly = "monthly",
  daily = "daily",
  hourly = "hourly",
  per_visit = "per_visit",
}
export enum PaymentMethod {
  cash = "cash",
  bank = "bank",
  mobile_wallet = "mobile_wallet",
}
export enum RecurrenceType {
  once = "once",
  daily = "daily",
  weekly = "weekly",
  fortnightly = "fortnightly",
  monthly = "monthly",
  quarterly = "quarterly",
}
export enum SalaryPaymentStatus {
  scheduled = "scheduled",
  paid = "paid",
}
export enum TaskCategory {
  kitchen = "kitchen",
  cleaning = "cleaning",
  laundry = "laundry",
  cooking = "cooking",
  childcare = "childcare",
  elderly_care = "elderly_care",
  newborn_care = "newborn_care",
  pet_care = "pet_care",
  other = "other",
}
export enum TaskLogAction {
  started = "started",
  done = "done",
  help = "help",
  cant_do = "cant_do",
}
export enum TaskPriority {
  high = "high",
  medium = "medium",
  low = "low",
}
export enum TaskStatus {
  pending = "pending",
  started = "started",
  done = "done",
  need_help = "need_help",
  cant_do = "cant_do",
  carried_forward = "carried_forward",
}

export interface AcceptHouseholdInviteData {
  householdMember_update?: HouseholdMember_Key | null;
  contract_updateMany: number;
}

export interface AcceptHouseholdInviteVariables {
  id: UUIDString;
}

export interface ActiveTaskTemplatesData {
  taskTemplates: ({
    id: UUIDString;
    recurrence: RecurrenceType;
    recurrenceDay?: string | null;
  } & TaskTemplate_Key)[];
}

export interface ActiveTaskTemplatesVariables {
  householdId: UUIDString;
}

export interface AddAttendanceRecordData {
  attendance_insert: Attendance_Key;
}

export interface AddAttendanceRecordVariables {
  memberId: UUIDString;
  day: DateString;
  checkIn: TimestampString;
  checkOut?: TimestampString | null;
  dayType: AttendanceDayType;
  overtimeHours: number;
  note?: string | null;
}

export interface AddDailyTaskData {
  taskTemplate_insert: TaskTemplate_Key;
  task_insert: Task_Key;
}

export interface AddDailyTaskVariables {
  householdId: UUIDString;
  assignedToId?: UUIDString | null;
  dueDate: DateString;
  libraryId?: UUIDString | null;
  customTitle?: string | null;
  customTitleSi?: string | null;
  customTitleTa?: string | null;
  estMinutes?: number | null;
  priority: TaskPriority;
  photoUrl?: string | null;
  recurrence?: RecurrenceType | null;
}

export interface AddGroceryItemData {
  groceryItem_insert: GroceryItem_Key;
}

export interface AddGroceryItemVariables {
  householdId: UUIDString;
  nameEn: string;
  nameSi?: string | null;
  nameTa?: string | null;
}

export interface AddHolidayData {
  holiday_insert: Holiday_Key;
}

export interface AddHolidayVariables {
  date: DateString;
  type: HolidayType;
  nameEn: string;
  nameSi?: string | null;
  nameTa?: string | null;
}

export interface AddHouseholdMemberData {
  householdMember_insert: HouseholdMember_Key;
  contract_insert: Contract_Key;
}

export interface AddHouseholdMemberVariables {
  householdId: UUIDString;
  userId: UUIDString;
  role: MemberRole;
  payType: PayType;
  rate: number;
  allowance?: number | null;
  durationMonths?: number | null;
  durationDays?: number | null;
  offDays?: string | null;
  workingHours?: string | null;
}

export interface AddLibraryTaskData {
  libraryTask_insert: LibraryTask_Key;
}

export interface AddLibraryTaskVariables {
  category: TaskCategory;
  nameEn: string;
  nameSi?: string | null;
  nameTa?: string | null;
}

export interface AddPaymentPlanData {
  paymentPlan_insert: PaymentPlan_Key;
}

export interface AddPaymentPlanVariables {
  name: string;
  price: number;
  billingPeriod: BillingPeriod;
  description?: string | null;
}

export interface AdminHouseholdsData {
  households: ({
    id: UUIDString;
    name: string;
    address?: string | null;
    createdAt: TimestampString;
    householdMembers_on_household: ({
      id: UUIDString;
    } & HouseholdMember_Key)[];
    householdSubscription_on_household?: {
      price: number;
      paidUntil?: DateString | null;
      plan: {
        id: UUIDString;
        name: string;
        billingPeriod: BillingPeriod;
      } & PaymentPlan_Key;
    };
  } & Household_Key)[];
}

export interface AdminPaymentPlansData {
  paymentPlans: ({
    id: UUIDString;
    name: string;
    price: number;
    billingPeriod: BillingPeriod;
    description?: string | null;
    householdSubscriptions_on_plan: ({
      householdId: UUIDString;
    } & HouseholdSubscription_Key)[];
  } & PaymentPlan_Key)[];
}

export interface AdvanceRequest_Key {
  id: UUIDString;
  __typename?: 'AdvanceRequest_Key';
}

export interface Advance_Key {
  id: UUIDString;
  __typename?: 'Advance_Key';
}

export interface ApproveAdvanceRequestData {
  advance_insert: Advance_Key;
  advanceRequest_update?: AdvanceRequest_Key | null;
  ledgerEntry_insert: LedgerEntry_Key;
}

export interface ApproveAdvanceRequestVariables {
  id: UUIDString;
  month: string;
}

export interface AssignDailyTaskData {
  task_update?: Task_Key | null;
}

export interface AssignDailyTaskVariables {
  id: UUIDString;
  assignedToId: UUIDString;
}

export interface Attendance_Key {
  id: UUIDString;
  __typename?: 'Attendance_Key';
}

export interface AvailableMaidsData {
  users: ({
    id: UUIDString;
    name: string;
    preferredAreas?: string[] | null;
    spokenLanguages?: AppLanguage[] | null;
    workCategories?: TaskCategory[] | null;
  } & User_Key)[];
}

export interface Badge_Key {
  id: UUIDString;
  __typename?: 'Badge_Key';
}

export interface CancelHouseholdInviteData {
  contract_deleteMany: number;
  householdMember_deleteMany: number;
  householdMember_updateMany: number;
}

export interface CancelHouseholdInviteVariables {
  id: UUIDString;
}

export interface CheckInData {
  attendance_insert: Attendance_Key;
}

export interface CheckInVariables {
  memberId: UUIDString;
  day: DateString;
  dayType: AttendanceDayType;
}

export interface CheckOutData {
  attendance_updateMany: number;
}

export interface CheckOutVariables {
  memberId: UUIDString;
  day: DateString;
  overtimeHours: number;
}

export interface ClaimInvitedProfileData {
  user_updateMany: number;
}

export interface Contract_Key {
  id: UUIDString;
  __typename?: 'Contract_Key';
}

export interface CreateHouseholdData {
  household_insert: Household_Key;
  householdMember_insert: HouseholdMember_Key;
}

export interface CreateHouseholdVariables {
  name: string;
  address?: string | null;
}

export interface CreateMyProfileData {
  user_insert: User_Key;
}

export interface CreateMyProfileVariables {
  name: string;
  accountType: AccountType;
}

export interface CreateTaskFromTemplateData {
  task_insert: Task_Key;
}

export interface CreateTaskFromTemplateVariables {
  templateId: UUIDString;
  dueDate: DateString;
}

export interface CurrentContractData {
  contracts: ({
    id: UUIDString;
    payType: PayType;
    rate: number;
    allowance?: number | null;
    durationMonths?: number | null;
    durationDays?: number | null;
    offDays?: string | null;
    workingHours?: string | null;
    startDate: DateString;
  } & Contract_Key)[];
}

export interface CurrentContractVariables {
  memberId: UUIDString;
}

export interface DeclineHouseholdInviteData {
  householdMember_update?: HouseholdMember_Key | null;
}

export interface DeclineHouseholdInviteVariables {
  id: UUIDString;
}

export interface DeleteAttendanceRecordData {
  attendance_delete?: Attendance_Key | null;
}

export interface DeleteAttendanceRecordVariables {
  id: UUIDString;
}

export interface DeleteDailyTaskData {
  task_delete?: Task_Key | null;
  taskTemplate_deleteMany: number;
}

export interface DeleteDailyTaskVariables {
  id: UUIDString;
}

export interface DeleteGroceryItemData {
  groceryItem_delete?: GroceryItem_Key | null;
}

export interface DeleteGroceryItemVariables {
  id: UUIDString;
  householdId: UUIDString;
}

export interface DeleteHolidayData {
  holiday_delete?: Holiday_Key | null;
}

export interface DeleteHolidayVariables {
  id: UUIDString;
}

export interface DeleteLeaveRequestData {
  leaveRequest_delete?: LeaveRequest_Key | null;
}

export interface DeleteLeaveRequestVariables {
  id: UUIDString;
}

export interface DeleteLibraryTaskData {
  libraryTask_delete?: LibraryTask_Key | null;
}

export interface DeleteLibraryTaskVariables {
  id: UUIDString;
}

export interface DeletePaymentPlanData {
  paymentPlan_delete?: PaymentPlan_Key | null;
}

export interface DeletePaymentPlanVariables {
  id: UUIDString;
}

export interface Dispute_Key {
  id: UUIDString;
  __typename?: 'Dispute_Key';
}

export interface GetGroceryItemsData {
  groceryItems: ({
    id: UUIDString;
    nameEn: string;
    nameSi?: string | null;
    nameTa?: string | null;
    isBought: boolean;
    createdAt: TimestampString;
    addedBy: {
      name: string;
    };
    boughtBy?: {
      name: string;
    };
  } & GroceryItem_Key)[];
}

export interface GetGroceryItemsVariables {
  householdId: UUIDString;
}

export interface GroceryItem_Key {
  id: UUIDString;
  __typename?: 'GroceryItem_Key';
}

export interface Holiday_Key {
  id: UUIDString;
  __typename?: 'Holiday_Key';
}

export interface HolidaysData {
  holidays: ({
    id: UUIDString;
    date: DateString;
    type: HolidayType;
    nameEn: string;
    nameSi?: string | null;
    nameTa?: string | null;
  } & Holiday_Key)[];
}

export interface HouseholdAdvanceRequestsData {
  advanceRequests: ({
    id: UUIDString;
    amount: number;
    reason?: string | null;
    status: AdvanceRequestStatus;
    requestedAt: TimestampString;
    reviewedAt?: TimestampString | null;
    member: {
      id: UUIDString;
      user: {
        name: string;
      };
    } & HouseholdMember_Key;
  } & AdvanceRequest_Key)[];
}

export interface HouseholdAdvanceRequestsVariables {
  householdId: UUIDString;
}

export interface HouseholdAttendanceData {
  attendances: ({
    id: UUIDString;
    day: DateString;
    checkIn?: TimestampString | null;
    checkOut?: TimestampString | null;
    dayType: AttendanceDayType;
    overtimeHours: number;
    note?: string | null;
    member: {
      id: UUIDString;
      user: {
        name: string;
      };
    } & HouseholdMember_Key;
  } & Attendance_Key)[];
}

export interface HouseholdAttendanceVariables {
  householdId: UUIDString;
}

export interface HouseholdLeaveRequestsData {
  leaveRequests: ({
    id: UUIDString;
    fromDate: DateString;
    toDate: DateString;
    leaveType: LeaveType;
    isHalfDay: boolean;
    reason?: string | null;
    status: LeaveStatus;
    createdAt: TimestampString;
    member: {
      id: UUIDString;
      user: {
        name: string;
      };
    } & HouseholdMember_Key;
  } & LeaveRequest_Key)[];
}

export interface HouseholdLeaveRequestsVariables {
  householdId: UUIDString;
}

export interface HouseholdMember_Key {
  id: UUIDString;
  __typename?: 'HouseholdMember_Key';
}

export interface HouseholdMembersData {
  householdMembers: ({
    id: UUIDString;
    role: MemberRole;
    active: boolean;
    status: MembershipStatus;
    user: {
      id: UUIDString;
      name: string;
      email: string;
    } & User_Key;
  } & HouseholdMember_Key)[];
}

export interface HouseholdMembersVariables {
  householdId: UUIDString;
}

export interface HouseholdSalaryPaymentsData {
  salaryPayments: ({
    id: UUIDString;
    amount: number;
    paymentDate: DateString;
    status: SalaryPaymentStatus;
    note?: string | null;
    paidAt?: TimestampString | null;
    member: {
      id: UUIDString;
      user: {
        name: string;
      };
    } & HouseholdMember_Key;
  } & SalaryPayment_Key)[];
}

export interface HouseholdSalaryPaymentsVariables {
  householdId: UUIDString;
}

export interface HouseholdSubscription_Key {
  householdId: UUIDString;
  __typename?: 'HouseholdSubscription_Key';
}

export interface HouseholdTasksForDayData {
  tasks: ({
    id: UUIDString;
    status: TaskStatus;
    cantDoReason?: CantDoReason | null;
    statusNote?: string | null;
    statusNoteEn?: string | null;
    statusNoteSi?: string | null;
    statusNoteTa?: string | null;
    statusPhoto?: string | null;
    completedAt?: TimestampString | null;
    assignedTo?: {
      id: UUIDString;
      user: {
        name: string;
      };
    } & HouseholdMember_Key;
    template: {
      id: UUIDString;
      customTitle?: string | null;
      customTitleSi?: string | null;
      customTitleTa?: string | null;
      photoUrl?: string | null;
      estMinutes?: number | null;
      priority: TaskPriority;
      library?: {
        category: TaskCategory;
        nameEn: string;
        nameSi?: string | null;
        nameTa?: string | null;
      };
    } & TaskTemplate_Key;
  } & Task_Key)[];
}

export interface HouseholdTasksForDayVariables {
  householdId: UUIDString;
  dueDate: DateString;
}

export interface Household_Key {
  id: UUIDString;
  __typename?: 'Household_Key';
}

export interface InviteHouseholdMemberData {
  user_insert: User_Key;
  householdMember_insert: HouseholdMember_Key;
  contract_insert: Contract_Key;
}

export interface InviteHouseholdMemberVariables {
  householdId: UUIDString;
  email: string;
  role: MemberRole;
  payType: PayType;
  rate: number;
  allowance?: number | null;
  durationMonths?: number | null;
  durationDays?: number | null;
  offDays?: string | null;
  workingHours?: string | null;
}

export interface LeaveRequest_Key {
  id: UUIDString;
  __typename?: 'LeaveRequest_Key';
}

export interface LedgerEntry_Key {
  id: UUIDString;
  __typename?: 'LedgerEntry_Key';
}

export interface LibraryTask_Key {
  id: UUIDString;
  __typename?: 'LibraryTask_Key';
}

export interface LibraryTasksData {
  libraryTasks: ({
    id: UUIDString;
    category: TaskCategory;
    nameEn: string;
    nameSi?: string | null;
    nameTa?: string | null;
  } & LibraryTask_Key)[];
}

export interface MaidProfileByEmailData {
  users: ({
    name: string;
    preferredAreas?: string[] | null;
    spokenLanguages?: AppLanguage[] | null;
    workCategories?: TaskCategory[] | null;
  })[];
}

export interface MaidProfileByEmailVariables {
  email: string;
}

export interface MarkSalaryPaymentPaidData {
  salaryPayment_update?: SalaryPayment_Key | null;
  ledgerEntry_insert: LedgerEntry_Key;
}

export interface MarkSalaryPaymentPaidVariables {
  id: UUIDString;
  month: string;
  method: PaymentMethod;
}

export interface MemberDocument_Key {
  id: UUIDString;
  __typename?: 'MemberDocument_Key';
}

export interface Message_Key {
  id: UUIDString;
  __typename?: 'Message_Key';
}

export interface MyAdvanceRequestsData {
  advanceRequests: ({
    id: UUIDString;
    amount: number;
    reason?: string | null;
    status: AdvanceRequestStatus;
    requestedAt: TimestampString;
    reviewedAt?: TimestampString | null;
  } & AdvanceRequest_Key)[];
}

export interface MyAttendanceData {
  attendances: ({
    id: UUIDString;
    day: DateString;
    checkIn?: TimestampString | null;
    checkOut?: TimestampString | null;
    dayType: AttendanceDayType;
    overtimeHours: number;
    note?: string | null;
  } & Attendance_Key)[];
}

export interface MyHouseholdInvitesData {
  householdMembers: ({
    id: UUIDString;
    role: MemberRole;
    active: boolean;
    status: MembershipStatus;
    household: {
      name: string;
      area?: string | null;
      owner: {
        name: string;
        spokenLanguages?: AppLanguage[] | null;
      };
    };
    contracts_on_member: ({
      payType: PayType;
      rate: number;
      allowance?: number | null;
      durationMonths?: number | null;
      durationDays?: number | null;
      offDays?: string | null;
      workingHours?: string | null;
    })[];
  } & HouseholdMember_Key)[];
}

export interface MyLeaveRequestsData {
  leaveRequests: ({
    id: UUIDString;
    fromDate: DateString;
    toDate: DateString;
    leaveType: LeaveType;
    isHalfDay: boolean;
    reason?: string | null;
    status: LeaveStatus;
    createdAt: TimestampString;
  } & LeaveRequest_Key)[];
}

export interface MyMembershipByIdData {
  householdMembers: ({
    id: UUIDString;
    role: MemberRole;
    household: {
      id: UUIDString;
      name: string;
      address?: string | null;
      area?: string | null;
    } & Household_Key;
  } & HouseholdMember_Key)[];
}

export interface MyMembershipByIdVariables {
  id: UUIDString;
}

export interface MyMembershipData {
  householdMembers: ({
    id: UUIDString;
    role: MemberRole;
    household: {
      id: UUIDString;
      name: string;
      address?: string | null;
      area?: string | null;
    } & Household_Key;
  } & HouseholdMember_Key)[];
}

export interface MyProfileData {
  users: ({
    id: UUIDString;
    authUid?: string | null;
    email: string;
    name: string;
    accountType: AccountType;
    language: AppLanguage;
    preferredAreas?: string[] | null;
    spokenLanguages?: AppLanguage[] | null;
    workCategories?: TaskCategory[] | null;
  } & User_Key)[];
}

export interface MySalaryPaymentsData {
  salaryPayments: ({
    id: UUIDString;
    amount: number;
    paymentDate: DateString;
    status: SalaryPaymentStatus;
    note?: string | null;
    paidAt?: TimestampString | null;
  } & SalaryPayment_Key)[];
}

export interface MyTasksForDayData {
  tasks: ({
    id: UUIDString;
    status: TaskStatus;
    cantDoReason?: CantDoReason | null;
    statusNote?: string | null;
    statusNoteEn?: string | null;
    statusNoteSi?: string | null;
    statusNoteTa?: string | null;
    statusPhoto?: string | null;
    completedAt?: TimestampString | null;
    template: {
      customTitle?: string | null;
      customTitleSi?: string | null;
      customTitleTa?: string | null;
      photoUrl?: string | null;
      estMinutes?: number | null;
      priority: TaskPriority;
      library?: {
        category: TaskCategory;
        nameEn: string;
        nameSi?: string | null;
        nameTa?: string | null;
      };
    };
  } & Task_Key)[];
}

export interface MyTasksForDayVariables {
  dueDate: DateString;
}

export interface PaymentPlan_Key {
  id: UUIDString;
  __typename?: 'PaymentPlan_Key';
}

export interface Payslip_Key {
  id: UUIDString;
  __typename?: 'Payslip_Key';
}

export interface PendingMyMembershipData {
  householdMembers: ({
    id: UUIDString;
    role: MemberRole;
    household: {
      id: UUIDString;
      name: string;
      address?: string | null;
      area?: string | null;
    } & Household_Key;
  } & HouseholdMember_Key)[];
}

export interface ReinviteHouseholdMemberData {
  householdMember_updateMany: number;
  contract_insert: Contract_Key;
}

export interface ReinviteHouseholdMemberVariables {
  householdId: UUIDString;
  userId: UUIDString;
  role: MemberRole;
  payType: PayType;
  rate: number;
  allowance?: number | null;
  durationMonths?: number | null;
  durationDays?: number | null;
  offDays?: string | null;
  workingHours?: string | null;
}

export interface RejectAdvanceRequestData {
  advanceRequest_update?: AdvanceRequest_Key | null;
}

export interface RejectAdvanceRequestVariables {
  id: UUIDString;
}

export interface RemoveHouseholdMemberData {
  householdMember_update?: HouseholdMember_Key | null;
  contract_updateMany: number;
  task_updateMany: number;
}

export interface RemoveHouseholdMemberVariables {
  id: UUIDString;
}

export interface RemoveInvalidFcmTokenData {
  userDeviceToken_deleteMany: number;
}

export interface RemoveInvalidFcmTokenVariables {
  token: string;
}

export interface RemoveMyFcmTokenData {
  userDeviceToken_deleteMany: number;
}

export interface RemoveMyFcmTokenVariables {
  token: string;
}

export interface RequestAdvanceData {
  advanceRequest_insert: AdvanceRequest_Key;
}

export interface RequestAdvanceVariables {
  memberId: UUIDString;
  amount: number;
  reason?: string | null;
}

export interface ReviewLeaveRequestData {
  leaveRequest_update?: LeaveRequest_Key | null;
}

export interface ReviewLeaveRequestVariables {
  id: UUIDString;
  status: LeaveStatus;
}

export interface SalaryPayment_Key {
  id: UUIDString;
  __typename?: 'SalaryPayment_Key';
}

export interface SaveContractData {
  contract_updateMany: number;
  contract_insert: Contract_Key;
}

export interface SaveContractVariables {
  memberId: UUIDString;
  payType: PayType;
  rate: number;
  allowance?: number | null;
  durationMonths?: number | null;
  durationDays?: number | null;
  offDays?: string | null;
  workingHours?: string | null;
}

export interface SaveMyFcmTokenData {
  userDeviceToken_deleteMany: number;
  userDeviceToken_insert: UserDeviceToken_Key;
}

export interface SaveMyFcmTokenVariables {
  token: string;
  previousToken?: string | null;
}

export interface ScheduleSalaryPaymentData {
  salaryPayment_insert: SalaryPayment_Key;
}

export interface ScheduleSalaryPaymentVariables {
  memberId: UUIDString;
  amount: number;
  paymentDate: DateString;
  note?: string | null;
}

export interface SetHouseholdAreaData {
  household_updateMany: number;
}

export interface SetHouseholdAreaVariables {
  householdId: UUIDString;
  area?: string | null;
}

export interface SetHouseholdPlanData {
  householdSubscription_upsert: HouseholdSubscription_Key;
}

export interface SetHouseholdPlanVariables {
  householdId: UUIDString;
  planId: UUIDString;
  price: number;
}

export interface SetMyLanguageData {
  user_updateMany: number;
}

export interface SetMyLanguageVariables {
  language: AppLanguage;
}

export interface SetMyNameData {
  user_updateMany: number;
}

export interface SetMyNameVariables {
  name: string;
}

export interface SetMyProfileData {
  user_updateMany: number;
}

export interface SetMyProfileVariables {
  name: string;
  preferredAreas: string[];
  spokenLanguages: AppLanguage[];
  workCategories?: TaskCategory[] | null;
}

export interface ShoppingItem_Key {
  id: UUIDString;
  __typename?: 'ShoppingItem_Key';
}

export interface Star_Key {
  id: UUIDString;
  __typename?: 'Star_Key';
}

export interface SubmitLeaveRequestData {
  leaveRequest_insert: LeaveRequest_Key;
}

export interface SubmitLeaveRequestVariables {
  memberId: UUIDString;
  fromDate: DateString;
  toDate: DateString;
  leaveType: LeaveType;
  isHalfDay: boolean;
  reason?: string | null;
}

export interface TaskLog_Key {
  id: UUIDString;
  __typename?: 'TaskLog_Key';
}

export interface TaskNotificationDetailsData {
  tasks: ({
    id: UUIDString;
    assignedTo?: {
      id: UUIDString;
      user: {
        language: AppLanguage;
        userDeviceTokens_on_user: ({
          token: string;
        })[];
      };
    } & HouseholdMember_Key;
    template: {
      customTitle?: string | null;
      customTitleSi?: string | null;
      customTitleTa?: string | null;
      library?: {
        nameEn: string;
        nameSi?: string | null;
        nameTa?: string | null;
      };
      household: {
        name: string;
      };
    };
  } & Task_Key)[];
}

export interface TaskNotificationDetailsVariables {
  taskId: UUIDString;
}

export interface TaskTemplate_Key {
  id: UUIDString;
  __typename?: 'TaskTemplate_Key';
}

export interface Task_Key {
  id: UUIDString;
  __typename?: 'Task_Key';
}

export interface UpdateAttendanceRecordData {
  attendance_update?: Attendance_Key | null;
}

export interface UpdateAttendanceRecordVariables {
  id: UUIDString;
  checkIn: TimestampString;
  checkOut?: TimestampString | null;
  dayType: AttendanceDayType;
  overtimeHours: number;
  note?: string | null;
}

export interface UpdateGroceryItemStatusData {
  groceryItem_update?: GroceryItem_Key | null;
}

export interface UpdateGroceryItemStatusVariables {
  id: UUIDString;
  householdId: UUIDString;
  isBought: boolean;
}

export interface UpdateMyTaskStatusData {
  task_update?: Task_Key | null;
  done: number;
  notDone: number;
  taskLog_insert: TaskLog_Key;
}

export interface UpdateMyTaskStatusVariables {
  id: UUIDString;
  status: TaskStatus;
  action: TaskLogAction;
  cantDoReason?: CantDoReason | null;
  note?: string | null;
  noteEn?: string | null;
  noteSi?: string | null;
  noteTa?: string | null;
  photoUrl?: string | null;
}

export interface UserDeviceToken_Key {
  id: UUIDString;
  __typename?: 'UserDeviceToken_Key';
}

export interface UserIdByEmailData {
  users: ({
    id: UUIDString;
  } & User_Key)[];
}

export interface UserIdByEmailVariables {
  email: string;
}

export interface User_Key {
  id: UUIDString;
  __typename?: 'User_Key';
}

/** Generated Node Admin SDK operation action function for the 'ClaimInvitedProfile' Mutation. Allow users to execute without passing in DataConnect. */
export function claimInvitedProfile(dc: DataConnect, options?: OperationOptions): Promise<ExecuteOperationResponse<ClaimInvitedProfileData>>;
/** Generated Node Admin SDK operation action function for the 'ClaimInvitedProfile' Mutation. Allow users to pass in custom DataConnect instances. */
export function claimInvitedProfile(options?: OperationOptions): Promise<ExecuteOperationResponse<ClaimInvitedProfileData>>;

/** Generated Node Admin SDK operation action function for the 'CreateMyProfile' Mutation. Allow users to execute without passing in DataConnect. */
export function createMyProfile(dc: DataConnect, vars: CreateMyProfileVariables, options?: OperationOptions): Promise<ExecuteOperationResponse<CreateMyProfileData>>;
/** Generated Node Admin SDK operation action function for the 'CreateMyProfile' Mutation. Allow users to pass in custom DataConnect instances. */
export function createMyProfile(vars: CreateMyProfileVariables, options?: OperationOptions): Promise<ExecuteOperationResponse<CreateMyProfileData>>;

/** Generated Node Admin SDK operation action function for the 'SetMyName' Mutation. Allow users to execute without passing in DataConnect. */
export function setMyName(dc: DataConnect, vars: SetMyNameVariables, options?: OperationOptions): Promise<ExecuteOperationResponse<SetMyNameData>>;
/** Generated Node Admin SDK operation action function for the 'SetMyName' Mutation. Allow users to pass in custom DataConnect instances. */
export function setMyName(vars: SetMyNameVariables, options?: OperationOptions): Promise<ExecuteOperationResponse<SetMyNameData>>;

/** Generated Node Admin SDK operation action function for the 'SetMyProfile' Mutation. Allow users to execute without passing in DataConnect. */
export function setMyProfile(dc: DataConnect, vars: SetMyProfileVariables, options?: OperationOptions): Promise<ExecuteOperationResponse<SetMyProfileData>>;
/** Generated Node Admin SDK operation action function for the 'SetMyProfile' Mutation. Allow users to pass in custom DataConnect instances. */
export function setMyProfile(vars: SetMyProfileVariables, options?: OperationOptions): Promise<ExecuteOperationResponse<SetMyProfileData>>;

/** Generated Node Admin SDK operation action function for the 'SetMyLanguage' Mutation. Allow users to execute without passing in DataConnect. */
export function setMyLanguage(dc: DataConnect, vars: SetMyLanguageVariables, options?: OperationOptions): Promise<ExecuteOperationResponse<SetMyLanguageData>>;
/** Generated Node Admin SDK operation action function for the 'SetMyLanguage' Mutation. Allow users to pass in custom DataConnect instances. */
export function setMyLanguage(vars: SetMyLanguageVariables, options?: OperationOptions): Promise<ExecuteOperationResponse<SetMyLanguageData>>;

/** Generated Node Admin SDK operation action function for the 'SaveMyFcmToken' Mutation. Allow users to execute without passing in DataConnect. */
export function saveMyFcmToken(dc: DataConnect, vars: SaveMyFcmTokenVariables, options?: OperationOptions): Promise<ExecuteOperationResponse<SaveMyFcmTokenData>>;
/** Generated Node Admin SDK operation action function for the 'SaveMyFcmToken' Mutation. Allow users to pass in custom DataConnect instances. */
export function saveMyFcmToken(vars: SaveMyFcmTokenVariables, options?: OperationOptions): Promise<ExecuteOperationResponse<SaveMyFcmTokenData>>;

/** Generated Node Admin SDK operation action function for the 'RemoveMyFcmToken' Mutation. Allow users to execute without passing in DataConnect. */
export function removeMyFcmToken(dc: DataConnect, vars: RemoveMyFcmTokenVariables, options?: OperationOptions): Promise<ExecuteOperationResponse<RemoveMyFcmTokenData>>;
/** Generated Node Admin SDK operation action function for the 'RemoveMyFcmToken' Mutation. Allow users to pass in custom DataConnect instances. */
export function removeMyFcmToken(vars: RemoveMyFcmTokenVariables, options?: OperationOptions): Promise<ExecuteOperationResponse<RemoveMyFcmTokenData>>;

/** Generated Node Admin SDK operation action function for the 'RemoveInvalidFcmToken' Mutation. Allow users to execute without passing in DataConnect. */
export function removeInvalidFcmToken(dc: DataConnect, vars: RemoveInvalidFcmTokenVariables, options?: OperationOptions): Promise<ExecuteOperationResponse<RemoveInvalidFcmTokenData>>;
/** Generated Node Admin SDK operation action function for the 'RemoveInvalidFcmToken' Mutation. Allow users to pass in custom DataConnect instances. */
export function removeInvalidFcmToken(vars: RemoveInvalidFcmTokenVariables, options?: OperationOptions): Promise<ExecuteOperationResponse<RemoveInvalidFcmTokenData>>;

/** Generated Node Admin SDK operation action function for the 'SetHouseholdArea' Mutation. Allow users to execute without passing in DataConnect. */
export function setHouseholdArea(dc: DataConnect, vars: SetHouseholdAreaVariables, options?: OperationOptions): Promise<ExecuteOperationResponse<SetHouseholdAreaData>>;
/** Generated Node Admin SDK operation action function for the 'SetHouseholdArea' Mutation. Allow users to pass in custom DataConnect instances. */
export function setHouseholdArea(vars: SetHouseholdAreaVariables, options?: OperationOptions): Promise<ExecuteOperationResponse<SetHouseholdAreaData>>;

/** Generated Node Admin SDK operation action function for the 'CreateHousehold' Mutation. Allow users to execute without passing in DataConnect. */
export function createHousehold(dc: DataConnect, vars: CreateHouseholdVariables, options?: OperationOptions): Promise<ExecuteOperationResponse<CreateHouseholdData>>;
/** Generated Node Admin SDK operation action function for the 'CreateHousehold' Mutation. Allow users to pass in custom DataConnect instances. */
export function createHousehold(vars: CreateHouseholdVariables, options?: OperationOptions): Promise<ExecuteOperationResponse<CreateHouseholdData>>;

/** Generated Node Admin SDK operation action function for the 'AddHouseholdMember' Mutation. Allow users to execute without passing in DataConnect. */
export function addHouseholdMember(dc: DataConnect, vars: AddHouseholdMemberVariables, options?: OperationOptions): Promise<ExecuteOperationResponse<AddHouseholdMemberData>>;
/** Generated Node Admin SDK operation action function for the 'AddHouseholdMember' Mutation. Allow users to pass in custom DataConnect instances. */
export function addHouseholdMember(vars: AddHouseholdMemberVariables, options?: OperationOptions): Promise<ExecuteOperationResponse<AddHouseholdMemberData>>;

/** Generated Node Admin SDK operation action function for the 'InviteHouseholdMember' Mutation. Allow users to execute without passing in DataConnect. */
export function inviteHouseholdMember(dc: DataConnect, vars: InviteHouseholdMemberVariables, options?: OperationOptions): Promise<ExecuteOperationResponse<InviteHouseholdMemberData>>;
/** Generated Node Admin SDK operation action function for the 'InviteHouseholdMember' Mutation. Allow users to pass in custom DataConnect instances. */
export function inviteHouseholdMember(vars: InviteHouseholdMemberVariables, options?: OperationOptions): Promise<ExecuteOperationResponse<InviteHouseholdMemberData>>;

/** Generated Node Admin SDK operation action function for the 'ReinviteHouseholdMember' Mutation. Allow users to execute without passing in DataConnect. */
export function reinviteHouseholdMember(dc: DataConnect, vars: ReinviteHouseholdMemberVariables, options?: OperationOptions): Promise<ExecuteOperationResponse<ReinviteHouseholdMemberData>>;
/** Generated Node Admin SDK operation action function for the 'ReinviteHouseholdMember' Mutation. Allow users to pass in custom DataConnect instances. */
export function reinviteHouseholdMember(vars: ReinviteHouseholdMemberVariables, options?: OperationOptions): Promise<ExecuteOperationResponse<ReinviteHouseholdMemberData>>;

/** Generated Node Admin SDK operation action function for the 'AcceptHouseholdInvite' Mutation. Allow users to execute without passing in DataConnect. */
export function acceptHouseholdInvite(dc: DataConnect, vars: AcceptHouseholdInviteVariables, options?: OperationOptions): Promise<ExecuteOperationResponse<AcceptHouseholdInviteData>>;
/** Generated Node Admin SDK operation action function for the 'AcceptHouseholdInvite' Mutation. Allow users to pass in custom DataConnect instances. */
export function acceptHouseholdInvite(vars: AcceptHouseholdInviteVariables, options?: OperationOptions): Promise<ExecuteOperationResponse<AcceptHouseholdInviteData>>;

/** Generated Node Admin SDK operation action function for the 'DeclineHouseholdInvite' Mutation. Allow users to execute without passing in DataConnect. */
export function declineHouseholdInvite(dc: DataConnect, vars: DeclineHouseholdInviteVariables, options?: OperationOptions): Promise<ExecuteOperationResponse<DeclineHouseholdInviteData>>;
/** Generated Node Admin SDK operation action function for the 'DeclineHouseholdInvite' Mutation. Allow users to pass in custom DataConnect instances. */
export function declineHouseholdInvite(vars: DeclineHouseholdInviteVariables, options?: OperationOptions): Promise<ExecuteOperationResponse<DeclineHouseholdInviteData>>;

/** Generated Node Admin SDK operation action function for the 'CancelHouseholdInvite' Mutation. Allow users to execute without passing in DataConnect. */
export function cancelHouseholdInvite(dc: DataConnect, vars: CancelHouseholdInviteVariables, options?: OperationOptions): Promise<ExecuteOperationResponse<CancelHouseholdInviteData>>;
/** Generated Node Admin SDK operation action function for the 'CancelHouseholdInvite' Mutation. Allow users to pass in custom DataConnect instances. */
export function cancelHouseholdInvite(vars: CancelHouseholdInviteVariables, options?: OperationOptions): Promise<ExecuteOperationResponse<CancelHouseholdInviteData>>;

/** Generated Node Admin SDK operation action function for the 'RemoveHouseholdMember' Mutation. Allow users to execute without passing in DataConnect. */
export function removeHouseholdMember(dc: DataConnect, vars: RemoveHouseholdMemberVariables, options?: OperationOptions): Promise<ExecuteOperationResponse<RemoveHouseholdMemberData>>;
/** Generated Node Admin SDK operation action function for the 'RemoveHouseholdMember' Mutation. Allow users to pass in custom DataConnect instances. */
export function removeHouseholdMember(vars: RemoveHouseholdMemberVariables, options?: OperationOptions): Promise<ExecuteOperationResponse<RemoveHouseholdMemberData>>;

/** Generated Node Admin SDK operation action function for the 'SaveContract' Mutation. Allow users to execute without passing in DataConnect. */
export function saveContract(dc: DataConnect, vars: SaveContractVariables, options?: OperationOptions): Promise<ExecuteOperationResponse<SaveContractData>>;
/** Generated Node Admin SDK operation action function for the 'SaveContract' Mutation. Allow users to pass in custom DataConnect instances. */
export function saveContract(vars: SaveContractVariables, options?: OperationOptions): Promise<ExecuteOperationResponse<SaveContractData>>;

/** Generated Node Admin SDK operation action function for the 'AddDailyTask' Mutation. Allow users to execute without passing in DataConnect. */
export function addDailyTask(dc: DataConnect, vars: AddDailyTaskVariables, options?: OperationOptions): Promise<ExecuteOperationResponse<AddDailyTaskData>>;
/** Generated Node Admin SDK operation action function for the 'AddDailyTask' Mutation. Allow users to pass in custom DataConnect instances. */
export function addDailyTask(vars: AddDailyTaskVariables, options?: OperationOptions): Promise<ExecuteOperationResponse<AddDailyTaskData>>;

/** Generated Node Admin SDK operation action function for the 'AssignDailyTask' Mutation. Allow users to execute without passing in DataConnect. */
export function assignDailyTask(dc: DataConnect, vars: AssignDailyTaskVariables, options?: OperationOptions): Promise<ExecuteOperationResponse<AssignDailyTaskData>>;
/** Generated Node Admin SDK operation action function for the 'AssignDailyTask' Mutation. Allow users to pass in custom DataConnect instances. */
export function assignDailyTask(vars: AssignDailyTaskVariables, options?: OperationOptions): Promise<ExecuteOperationResponse<AssignDailyTaskData>>;

/** Generated Node Admin SDK operation action function for the 'DeleteDailyTask' Mutation. Allow users to execute without passing in DataConnect. */
export function deleteDailyTask(dc: DataConnect, vars: DeleteDailyTaskVariables, options?: OperationOptions): Promise<ExecuteOperationResponse<DeleteDailyTaskData>>;
/** Generated Node Admin SDK operation action function for the 'DeleteDailyTask' Mutation. Allow users to pass in custom DataConnect instances. */
export function deleteDailyTask(vars: DeleteDailyTaskVariables, options?: OperationOptions): Promise<ExecuteOperationResponse<DeleteDailyTaskData>>;

/** Generated Node Admin SDK operation action function for the 'UpdateMyTaskStatus' Mutation. Allow users to execute without passing in DataConnect. */
export function updateMyTaskStatus(dc: DataConnect, vars: UpdateMyTaskStatusVariables, options?: OperationOptions): Promise<ExecuteOperationResponse<UpdateMyTaskStatusData>>;
/** Generated Node Admin SDK operation action function for the 'UpdateMyTaskStatus' Mutation. Allow users to pass in custom DataConnect instances. */
export function updateMyTaskStatus(vars: UpdateMyTaskStatusVariables, options?: OperationOptions): Promise<ExecuteOperationResponse<UpdateMyTaskStatusData>>;

/** Generated Node Admin SDK operation action function for the 'AddLibraryTask' Mutation. Allow users to execute without passing in DataConnect. */
export function addLibraryTask(dc: DataConnect, vars: AddLibraryTaskVariables, options?: OperationOptions): Promise<ExecuteOperationResponse<AddLibraryTaskData>>;
/** Generated Node Admin SDK operation action function for the 'AddLibraryTask' Mutation. Allow users to pass in custom DataConnect instances. */
export function addLibraryTask(vars: AddLibraryTaskVariables, options?: OperationOptions): Promise<ExecuteOperationResponse<AddLibraryTaskData>>;

/** Generated Node Admin SDK operation action function for the 'DeleteLibraryTask' Mutation. Allow users to execute without passing in DataConnect. */
export function deleteLibraryTask(dc: DataConnect, vars: DeleteLibraryTaskVariables, options?: OperationOptions): Promise<ExecuteOperationResponse<DeleteLibraryTaskData>>;
/** Generated Node Admin SDK operation action function for the 'DeleteLibraryTask' Mutation. Allow users to pass in custom DataConnect instances. */
export function deleteLibraryTask(vars: DeleteLibraryTaskVariables, options?: OperationOptions): Promise<ExecuteOperationResponse<DeleteLibraryTaskData>>;

/** Generated Node Admin SDK operation action function for the 'AddHoliday' Mutation. Allow users to execute without passing in DataConnect. */
export function addHoliday(dc: DataConnect, vars: AddHolidayVariables, options?: OperationOptions): Promise<ExecuteOperationResponse<AddHolidayData>>;
/** Generated Node Admin SDK operation action function for the 'AddHoliday' Mutation. Allow users to pass in custom DataConnect instances. */
export function addHoliday(vars: AddHolidayVariables, options?: OperationOptions): Promise<ExecuteOperationResponse<AddHolidayData>>;

/** Generated Node Admin SDK operation action function for the 'DeleteHoliday' Mutation. Allow users to execute without passing in DataConnect. */
export function deleteHoliday(dc: DataConnect, vars: DeleteHolidayVariables, options?: OperationOptions): Promise<ExecuteOperationResponse<DeleteHolidayData>>;
/** Generated Node Admin SDK operation action function for the 'DeleteHoliday' Mutation. Allow users to pass in custom DataConnect instances. */
export function deleteHoliday(vars: DeleteHolidayVariables, options?: OperationOptions): Promise<ExecuteOperationResponse<DeleteHolidayData>>;

/** Generated Node Admin SDK operation action function for the 'AddPaymentPlan' Mutation. Allow users to execute without passing in DataConnect. */
export function addPaymentPlan(dc: DataConnect, vars: AddPaymentPlanVariables, options?: OperationOptions): Promise<ExecuteOperationResponse<AddPaymentPlanData>>;
/** Generated Node Admin SDK operation action function for the 'AddPaymentPlan' Mutation. Allow users to pass in custom DataConnect instances. */
export function addPaymentPlan(vars: AddPaymentPlanVariables, options?: OperationOptions): Promise<ExecuteOperationResponse<AddPaymentPlanData>>;

/** Generated Node Admin SDK operation action function for the 'DeletePaymentPlan' Mutation. Allow users to execute without passing in DataConnect. */
export function deletePaymentPlan(dc: DataConnect, vars: DeletePaymentPlanVariables, options?: OperationOptions): Promise<ExecuteOperationResponse<DeletePaymentPlanData>>;
/** Generated Node Admin SDK operation action function for the 'DeletePaymentPlan' Mutation. Allow users to pass in custom DataConnect instances. */
export function deletePaymentPlan(vars: DeletePaymentPlanVariables, options?: OperationOptions): Promise<ExecuteOperationResponse<DeletePaymentPlanData>>;

/** Generated Node Admin SDK operation action function for the 'SetHouseholdPlan' Mutation. Allow users to execute without passing in DataConnect. */
export function setHouseholdPlan(dc: DataConnect, vars: SetHouseholdPlanVariables, options?: OperationOptions): Promise<ExecuteOperationResponse<SetHouseholdPlanData>>;
/** Generated Node Admin SDK operation action function for the 'SetHouseholdPlan' Mutation. Allow users to pass in custom DataConnect instances. */
export function setHouseholdPlan(vars: SetHouseholdPlanVariables, options?: OperationOptions): Promise<ExecuteOperationResponse<SetHouseholdPlanData>>;

/** Generated Node Admin SDK operation action function for the 'CheckIn' Mutation. Allow users to execute without passing in DataConnect. */
export function checkIn(dc: DataConnect, vars: CheckInVariables, options?: OperationOptions): Promise<ExecuteOperationResponse<CheckInData>>;
/** Generated Node Admin SDK operation action function for the 'CheckIn' Mutation. Allow users to pass in custom DataConnect instances. */
export function checkIn(vars: CheckInVariables, options?: OperationOptions): Promise<ExecuteOperationResponse<CheckInData>>;

/** Generated Node Admin SDK operation action function for the 'CheckOut' Mutation. Allow users to execute without passing in DataConnect. */
export function checkOut(dc: DataConnect, vars: CheckOutVariables, options?: OperationOptions): Promise<ExecuteOperationResponse<CheckOutData>>;
/** Generated Node Admin SDK operation action function for the 'CheckOut' Mutation. Allow users to pass in custom DataConnect instances. */
export function checkOut(vars: CheckOutVariables, options?: OperationOptions): Promise<ExecuteOperationResponse<CheckOutData>>;

/** Generated Node Admin SDK operation action function for the 'AddAttendanceRecord' Mutation. Allow users to execute without passing in DataConnect. */
export function addAttendanceRecord(dc: DataConnect, vars: AddAttendanceRecordVariables, options?: OperationOptions): Promise<ExecuteOperationResponse<AddAttendanceRecordData>>;
/** Generated Node Admin SDK operation action function for the 'AddAttendanceRecord' Mutation. Allow users to pass in custom DataConnect instances. */
export function addAttendanceRecord(vars: AddAttendanceRecordVariables, options?: OperationOptions): Promise<ExecuteOperationResponse<AddAttendanceRecordData>>;

/** Generated Node Admin SDK operation action function for the 'UpdateAttendanceRecord' Mutation. Allow users to execute without passing in DataConnect. */
export function updateAttendanceRecord(dc: DataConnect, vars: UpdateAttendanceRecordVariables, options?: OperationOptions): Promise<ExecuteOperationResponse<UpdateAttendanceRecordData>>;
/** Generated Node Admin SDK operation action function for the 'UpdateAttendanceRecord' Mutation. Allow users to pass in custom DataConnect instances. */
export function updateAttendanceRecord(vars: UpdateAttendanceRecordVariables, options?: OperationOptions): Promise<ExecuteOperationResponse<UpdateAttendanceRecordData>>;

/** Generated Node Admin SDK operation action function for the 'DeleteAttendanceRecord' Mutation. Allow users to execute without passing in DataConnect. */
export function deleteAttendanceRecord(dc: DataConnect, vars: DeleteAttendanceRecordVariables, options?: OperationOptions): Promise<ExecuteOperationResponse<DeleteAttendanceRecordData>>;
/** Generated Node Admin SDK operation action function for the 'DeleteAttendanceRecord' Mutation. Allow users to pass in custom DataConnect instances. */
export function deleteAttendanceRecord(vars: DeleteAttendanceRecordVariables, options?: OperationOptions): Promise<ExecuteOperationResponse<DeleteAttendanceRecordData>>;

/** Generated Node Admin SDK operation action function for the 'SubmitLeaveRequest' Mutation. Allow users to execute without passing in DataConnect. */
export function submitLeaveRequest(dc: DataConnect, vars: SubmitLeaveRequestVariables, options?: OperationOptions): Promise<ExecuteOperationResponse<SubmitLeaveRequestData>>;
/** Generated Node Admin SDK operation action function for the 'SubmitLeaveRequest' Mutation. Allow users to pass in custom DataConnect instances. */
export function submitLeaveRequest(vars: SubmitLeaveRequestVariables, options?: OperationOptions): Promise<ExecuteOperationResponse<SubmitLeaveRequestData>>;

/** Generated Node Admin SDK operation action function for the 'ScheduleSalaryPayment' Mutation. Allow users to execute without passing in DataConnect. */
export function scheduleSalaryPayment(dc: DataConnect, vars: ScheduleSalaryPaymentVariables, options?: OperationOptions): Promise<ExecuteOperationResponse<ScheduleSalaryPaymentData>>;
/** Generated Node Admin SDK operation action function for the 'ScheduleSalaryPayment' Mutation. Allow users to pass in custom DataConnect instances. */
export function scheduleSalaryPayment(vars: ScheduleSalaryPaymentVariables, options?: OperationOptions): Promise<ExecuteOperationResponse<ScheduleSalaryPaymentData>>;

/** Generated Node Admin SDK operation action function for the 'MarkSalaryPaymentPaid' Mutation. Allow users to execute without passing in DataConnect. */
export function markSalaryPaymentPaid(dc: DataConnect, vars: MarkSalaryPaymentPaidVariables, options?: OperationOptions): Promise<ExecuteOperationResponse<MarkSalaryPaymentPaidData>>;
/** Generated Node Admin SDK operation action function for the 'MarkSalaryPaymentPaid' Mutation. Allow users to pass in custom DataConnect instances. */
export function markSalaryPaymentPaid(vars: MarkSalaryPaymentPaidVariables, options?: OperationOptions): Promise<ExecuteOperationResponse<MarkSalaryPaymentPaidData>>;

/** Generated Node Admin SDK operation action function for the 'RequestAdvance' Mutation. Allow users to execute without passing in DataConnect. */
export function requestAdvance(dc: DataConnect, vars: RequestAdvanceVariables, options?: OperationOptions): Promise<ExecuteOperationResponse<RequestAdvanceData>>;
/** Generated Node Admin SDK operation action function for the 'RequestAdvance' Mutation. Allow users to pass in custom DataConnect instances. */
export function requestAdvance(vars: RequestAdvanceVariables, options?: OperationOptions): Promise<ExecuteOperationResponse<RequestAdvanceData>>;

/** Generated Node Admin SDK operation action function for the 'ApproveAdvanceRequest' Mutation. Allow users to execute without passing in DataConnect. */
export function approveAdvanceRequest(dc: DataConnect, vars: ApproveAdvanceRequestVariables, options?: OperationOptions): Promise<ExecuteOperationResponse<ApproveAdvanceRequestData>>;
/** Generated Node Admin SDK operation action function for the 'ApproveAdvanceRequest' Mutation. Allow users to pass in custom DataConnect instances. */
export function approveAdvanceRequest(vars: ApproveAdvanceRequestVariables, options?: OperationOptions): Promise<ExecuteOperationResponse<ApproveAdvanceRequestData>>;

/** Generated Node Admin SDK operation action function for the 'RejectAdvanceRequest' Mutation. Allow users to execute without passing in DataConnect. */
export function rejectAdvanceRequest(dc: DataConnect, vars: RejectAdvanceRequestVariables, options?: OperationOptions): Promise<ExecuteOperationResponse<RejectAdvanceRequestData>>;
/** Generated Node Admin SDK operation action function for the 'RejectAdvanceRequest' Mutation. Allow users to pass in custom DataConnect instances. */
export function rejectAdvanceRequest(vars: RejectAdvanceRequestVariables, options?: OperationOptions): Promise<ExecuteOperationResponse<RejectAdvanceRequestData>>;

/** Generated Node Admin SDK operation action function for the 'ReviewLeaveRequest' Mutation. Allow users to execute without passing in DataConnect. */
export function reviewLeaveRequest(dc: DataConnect, vars: ReviewLeaveRequestVariables, options?: OperationOptions): Promise<ExecuteOperationResponse<ReviewLeaveRequestData>>;
/** Generated Node Admin SDK operation action function for the 'ReviewLeaveRequest' Mutation. Allow users to pass in custom DataConnect instances. */
export function reviewLeaveRequest(vars: ReviewLeaveRequestVariables, options?: OperationOptions): Promise<ExecuteOperationResponse<ReviewLeaveRequestData>>;

/** Generated Node Admin SDK operation action function for the 'DeleteLeaveRequest' Mutation. Allow users to execute without passing in DataConnect. */
export function deleteLeaveRequest(dc: DataConnect, vars: DeleteLeaveRequestVariables, options?: OperationOptions): Promise<ExecuteOperationResponse<DeleteLeaveRequestData>>;
/** Generated Node Admin SDK operation action function for the 'DeleteLeaveRequest' Mutation. Allow users to pass in custom DataConnect instances. */
export function deleteLeaveRequest(vars: DeleteLeaveRequestVariables, options?: OperationOptions): Promise<ExecuteOperationResponse<DeleteLeaveRequestData>>;

/** Generated Node Admin SDK operation action function for the 'AddGroceryItem' Mutation. Allow users to execute without passing in DataConnect. */
export function addGroceryItem(dc: DataConnect, vars: AddGroceryItemVariables, options?: OperationOptions): Promise<ExecuteOperationResponse<AddGroceryItemData>>;
/** Generated Node Admin SDK operation action function for the 'AddGroceryItem' Mutation. Allow users to pass in custom DataConnect instances. */
export function addGroceryItem(vars: AddGroceryItemVariables, options?: OperationOptions): Promise<ExecuteOperationResponse<AddGroceryItemData>>;

/** Generated Node Admin SDK operation action function for the 'UpdateGroceryItemStatus' Mutation. Allow users to execute without passing in DataConnect. */
export function updateGroceryItemStatus(dc: DataConnect, vars: UpdateGroceryItemStatusVariables, options?: OperationOptions): Promise<ExecuteOperationResponse<UpdateGroceryItemStatusData>>;
/** Generated Node Admin SDK operation action function for the 'UpdateGroceryItemStatus' Mutation. Allow users to pass in custom DataConnect instances. */
export function updateGroceryItemStatus(vars: UpdateGroceryItemStatusVariables, options?: OperationOptions): Promise<ExecuteOperationResponse<UpdateGroceryItemStatusData>>;

/** Generated Node Admin SDK operation action function for the 'DeleteGroceryItem' Mutation. Allow users to execute without passing in DataConnect. */
export function deleteGroceryItem(dc: DataConnect, vars: DeleteGroceryItemVariables, options?: OperationOptions): Promise<ExecuteOperationResponse<DeleteGroceryItemData>>;
/** Generated Node Admin SDK operation action function for the 'DeleteGroceryItem' Mutation. Allow users to pass in custom DataConnect instances. */
export function deleteGroceryItem(vars: DeleteGroceryItemVariables, options?: OperationOptions): Promise<ExecuteOperationResponse<DeleteGroceryItemData>>;

/** Generated Node Admin SDK operation action function for the 'CreateTaskFromTemplate' Mutation. Allow users to execute without passing in DataConnect. */
export function createTaskFromTemplate(dc: DataConnect, vars: CreateTaskFromTemplateVariables, options?: OperationOptions): Promise<ExecuteOperationResponse<CreateTaskFromTemplateData>>;
/** Generated Node Admin SDK operation action function for the 'CreateTaskFromTemplate' Mutation. Allow users to pass in custom DataConnect instances. */
export function createTaskFromTemplate(vars: CreateTaskFromTemplateVariables, options?: OperationOptions): Promise<ExecuteOperationResponse<CreateTaskFromTemplateData>>;

/** Generated Node Admin SDK operation action function for the 'MyProfile' Query. Allow users to execute without passing in DataConnect. */
export function myProfile(dc: DataConnect, options?: OperationOptions): Promise<ExecuteOperationResponse<MyProfileData>>;
/** Generated Node Admin SDK operation action function for the 'MyProfile' Query. Allow users to pass in custom DataConnect instances. */
export function myProfile(options?: OperationOptions): Promise<ExecuteOperationResponse<MyProfileData>>;

/** Generated Node Admin SDK operation action function for the 'TaskNotificationDetails' Query. Allow users to execute without passing in DataConnect. */
export function taskNotificationDetails(dc: DataConnect, vars: TaskNotificationDetailsVariables, options?: OperationOptions): Promise<ExecuteOperationResponse<TaskNotificationDetailsData>>;
/** Generated Node Admin SDK operation action function for the 'TaskNotificationDetails' Query. Allow users to pass in custom DataConnect instances. */
export function taskNotificationDetails(vars: TaskNotificationDetailsVariables, options?: OperationOptions): Promise<ExecuteOperationResponse<TaskNotificationDetailsData>>;

/** Generated Node Admin SDK operation action function for the 'MyMembership' Query. Allow users to execute without passing in DataConnect. */
export function myMembership(dc: DataConnect, options?: OperationOptions): Promise<ExecuteOperationResponse<MyMembershipData>>;
/** Generated Node Admin SDK operation action function for the 'MyMembership' Query. Allow users to pass in custom DataConnect instances. */
export function myMembership(options?: OperationOptions): Promise<ExecuteOperationResponse<MyMembershipData>>;

/** Generated Node Admin SDK operation action function for the 'PendingMyMembership' Query. Allow users to execute without passing in DataConnect. */
export function pendingMyMembership(dc: DataConnect, options?: OperationOptions): Promise<ExecuteOperationResponse<PendingMyMembershipData>>;
/** Generated Node Admin SDK operation action function for the 'PendingMyMembership' Query. Allow users to pass in custom DataConnect instances. */
export function pendingMyMembership(options?: OperationOptions): Promise<ExecuteOperationResponse<PendingMyMembershipData>>;

/** Generated Node Admin SDK operation action function for the 'MyMembershipById' Query. Allow users to execute without passing in DataConnect. */
export function myMembershipById(dc: DataConnect, vars: MyMembershipByIdVariables, options?: OperationOptions): Promise<ExecuteOperationResponse<MyMembershipByIdData>>;
/** Generated Node Admin SDK operation action function for the 'MyMembershipById' Query. Allow users to pass in custom DataConnect instances. */
export function myMembershipById(vars: MyMembershipByIdVariables, options?: OperationOptions): Promise<ExecuteOperationResponse<MyMembershipByIdData>>;

/** Generated Node Admin SDK operation action function for the 'MyHouseholdInvites' Query. Allow users to execute without passing in DataConnect. */
export function myHouseholdInvites(dc: DataConnect, options?: OperationOptions): Promise<ExecuteOperationResponse<MyHouseholdInvitesData>>;
/** Generated Node Admin SDK operation action function for the 'MyHouseholdInvites' Query. Allow users to pass in custom DataConnect instances. */
export function myHouseholdInvites(options?: OperationOptions): Promise<ExecuteOperationResponse<MyHouseholdInvitesData>>;

/** Generated Node Admin SDK operation action function for the 'HouseholdMembers' Query. Allow users to execute without passing in DataConnect. */
export function householdMembers(dc: DataConnect, vars: HouseholdMembersVariables, options?: OperationOptions): Promise<ExecuteOperationResponse<HouseholdMembersData>>;
/** Generated Node Admin SDK operation action function for the 'HouseholdMembers' Query. Allow users to pass in custom DataConnect instances. */
export function householdMembers(vars: HouseholdMembersVariables, options?: OperationOptions): Promise<ExecuteOperationResponse<HouseholdMembersData>>;

/** Generated Node Admin SDK operation action function for the 'UserIdByEmail' Query. Allow users to execute without passing in DataConnect. */
export function userIdByEmail(dc: DataConnect, vars: UserIdByEmailVariables, options?: OperationOptions): Promise<ExecuteOperationResponse<UserIdByEmailData>>;
/** Generated Node Admin SDK operation action function for the 'UserIdByEmail' Query. Allow users to pass in custom DataConnect instances. */
export function userIdByEmail(vars: UserIdByEmailVariables, options?: OperationOptions): Promise<ExecuteOperationResponse<UserIdByEmailData>>;

/** Generated Node Admin SDK operation action function for the 'MaidProfileByEmail' Query. Allow users to execute without passing in DataConnect. */
export function maidProfileByEmail(dc: DataConnect, vars: MaidProfileByEmailVariables, options?: OperationOptions): Promise<ExecuteOperationResponse<MaidProfileByEmailData>>;
/** Generated Node Admin SDK operation action function for the 'MaidProfileByEmail' Query. Allow users to pass in custom DataConnect instances. */
export function maidProfileByEmail(vars: MaidProfileByEmailVariables, options?: OperationOptions): Promise<ExecuteOperationResponse<MaidProfileByEmailData>>;

/** Generated Node Admin SDK operation action function for the 'AvailableMaids' Query. Allow users to execute without passing in DataConnect. */
export function availableMaids(dc: DataConnect, options?: OperationOptions): Promise<ExecuteOperationResponse<AvailableMaidsData>>;
/** Generated Node Admin SDK operation action function for the 'AvailableMaids' Query. Allow users to pass in custom DataConnect instances. */
export function availableMaids(options?: OperationOptions): Promise<ExecuteOperationResponse<AvailableMaidsData>>;

/** Generated Node Admin SDK operation action function for the 'CurrentContract' Query. Allow users to execute without passing in DataConnect. */
export function currentContract(dc: DataConnect, vars: CurrentContractVariables, options?: OperationOptions): Promise<ExecuteOperationResponse<CurrentContractData>>;
/** Generated Node Admin SDK operation action function for the 'CurrentContract' Query. Allow users to pass in custom DataConnect instances. */
export function currentContract(vars: CurrentContractVariables, options?: OperationOptions): Promise<ExecuteOperationResponse<CurrentContractData>>;

/** Generated Node Admin SDK operation action function for the 'HouseholdTasksForDay' Query. Allow users to execute without passing in DataConnect. */
export function householdTasksForDay(dc: DataConnect, vars: HouseholdTasksForDayVariables, options?: OperationOptions): Promise<ExecuteOperationResponse<HouseholdTasksForDayData>>;
/** Generated Node Admin SDK operation action function for the 'HouseholdTasksForDay' Query. Allow users to pass in custom DataConnect instances. */
export function householdTasksForDay(vars: HouseholdTasksForDayVariables, options?: OperationOptions): Promise<ExecuteOperationResponse<HouseholdTasksForDayData>>;

/** Generated Node Admin SDK operation action function for the 'MyTasksForDay' Query. Allow users to execute without passing in DataConnect. */
export function myTasksForDay(dc: DataConnect, vars: MyTasksForDayVariables, options?: OperationOptions): Promise<ExecuteOperationResponse<MyTasksForDayData>>;
/** Generated Node Admin SDK operation action function for the 'MyTasksForDay' Query. Allow users to pass in custom DataConnect instances. */
export function myTasksForDay(vars: MyTasksForDayVariables, options?: OperationOptions): Promise<ExecuteOperationResponse<MyTasksForDayData>>;

/** Generated Node Admin SDK operation action function for the 'LibraryTasks' Query. Allow users to execute without passing in DataConnect. */
export function libraryTasks(dc: DataConnect, options?: OperationOptions): Promise<ExecuteOperationResponse<LibraryTasksData>>;
/** Generated Node Admin SDK operation action function for the 'LibraryTasks' Query. Allow users to pass in custom DataConnect instances. */
export function libraryTasks(options?: OperationOptions): Promise<ExecuteOperationResponse<LibraryTasksData>>;

/** Generated Node Admin SDK operation action function for the 'Holidays' Query. Allow users to execute without passing in DataConnect. */
export function holidays(dc: DataConnect, options?: OperationOptions): Promise<ExecuteOperationResponse<HolidaysData>>;
/** Generated Node Admin SDK operation action function for the 'Holidays' Query. Allow users to pass in custom DataConnect instances. */
export function holidays(options?: OperationOptions): Promise<ExecuteOperationResponse<HolidaysData>>;

/** Generated Node Admin SDK operation action function for the 'MyAttendance' Query. Allow users to execute without passing in DataConnect. */
export function myAttendance(dc: DataConnect, options?: OperationOptions): Promise<ExecuteOperationResponse<MyAttendanceData>>;
/** Generated Node Admin SDK operation action function for the 'MyAttendance' Query. Allow users to pass in custom DataConnect instances. */
export function myAttendance(options?: OperationOptions): Promise<ExecuteOperationResponse<MyAttendanceData>>;

/** Generated Node Admin SDK operation action function for the 'HouseholdAttendance' Query. Allow users to execute without passing in DataConnect. */
export function householdAttendance(dc: DataConnect, vars: HouseholdAttendanceVariables, options?: OperationOptions): Promise<ExecuteOperationResponse<HouseholdAttendanceData>>;
/** Generated Node Admin SDK operation action function for the 'HouseholdAttendance' Query. Allow users to pass in custom DataConnect instances. */
export function householdAttendance(vars: HouseholdAttendanceVariables, options?: OperationOptions): Promise<ExecuteOperationResponse<HouseholdAttendanceData>>;

/** Generated Node Admin SDK operation action function for the 'MyLeaveRequests' Query. Allow users to execute without passing in DataConnect. */
export function myLeaveRequests(dc: DataConnect, options?: OperationOptions): Promise<ExecuteOperationResponse<MyLeaveRequestsData>>;
/** Generated Node Admin SDK operation action function for the 'MyLeaveRequests' Query. Allow users to pass in custom DataConnect instances. */
export function myLeaveRequests(options?: OperationOptions): Promise<ExecuteOperationResponse<MyLeaveRequestsData>>;

/** Generated Node Admin SDK operation action function for the 'HouseholdLeaveRequests' Query. Allow users to execute without passing in DataConnect. */
export function householdLeaveRequests(dc: DataConnect, vars: HouseholdLeaveRequestsVariables, options?: OperationOptions): Promise<ExecuteOperationResponse<HouseholdLeaveRequestsData>>;
/** Generated Node Admin SDK operation action function for the 'HouseholdLeaveRequests' Query. Allow users to pass in custom DataConnect instances. */
export function householdLeaveRequests(vars: HouseholdLeaveRequestsVariables, options?: OperationOptions): Promise<ExecuteOperationResponse<HouseholdLeaveRequestsData>>;

/** Generated Node Admin SDK operation action function for the 'MySalaryPayments' Query. Allow users to execute without passing in DataConnect. */
export function mySalaryPayments(dc: DataConnect, options?: OperationOptions): Promise<ExecuteOperationResponse<MySalaryPaymentsData>>;
/** Generated Node Admin SDK operation action function for the 'MySalaryPayments' Query. Allow users to pass in custom DataConnect instances. */
export function mySalaryPayments(options?: OperationOptions): Promise<ExecuteOperationResponse<MySalaryPaymentsData>>;

/** Generated Node Admin SDK operation action function for the 'HouseholdSalaryPayments' Query. Allow users to execute without passing in DataConnect. */
export function householdSalaryPayments(dc: DataConnect, vars: HouseholdSalaryPaymentsVariables, options?: OperationOptions): Promise<ExecuteOperationResponse<HouseholdSalaryPaymentsData>>;
/** Generated Node Admin SDK operation action function for the 'HouseholdSalaryPayments' Query. Allow users to pass in custom DataConnect instances. */
export function householdSalaryPayments(vars: HouseholdSalaryPaymentsVariables, options?: OperationOptions): Promise<ExecuteOperationResponse<HouseholdSalaryPaymentsData>>;

/** Generated Node Admin SDK operation action function for the 'MyAdvanceRequests' Query. Allow users to execute without passing in DataConnect. */
export function myAdvanceRequests(dc: DataConnect, options?: OperationOptions): Promise<ExecuteOperationResponse<MyAdvanceRequestsData>>;
/** Generated Node Admin SDK operation action function for the 'MyAdvanceRequests' Query. Allow users to pass in custom DataConnect instances. */
export function myAdvanceRequests(options?: OperationOptions): Promise<ExecuteOperationResponse<MyAdvanceRequestsData>>;

/** Generated Node Admin SDK operation action function for the 'HouseholdAdvanceRequests' Query. Allow users to execute without passing in DataConnect. */
export function householdAdvanceRequests(dc: DataConnect, vars: HouseholdAdvanceRequestsVariables, options?: OperationOptions): Promise<ExecuteOperationResponse<HouseholdAdvanceRequestsData>>;
/** Generated Node Admin SDK operation action function for the 'HouseholdAdvanceRequests' Query. Allow users to pass in custom DataConnect instances. */
export function householdAdvanceRequests(vars: HouseholdAdvanceRequestsVariables, options?: OperationOptions): Promise<ExecuteOperationResponse<HouseholdAdvanceRequestsData>>;

/** Generated Node Admin SDK operation action function for the 'AdminHouseholds' Query. Allow users to execute without passing in DataConnect. */
export function adminHouseholds(dc: DataConnect, options?: OperationOptions): Promise<ExecuteOperationResponse<AdminHouseholdsData>>;
/** Generated Node Admin SDK operation action function for the 'AdminHouseholds' Query. Allow users to pass in custom DataConnect instances. */
export function adminHouseholds(options?: OperationOptions): Promise<ExecuteOperationResponse<AdminHouseholdsData>>;

/** Generated Node Admin SDK operation action function for the 'AdminPaymentPlans' Query. Allow users to execute without passing in DataConnect. */
export function adminPaymentPlans(dc: DataConnect, options?: OperationOptions): Promise<ExecuteOperationResponse<AdminPaymentPlansData>>;
/** Generated Node Admin SDK operation action function for the 'AdminPaymentPlans' Query. Allow users to pass in custom DataConnect instances. */
export function adminPaymentPlans(options?: OperationOptions): Promise<ExecuteOperationResponse<AdminPaymentPlansData>>;

/** Generated Node Admin SDK operation action function for the 'GetGroceryItems' Query. Allow users to execute without passing in DataConnect. */
export function getGroceryItems(dc: DataConnect, vars: GetGroceryItemsVariables, options?: OperationOptions): Promise<ExecuteOperationResponse<GetGroceryItemsData>>;
/** Generated Node Admin SDK operation action function for the 'GetGroceryItems' Query. Allow users to pass in custom DataConnect instances. */
export function getGroceryItems(vars: GetGroceryItemsVariables, options?: OperationOptions): Promise<ExecuteOperationResponse<GetGroceryItemsData>>;

/** Generated Node Admin SDK operation action function for the 'ActiveTaskTemplates' Query. Allow users to execute without passing in DataConnect. */
export function activeTaskTemplates(dc: DataConnect, vars: ActiveTaskTemplatesVariables, options?: OperationOptions): Promise<ExecuteOperationResponse<ActiveTaskTemplatesData>>;
/** Generated Node Admin SDK operation action function for the 'ActiveTaskTemplates' Query. Allow users to pass in custom DataConnect instances. */
export function activeTaskTemplates(vars: ActiveTaskTemplatesVariables, options?: OperationOptions): Promise<ExecuteOperationResponse<ActiveTaskTemplatesData>>;

