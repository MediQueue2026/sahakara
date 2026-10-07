library sahakara;
import 'package:firebase_data_connect/firebase_data_connect.dart';
import 'package:flutter/foundation.dart';
import 'dart:convert';
import 'package:flutter/foundation.dart';

part 'claim_invited_profile.dart';

part 'create_my_profile.dart';

part 'set_my_name.dart';

part 'set_my_profile.dart';

part 'set_my_language.dart';

part 'set_household_area.dart';

part 'create_household.dart';

part 'add_household_member.dart';

part 'invite_household_member.dart';

part 'reinvite_household_member.dart';

part 'accept_household_invite.dart';

part 'decline_household_invite.dart';

part 'cancel_household_invite.dart';

part 'remove_household_member.dart';

part 'save_contract.dart';

part 'add_daily_task.dart';

part 'assign_daily_task.dart';

part 'delete_daily_task.dart';

part 'update_my_task_status.dart';

part 'add_library_task.dart';

part 'delete_library_task.dart';

part 'add_holiday.dart';

part 'delete_holiday.dart';

part 'add_payment_plan.dart';

part 'delete_payment_plan.dart';

part 'set_household_plan.dart';

part 'check_in.dart';

part 'check_out.dart';

part 'submit_leave_request.dart';

part 'schedule_salary_payment.dart';

part 'mark_salary_payment_paid.dart';

part 'request_advance.dart';

part 'approve_advance_request.dart';

part 'reject_advance_request.dart';

part 'review_leave_request.dart';

part 'delete_leave_request.dart';

part 'my_profile.dart';

part 'my_membership.dart';

part 'my_membership_by_id.dart';

part 'my_household_invites.dart';

part 'household_members.dart';

part 'user_id_by_email.dart';

part 'maid_profile_by_email.dart';

part 'available_maids.dart';

part 'current_contract.dart';

part 'household_tasks_for_day.dart';

part 'my_tasks_for_day.dart';

part 'library_tasks.dart';

part 'holidays.dart';

part 'my_attendance.dart';

part 'household_attendance.dart';

part 'my_leave_requests.dart';

part 'household_leave_requests.dart';

part 'my_salary_payments.dart';

part 'household_salary_payments.dart';

part 'my_advance_requests.dart';

part 'household_advance_requests.dart';

part 'admin_households.dart';

part 'admin_payment_plans.dart';



  enum AccountType {
    
      owner,
    
      maid,
    
      admin,
    
  }
  
  String accountTypeSerializer(EnumValue<AccountType> e) {
    return e.stringValue;
  }
  EnumValue<AccountType> accountTypeDeserializer(dynamic data) {
    switch (data) {
      
      case 'owner':
        return const Known(AccountType.owner);
      
      case 'maid':
        return const Known(AccountType.maid);
      
      case 'admin':
        return const Known(AccountType.admin);
      
      default:
        return Unknown(data);
    }
  }
  

  enum AdvanceRequestStatus {
    
      pending,
    
      approved,
    
      rejected,
    
  }
  
  String advanceRequestStatusSerializer(EnumValue<AdvanceRequestStatus> e) {
    return e.stringValue;
  }
  EnumValue<AdvanceRequestStatus> advanceRequestStatusDeserializer(dynamic data) {
    switch (data) {
      
      case 'pending':
        return const Known(AdvanceRequestStatus.pending);
      
      case 'approved':
        return const Known(AdvanceRequestStatus.approved);
      
      case 'rejected':
        return const Known(AdvanceRequestStatus.rejected);
      
      default:
        return Unknown(data);
    }
  }
  

  enum AppLanguage {
    
      si,
    
      ta,
    
      en,
    
  }
  
  String appLanguageSerializer(EnumValue<AppLanguage> e) {
    return e.stringValue;
  }
  EnumValue<AppLanguage> appLanguageDeserializer(dynamic data) {
    switch (data) {
      
      case 'si':
        return const Known(AppLanguage.si);
      
      case 'ta':
        return const Known(AppLanguage.ta);
      
      case 'en':
        return const Known(AppLanguage.en);
      
      default:
        return Unknown(data);
    }
  }
  

  enum AttendanceDayType {
    
      full,
    
      half,
    
      late,
    
      early_leave,
    
      leave,
    
      absent,
    
      holiday,
    
  }
  
  String attendanceDayTypeSerializer(EnumValue<AttendanceDayType> e) {
    return e.stringValue;
  }
  EnumValue<AttendanceDayType> attendanceDayTypeDeserializer(dynamic data) {
    switch (data) {
      
      case 'full':
        return const Known(AttendanceDayType.full);
      
      case 'half':
        return const Known(AttendanceDayType.half);
      
      case 'late':
        return const Known(AttendanceDayType.late);
      
      case 'early_leave':
        return const Known(AttendanceDayType.early_leave);
      
      case 'leave':
        return const Known(AttendanceDayType.leave);
      
      case 'absent':
        return const Known(AttendanceDayType.absent);
      
      case 'holiday':
        return const Known(AttendanceDayType.holiday);
      
      default:
        return Unknown(data);
    }
  }
  

  enum BillingPeriod {
    
      monthly,
    
      yearly,
    
  }
  
  String billingPeriodSerializer(EnumValue<BillingPeriod> e) {
    return e.stringValue;
  }
  EnumValue<BillingPeriod> billingPeriodDeserializer(dynamic data) {
    switch (data) {
      
      case 'monthly':
        return const Known(BillingPeriod.monthly);
      
      case 'yearly':
        return const Known(BillingPeriod.yearly);
      
      default:
        return Unknown(data);
    }
  }
  

  enum CantDoReason {
    
      no_supplies,
    
      power_cut,
    
      water_cut,
    
      sick,
    
      no_time,
    
      other,
    
  }
  
  String cantDoReasonSerializer(EnumValue<CantDoReason> e) {
    return e.stringValue;
  }
  EnumValue<CantDoReason> cantDoReasonDeserializer(dynamic data) {
    switch (data) {
      
      case 'no_supplies':
        return const Known(CantDoReason.no_supplies);
      
      case 'power_cut':
        return const Known(CantDoReason.power_cut);
      
      case 'water_cut':
        return const Known(CantDoReason.water_cut);
      
      case 'sick':
        return const Known(CantDoReason.sick);
      
      case 'no_time':
        return const Known(CantDoReason.no_time);
      
      case 'other':
        return const Known(CantDoReason.other);
      
      default:
        return Unknown(data);
    }
  }
  

  enum HolidayType {
    
      poya,
    
      public,
    
      festival,
    
  }
  
  String holidayTypeSerializer(EnumValue<HolidayType> e) {
    return e.stringValue;
  }
  EnumValue<HolidayType> holidayTypeDeserializer(dynamic data) {
    switch (data) {
      
      case 'poya':
        return const Known(HolidayType.poya);
      
      case 'public':
        return const Known(HolidayType.public);
      
      case 'festival':
        return const Known(HolidayType.festival);
      
      default:
        return Unknown(data);
    }
  }
  

  enum LeaveStatus {
    
      pending,
    
      approved,
    
      rejected,
    
  }
  
  String leaveStatusSerializer(EnumValue<LeaveStatus> e) {
    return e.stringValue;
  }
  EnumValue<LeaveStatus> leaveStatusDeserializer(dynamic data) {
    switch (data) {
      
      case 'pending':
        return const Known(LeaveStatus.pending);
      
      case 'approved':
        return const Known(LeaveStatus.approved);
      
      case 'rejected':
        return const Known(LeaveStatus.rejected);
      
      default:
        return Unknown(data);
    }
  }
  

  enum LeaveType {
    
      paid,
    
      unpaid,
    
      sick,
    
  }
  
  String leaveTypeSerializer(EnumValue<LeaveType> e) {
    return e.stringValue;
  }
  EnumValue<LeaveType> leaveTypeDeserializer(dynamic data) {
    switch (data) {
      
      case 'paid':
        return const Known(LeaveType.paid);
      
      case 'unpaid':
        return const Known(LeaveType.unpaid);
      
      case 'sick':
        return const Known(LeaveType.sick);
      
      default:
        return Unknown(data);
    }
  }
  

  enum MemberRole {
    
      owner,
    
      adult,
    
      maid,
    
      driver,
    
      cook,
    
      gardener,
    
  }
  
  String memberRoleSerializer(EnumValue<MemberRole> e) {
    return e.stringValue;
  }
  EnumValue<MemberRole> memberRoleDeserializer(dynamic data) {
    switch (data) {
      
      case 'owner':
        return const Known(MemberRole.owner);
      
      case 'adult':
        return const Known(MemberRole.adult);
      
      case 'maid':
        return const Known(MemberRole.maid);
      
      case 'driver':
        return const Known(MemberRole.driver);
      
      case 'cook':
        return const Known(MemberRole.cook);
      
      case 'gardener':
        return const Known(MemberRole.gardener);
      
      default:
        return Unknown(data);
    }
  }
  

  enum MembershipStatus {
    
      pending,
    
      accepted,
    
      declined,
    
  }
  
  String membershipStatusSerializer(EnumValue<MembershipStatus> e) {
    return e.stringValue;
  }
  EnumValue<MembershipStatus> membershipStatusDeserializer(dynamic data) {
    switch (data) {
      
      case 'pending':
        return const Known(MembershipStatus.pending);
      
      case 'accepted':
        return const Known(MembershipStatus.accepted);
      
      case 'declined':
        return const Known(MembershipStatus.declined);
      
      default:
        return Unknown(data);
    }
  }
  

  enum PayType {
    
      monthly,
    
      daily,
    
      hourly,
    
      per_visit,
    
  }
  
  String payTypeSerializer(EnumValue<PayType> e) {
    return e.stringValue;
  }
  EnumValue<PayType> payTypeDeserializer(dynamic data) {
    switch (data) {
      
      case 'monthly':
        return const Known(PayType.monthly);
      
      case 'daily':
        return const Known(PayType.daily);
      
      case 'hourly':
        return const Known(PayType.hourly);
      
      case 'per_visit':
        return const Known(PayType.per_visit);
      
      default:
        return Unknown(data);
    }
  }
  

  enum PaymentMethod {
    
      cash,
    
      bank,
    
      mobile_wallet,
    
  }
  
  String paymentMethodSerializer(EnumValue<PaymentMethod> e) {
    return e.stringValue;
  }
  EnumValue<PaymentMethod> paymentMethodDeserializer(dynamic data) {
    switch (data) {
      
      case 'cash':
        return const Known(PaymentMethod.cash);
      
      case 'bank':
        return const Known(PaymentMethod.bank);
      
      case 'mobile_wallet':
        return const Known(PaymentMethod.mobile_wallet);
      
      default:
        return Unknown(data);
    }
  }
  

  enum SalaryPaymentStatus {
    
      scheduled,
    
      paid,
    
  }
  
  String salaryPaymentStatusSerializer(EnumValue<SalaryPaymentStatus> e) {
    return e.stringValue;
  }
  EnumValue<SalaryPaymentStatus> salaryPaymentStatusDeserializer(dynamic data) {
    switch (data) {
      
      case 'scheduled':
        return const Known(SalaryPaymentStatus.scheduled);
      
      case 'paid':
        return const Known(SalaryPaymentStatus.paid);
      
      default:
        return Unknown(data);
    }
  }
  

  enum TaskCategory {
    
      kitchen,
    
      cleaning,
    
      laundry,
    
      cooking,
    
      other,
    
  }
  
  String taskCategorySerializer(EnumValue<TaskCategory> e) {
    return e.stringValue;
  }
  EnumValue<TaskCategory> taskCategoryDeserializer(dynamic data) {
    switch (data) {
      
      case 'kitchen':
        return const Known(TaskCategory.kitchen);
      
      case 'cleaning':
        return const Known(TaskCategory.cleaning);
      
      case 'laundry':
        return const Known(TaskCategory.laundry);
      
      case 'cooking':
        return const Known(TaskCategory.cooking);
      
      case 'other':
        return const Known(TaskCategory.other);
      
      default:
        return Unknown(data);
    }
  }
  

  enum TaskLogAction {
    
      started,
    
      done,
    
      help,
    
      cant_do,
    
  }
  
  String taskLogActionSerializer(EnumValue<TaskLogAction> e) {
    return e.stringValue;
  }
  EnumValue<TaskLogAction> taskLogActionDeserializer(dynamic data) {
    switch (data) {
      
      case 'started':
        return const Known(TaskLogAction.started);
      
      case 'done':
        return const Known(TaskLogAction.done);
      
      case 'help':
        return const Known(TaskLogAction.help);
      
      case 'cant_do':
        return const Known(TaskLogAction.cant_do);
      
      default:
        return Unknown(data);
    }
  }
  

  enum TaskPriority {
    
      high,
    
      medium,
    
      low,
    
  }
  
  String taskPrioritySerializer(EnumValue<TaskPriority> e) {
    return e.stringValue;
  }
  EnumValue<TaskPriority> taskPriorityDeserializer(dynamic data) {
    switch (data) {
      
      case 'high':
        return const Known(TaskPriority.high);
      
      case 'medium':
        return const Known(TaskPriority.medium);
      
      case 'low':
        return const Known(TaskPriority.low);
      
      default:
        return Unknown(data);
    }
  }
  

  enum TaskStatus {
    
      pending,
    
      started,
    
      done,
    
      need_help,
    
      cant_do,
    
      carried_forward,
    
  }
  
  String taskStatusSerializer(EnumValue<TaskStatus> e) {
    return e.stringValue;
  }
  EnumValue<TaskStatus> taskStatusDeserializer(dynamic data) {
    switch (data) {
      
      case 'pending':
        return const Known(TaskStatus.pending);
      
      case 'started':
        return const Known(TaskStatus.started);
      
      case 'done':
        return const Known(TaskStatus.done);
      
      case 'need_help':
        return const Known(TaskStatus.need_help);
      
      case 'cant_do':
        return const Known(TaskStatus.cant_do);
      
      case 'carried_forward':
        return const Known(TaskStatus.carried_forward);
      
      default:
        return Unknown(data);
    }
  }
  



String enumSerializer(Enum e) {
  return e.name;
}



/// A sealed class representing either a known enum value or an unknown string value.
@immutable
sealed class EnumValue<T extends Enum> {
  const EnumValue();

  

  /// The string representation of the value.
  String get stringValue;
  @override
  String toString() {
    return "EnumValue($stringValue)";
  }
}

/// Represents a known, valid enum value.
class Known<T extends Enum> extends EnumValue<T> {
  /// The actual enum value.
  final T value;

  const Known(this.value);

  @override
  String get stringValue => value.name;

  @override
  String toString() {
    return "Known($stringValue)";
  }
}
/// Represents an unknown or unrecognized enum value.
class Unknown extends EnumValue<Never> {
  /// The raw string value that couldn't be mapped to a known enum.
  @override
  final String stringValue;

  const Unknown(this.stringValue);
  @override
  String toString() {
    return "Unknown($stringValue)";
  }
}

class SahakaraConnector {
  
  
  ClaimInvitedProfileVariablesBuilder claimInvitedProfile () {
    return ClaimInvitedProfileVariablesBuilder(dataConnect, );
  }
  
  
  CreateMyProfileVariablesBuilder createMyProfile ({required String name, required AccountType accountType, }) {
    return CreateMyProfileVariablesBuilder(dataConnect, name: name,accountType: accountType,);
  }
  
  
  SetMyNameVariablesBuilder setMyName ({required String name, }) {
    return SetMyNameVariablesBuilder(dataConnect, name: name,);
  }
  
  
  SetMyProfileVariablesBuilder setMyProfile ({required String name, required List<String> preferredAreas, required List<AppLanguage> spokenLanguages, }) {
    return SetMyProfileVariablesBuilder(dataConnect, name: name,preferredAreas: preferredAreas,spokenLanguages: spokenLanguages,);
  }
  
  
  SetMyLanguageVariablesBuilder setMyLanguage ({required AppLanguage language, }) {
    return SetMyLanguageVariablesBuilder(dataConnect, language: language,);
  }
  
  
  SetHouseholdAreaVariablesBuilder setHouseholdArea ({required String householdId, }) {
    return SetHouseholdAreaVariablesBuilder(dataConnect, householdId: householdId,);
  }
  
  
  CreateHouseholdVariablesBuilder createHousehold ({required String name, }) {
    return CreateHouseholdVariablesBuilder(dataConnect, name: name,);
  }
  
  
  AddHouseholdMemberVariablesBuilder addHouseholdMember ({required String householdId, required String userId, required MemberRole role, required PayType payType, required double rate, }) {
    return AddHouseholdMemberVariablesBuilder(dataConnect, householdId: householdId,userId: userId,role: role,payType: payType,rate: rate,);
  }
  
  
  InviteHouseholdMemberVariablesBuilder inviteHouseholdMember ({required String householdId, required String email, required MemberRole role, required PayType payType, required double rate, }) {
    return InviteHouseholdMemberVariablesBuilder(dataConnect, householdId: householdId,email: email,role: role,payType: payType,rate: rate,);
  }
  
  
  ReinviteHouseholdMemberVariablesBuilder reinviteHouseholdMember ({required String householdId, required String userId, required MemberRole role, required PayType payType, required double rate, }) {
    return ReinviteHouseholdMemberVariablesBuilder(dataConnect, householdId: householdId,userId: userId,role: role,payType: payType,rate: rate,);
  }
  
  
  AcceptHouseholdInviteVariablesBuilder acceptHouseholdInvite ({required String id, }) {
    return AcceptHouseholdInviteVariablesBuilder(dataConnect, id: id,);
  }
  
  
  DeclineHouseholdInviteVariablesBuilder declineHouseholdInvite ({required String id, }) {
    return DeclineHouseholdInviteVariablesBuilder(dataConnect, id: id,);
  }
  
  
  CancelHouseholdInviteVariablesBuilder cancelHouseholdInvite ({required String id, }) {
    return CancelHouseholdInviteVariablesBuilder(dataConnect, id: id,);
  }
  
  
  RemoveHouseholdMemberVariablesBuilder removeHouseholdMember ({required String id, }) {
    return RemoveHouseholdMemberVariablesBuilder(dataConnect, id: id,);
  }
  
  
  SaveContractVariablesBuilder saveContract ({required String memberId, required PayType payType, required double rate, }) {
    return SaveContractVariablesBuilder(dataConnect, memberId: memberId,payType: payType,rate: rate,);
  }
  
  
  AddDailyTaskVariablesBuilder addDailyTask ({required String householdId, required DateTime dueDate, required TaskPriority priority, }) {
    return AddDailyTaskVariablesBuilder(dataConnect, householdId: householdId,dueDate: dueDate,priority: priority,);
  }
  
  
  AssignDailyTaskVariablesBuilder assignDailyTask ({required String id, required String assignedToId, }) {
    return AssignDailyTaskVariablesBuilder(dataConnect, id: id,assignedToId: assignedToId,);
  }
  
  
  DeleteDailyTaskVariablesBuilder deleteDailyTask ({required String id, }) {
    return DeleteDailyTaskVariablesBuilder(dataConnect, id: id,);
  }
  
  
  UpdateMyTaskStatusVariablesBuilder updateMyTaskStatus ({required String id, required TaskStatus status, required TaskLogAction action, }) {
    return UpdateMyTaskStatusVariablesBuilder(dataConnect, id: id,status: status,action: action,);
  }
  
  
  AddLibraryTaskVariablesBuilder addLibraryTask ({required TaskCategory category, required String nameEn, }) {
    return AddLibraryTaskVariablesBuilder(dataConnect, category: category,nameEn: nameEn,);
  }
  
  
  DeleteLibraryTaskVariablesBuilder deleteLibraryTask ({required String id, }) {
    return DeleteLibraryTaskVariablesBuilder(dataConnect, id: id,);
  }
  
  
  AddHolidayVariablesBuilder addHoliday ({required DateTime date, required HolidayType type, required String nameEn, }) {
    return AddHolidayVariablesBuilder(dataConnect, date: date,type: type,nameEn: nameEn,);
  }
  
  
  DeleteHolidayVariablesBuilder deleteHoliday ({required String id, }) {
    return DeleteHolidayVariablesBuilder(dataConnect, id: id,);
  }
  
  
  AddPaymentPlanVariablesBuilder addPaymentPlan ({required String name, required double price, required BillingPeriod billingPeriod, }) {
    return AddPaymentPlanVariablesBuilder(dataConnect, name: name,price: price,billingPeriod: billingPeriod,);
  }
  
  
  DeletePaymentPlanVariablesBuilder deletePaymentPlan ({required String id, }) {
    return DeletePaymentPlanVariablesBuilder(dataConnect, id: id,);
  }
  
  
  SetHouseholdPlanVariablesBuilder setHouseholdPlan ({required String householdId, required String planId, required double price, }) {
    return SetHouseholdPlanVariablesBuilder(dataConnect, householdId: householdId,planId: planId,price: price,);
  }
  
  
  CheckInVariablesBuilder checkIn ({required String memberId, required DateTime day, required AttendanceDayType dayType, }) {
    return CheckInVariablesBuilder(dataConnect, memberId: memberId,day: day,dayType: dayType,);
  }
  
  
  CheckOutVariablesBuilder checkOut ({required String memberId, required DateTime day, required double overtimeHours, }) {
    return CheckOutVariablesBuilder(dataConnect, memberId: memberId,day: day,overtimeHours: overtimeHours,);
  }
  
  
  SubmitLeaveRequestVariablesBuilder submitLeaveRequest ({required String memberId, required DateTime fromDate, required DateTime toDate, required LeaveType leaveType, required bool isHalfDay, }) {
    return SubmitLeaveRequestVariablesBuilder(dataConnect, memberId: memberId,fromDate: fromDate,toDate: toDate,leaveType: leaveType,isHalfDay: isHalfDay,);
  }
  
  
  ScheduleSalaryPaymentVariablesBuilder scheduleSalaryPayment ({required String memberId, required double amount, required DateTime paymentDate, }) {
    return ScheduleSalaryPaymentVariablesBuilder(dataConnect, memberId: memberId,amount: amount,paymentDate: paymentDate,);
  }
  
  
  MarkSalaryPaymentPaidVariablesBuilder markSalaryPaymentPaid ({required String id, required String month, required PaymentMethod method, }) {
    return MarkSalaryPaymentPaidVariablesBuilder(dataConnect, id: id,month: month,method: method,);
  }
  
  
  RequestAdvanceVariablesBuilder requestAdvance ({required String memberId, required double amount, }) {
    return RequestAdvanceVariablesBuilder(dataConnect, memberId: memberId,amount: amount,);
  }
  
  
  ApproveAdvanceRequestVariablesBuilder approveAdvanceRequest ({required String id, required String month, }) {
    return ApproveAdvanceRequestVariablesBuilder(dataConnect, id: id,month: month,);
  }
  
  
  RejectAdvanceRequestVariablesBuilder rejectAdvanceRequest ({required String id, }) {
    return RejectAdvanceRequestVariablesBuilder(dataConnect, id: id,);
  }
  
  
  ReviewLeaveRequestVariablesBuilder reviewLeaveRequest ({required String id, required LeaveStatus status, }) {
    return ReviewLeaveRequestVariablesBuilder(dataConnect, id: id,status: status,);
  }
  
  
  DeleteLeaveRequestVariablesBuilder deleteLeaveRequest ({required String id, }) {
    return DeleteLeaveRequestVariablesBuilder(dataConnect, id: id,);
  }
  
  
  MyProfileVariablesBuilder myProfile () {
    return MyProfileVariablesBuilder(dataConnect, );
  }
  
  
  MyMembershipVariablesBuilder myMembership () {
    return MyMembershipVariablesBuilder(dataConnect, );
  }
  
  
  MyMembershipByIdVariablesBuilder myMembershipById ({required String id, }) {
    return MyMembershipByIdVariablesBuilder(dataConnect, id: id,);
  }
  
  
  MyHouseholdInvitesVariablesBuilder myHouseholdInvites () {
    return MyHouseholdInvitesVariablesBuilder(dataConnect, );
  }
  
  
  HouseholdMembersVariablesBuilder householdMembers ({required String householdId, }) {
    return HouseholdMembersVariablesBuilder(dataConnect, householdId: householdId,);
  }
  
  
  UserIdByEmailVariablesBuilder userIdByEmail ({required String email, }) {
    return UserIdByEmailVariablesBuilder(dataConnect, email: email,);
  }
  
  
  MaidProfileByEmailVariablesBuilder maidProfileByEmail ({required String email, }) {
    return MaidProfileByEmailVariablesBuilder(dataConnect, email: email,);
  }
  
  
  AvailableMaidsVariablesBuilder availableMaids () {
    return AvailableMaidsVariablesBuilder(dataConnect, );
  }
  
  
  CurrentContractVariablesBuilder currentContract ({required String memberId, }) {
    return CurrentContractVariablesBuilder(dataConnect, memberId: memberId,);
  }
  
  
  HouseholdTasksForDayVariablesBuilder householdTasksForDay ({required String householdId, required DateTime dueDate, }) {
    return HouseholdTasksForDayVariablesBuilder(dataConnect, householdId: householdId,dueDate: dueDate,);
  }
  
  
  MyTasksForDayVariablesBuilder myTasksForDay ({required DateTime dueDate, }) {
    return MyTasksForDayVariablesBuilder(dataConnect, dueDate: dueDate,);
  }
  
  
  LibraryTasksVariablesBuilder libraryTasks () {
    return LibraryTasksVariablesBuilder(dataConnect, );
  }
  
  
  HolidaysVariablesBuilder holidays () {
    return HolidaysVariablesBuilder(dataConnect, );
  }
  
  
  MyAttendanceVariablesBuilder myAttendance () {
    return MyAttendanceVariablesBuilder(dataConnect, );
  }
  
  
  HouseholdAttendanceVariablesBuilder householdAttendance ({required String householdId, }) {
    return HouseholdAttendanceVariablesBuilder(dataConnect, householdId: householdId,);
  }
  
  
  MyLeaveRequestsVariablesBuilder myLeaveRequests () {
    return MyLeaveRequestsVariablesBuilder(dataConnect, );
  }
  
  
  HouseholdLeaveRequestsVariablesBuilder householdLeaveRequests ({required String householdId, }) {
    return HouseholdLeaveRequestsVariablesBuilder(dataConnect, householdId: householdId,);
  }
  
  
  MySalaryPaymentsVariablesBuilder mySalaryPayments () {
    return MySalaryPaymentsVariablesBuilder(dataConnect, );
  }
  
  
  HouseholdSalaryPaymentsVariablesBuilder householdSalaryPayments ({required String householdId, }) {
    return HouseholdSalaryPaymentsVariablesBuilder(dataConnect, householdId: householdId,);
  }
  
  
  MyAdvanceRequestsVariablesBuilder myAdvanceRequests () {
    return MyAdvanceRequestsVariablesBuilder(dataConnect, );
  }
  
  
  HouseholdAdvanceRequestsVariablesBuilder householdAdvanceRequests ({required String householdId, }) {
    return HouseholdAdvanceRequestsVariablesBuilder(dataConnect, householdId: householdId,);
  }
  
  
  AdminHouseholdsVariablesBuilder adminHouseholds () {
    return AdminHouseholdsVariablesBuilder(dataConnect, );
  }
  
  
  AdminPaymentPlansVariablesBuilder adminPaymentPlans () {
    return AdminPaymentPlansVariablesBuilder(dataConnect, );
  }
  

  static ConnectorConfig connectorConfig = ConnectorConfig(
    'asia-southeast1',
    'sahakara',
    'sahakara-f78dd-service',
  );

  SahakaraConnector({required this.dataConnect});
  static SahakaraConnector get instance {
    
    return SahakaraConnector(
        dataConnect: FirebaseDataConnect.instanceFor(
            connectorConfig: connectorConfig,
            
            sdkType: CallerSDKType.generated));
  }

  FirebaseDataConnect dataConnect;
}
