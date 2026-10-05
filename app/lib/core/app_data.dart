import 'dart:math';
import 'dart:typed_data';

import 'package:firebase_storage/firebase_storage.dart';

import '../dataconnect_generated/sahakara.dart';
import 'firebase_client.dart';

// Shorter names for the generated Data Connect result types the screens use.
typedef Profile = MyProfileUsers;
typedef Membership = MyMembershipHouseholdMembers;
typedef MaidProfile = MaidProfileByEmailUsers;
typedef Household = MyMembershipHouseholdMembersHousehold;
typedef Member = HouseholdMembersHouseholdMembers;
typedef CurrentContract = CurrentContractContracts;
typedef HouseholdInvite = MyHouseholdInvitesHouseholdMembers;
typedef LibraryTask = LibraryTasksLibraryTasks;
typedef HouseholdTask = HouseholdTasksForDayTasks;
typedef MyTask = MyTasksForDayTasks;
typedef AttendanceRecord = MyAttendanceAttendances;
typedef LeaveRequest = MyLeaveRequestsLeaveRequests;
typedef HouseholdAttendance = HouseholdAttendanceAttendances;
typedef HouseholdLeaveRequest = HouseholdLeaveRequestsLeaveRequests;
typedef MySalaryPayment = MySalaryPaymentsSalaryPayments;
typedef HouseholdSalaryPayment = HouseholdSalaryPaymentsSalaryPayments;
typedef MyAdvanceRequest = MyAdvanceRequestsAdvanceRequests;
typedef HouseholdAdvanceRequest = HouseholdAdvanceRequestsAdvanceRequests;

/// The account type and (on sign-up) name picked on the login screen,
/// handed to [AppData.ensureUserProfile] once Firebase Auth has signed in.
class AuthIntent {
  final AccountType accountType;
  final String? name;

  const AuthIntent({required this.accountType, this.name});
}

/// Signed in through the owner option with a maid account, or vice versa.
class WrongAccountTypeException implements Exception {
  /// The type the account is actually registered as: 'owner' or 'maid'.
  final String accountType;

  const WrongAccountTypeException(this.accountType);
}

/// Small data-access helpers shared across the mobile screens. Each one
/// calls an operation from dataconnect/connector/ — that's where the schema
/// and the access rules live; this just wraps them thinly.
class AppData {
  /// Finds or creates the `User` row for the signed-in account.
  ///
  /// [signUp] carries what the login screen collected: it's set for the
  /// session that just signed up or signed in, and null when the app starts
  /// on a remembered session. A brand-new account is saved with its name and
  /// account type; an existing one must match the type chosen on the login
  /// screen, or this throws [WrongAccountTypeException]. Returns null when
  /// there's no row yet and no [signUp] to say which type to save — the
  /// caller then asks the user.
  ///
  /// An owner can add a maid by email before they have ever logged in
  /// (see [addMaidByEmail]), which creates a `User` row with no `authUid`
  /// yet. The first time that email address actually signs in, this claims
  /// that row instead of creating a duplicate one. The same goes for a row
  /// whose Firebase account was deleted and re-created (e.g. the Auth
  /// emulator dropping its users on restart).
  static Future<Profile?> ensureUserProfile({AuthIntent? signUp}) async {
    var profile = await _myProfile();
    if (profile == null) {
      if (signUp == null) return null;
      await db
          .createMyProfile(
            name: signUp.name ?? auth.currentUser?.email ?? '',
            accountType: signUp.accountType,
          )
          .execute();
      return (await _myProfile())!;
    }
    final storedType = profile.accountType.stringValue;
    if (signUp != null && storedType != signUp.accountType.name) {
      throw WrongAccountTypeException(storedType);
    }
    if (profile.authUid != auth.currentUser?.uid) {
      await db.claimInvitedProfile().execute();
      final name = signUp?.name;
      if (name != null) await db.setMyName(name: name).execute();
      profile = await _myProfile();
    }
    return profile!;
  }

  /// The signed-in user's profile as currently saved, e.g. to show edits
  /// made in Settings.
  static Future<Profile?> fetchMyProfile() => _myProfile();

  static Future<Profile?> _myProfile() async {
    final result = await db.myProfile().execute();
    return result.data.users.firstOrNull;
  }

  /// [language] is an app language code: 'en', 'si' or 'ta'.
  static Future<void> setLanguage(String language) async {
    await db
        .setMyLanguage(language: AppLanguage.values.byName(language))
        .execute();
  }

  /// Saves the signed-in user's own profile. [spokenLanguages] are app
  /// language codes: 'en', 'si' or 'ta'. Owners pass no [preferredAreas].
  static Future<void> saveProfile({
    required String name,
    List<String> preferredAreas = const [],
    required List<String> spokenLanguages,
  }) async {
    await db
        .setMyProfile(
          name: name,
          preferredAreas: preferredAreas,
          spokenLanguages:
              spokenLanguages.map(AppLanguage.values.byName).toList(),
        )
        .execute();
  }

  /// The signed-in user's first active household membership. The schema
  /// supports several (multi-house, Phase 3) — the basics here just use
  /// the first one.
  static Future<Membership?> fetchMyMembership() async {
    final result = await db.myMembership().execute();
    return result.data.householdMembers.firstOrNull;
  }

  static Future<Membership?> fetchMyMembershipById(String id) async {
    final result = await db.myMembershipById(id: id).execute();
    final member = result.data.householdMembers.firstOrNull;
    if (member == null) return null;
    return Membership(
      id: member.id,
      role: member.role,
      household: MyMembershipHouseholdMembersHousehold(
        id: member.household.id,
        name: member.household.name,
        address: member.household.address,
      ),
    );
  }

  /// Creates the household with the signed-in user as its owner.
  static Future<void> createHousehold({
    required String name,
    required String address,
  }) async {
    await db.createHousehold(name: name).address(address).execute();
  }

  static Future<List<Member>> fetchHouseholdMembers(String householdId) async {
    final result =
        await db.householdMembers(householdId: householdId).execute();
    return result.data.householdMembers;
  }

  /// Owner asks a maid, by email address, to join the household on the
  /// proposed contract. Links their existing `User` row, or pre-creates one
  /// (see [ensureUserProfile] for the matching claim-on-login side). They
  /// join as a pending member and become staff only once they accept
  /// (see [fetchMyHouseholdInvites]). Someone the owner removed earlier gets
  /// their old member row back as a pending request, keeping their history.
  static Future<void> addMaidByEmail({
    required String householdId,
    required String email,
    required String payType,
    required double rate,
    double? allowance,
    String? offDays,
    String? workingHours,
  }) async {
    // Firebase Auth lower-cases emails, so match that when looking up and
    // pre-creating rows.
    email = email.trim().toLowerCase();
    final pay = PayType.values.byName(payType);
    final existing = await db.userIdByEmail(email: email).execute();
    final userId = existing.data.users.firstOrNull?.id;
    final wasRemoved = userId != null &&
        (await fetchHouseholdMembers(householdId)).any(
          (m) =>
              m.user.id == userId &&
              m.status.stringValue == 'accepted' &&
              !m.active,
        );
    if (wasRemoved) {
      await db
          .reinviteHouseholdMember(
            householdId: householdId,
            userId: userId,
            role: MemberRole.maid,
            payType: pay,
            rate: rate,
          )
          .allowance(allowance)
          .offDays(offDays)
          .workingHours(workingHours)
          .execute();
    } else if (userId != null) {
      await db
          .addHouseholdMember(
            householdId: householdId,
            userId: userId,
            role: MemberRole.maid,
            payType: pay,
            rate: rate,
          )
          .allowance(allowance)
          .offDays(offDays)
          .workingHours(workingHours)
          .execute();
    } else {
      await db
          .inviteHouseholdMember(
            householdId: householdId,
            email: email,
            role: MemberRole.maid,
            payType: pay,
            rate: rate,
          )
          .allowance(allowance)
          .offDays(offDays)
          .workingHours(workingHours)
          .execute();
    }
  }

  /// The maid profile for [email], for an owner to look at before asking
  /// them to join. Null when that address has no maid account yet.
  static Future<MaidProfile?> fetchMaidProfileByEmail(String email) async {
    final result = await db
        .maidProfileByEmail(email: email.trim().toLowerCase())
        .execute();
    return result.data.users.firstOrNull;
  }

  /// Owner sets the town or neighbourhood the house is in. An empty
  /// [area] clears it.
  static Future<void> setHouseholdArea({
    required String householdId,
    required String area,
  }) async {
    await db
        .setHouseholdArea(householdId: householdId)
        .area(area.trim().isEmpty ? null : area.trim())
        .execute();
  }

  /// Owner withdraws a request that hasn't been accepted, or removes one
  /// that was declined.
  static Future<void> cancelHouseholdInvite(String memberId) async {
    await db.cancelHouseholdInvite(id: memberId).execute();
  }

  /// Owner removes a staff member who had joined: they become inactive (their
  /// history is kept), their contract ends today and their upcoming tasks
  /// are unassigned.
  static Future<void> removeHouseholdMember(String memberId) async {
    await db.removeHouseholdMember(id: memberId).execute();
  }

  /// Requests for the signed-in user to join a household that are waiting
  /// for an answer, each with its proposed contract.
  static Future<List<HouseholdInvite>> fetchMyHouseholdInvites() async {
    final result = await db.myHouseholdInvites().execute();
    return result.data.householdMembers;
  }

  /// Accepting makes the signed-in user an active member of that household
  /// and starts the proposed contract today.
  static Future<void> respondToHouseholdInvite({
    required String memberId,
    required bool accept,
  }) async {
    if (accept) {
      await db.acceptHouseholdInvite(id: memberId).execute();
    } else {
      await db.declineHouseholdInvite(id: memberId).execute();
    }
  }

  static Future<CurrentContract?> fetchCurrentContract(String memberId) async {
    final result = await db.currentContract(memberId: memberId).execute();
    return result.data.contracts.firstOrNull;
  }

  /// Closes any open contract for [memberId] and inserts a new one — a raise
  /// or a changed schedule is a new contract row, not an edit, so past
  /// months still calculate at the old rate. Both happen in one transaction
  /// (see SaveContract in dataconnect/connector/mutations.gql).
  static Future<void> saveContract({
    required String memberId,
    required String payType,
    required double rate,
    double? allowance,
    String? offDays,
    String? workingHours,
  }) async {
    await db
        .saveContract(
          memberId: memberId,
          payType: PayType.values.byName(payType),
          rate: rate,
        )
        .allowance(allowance)
        .offDays(offDays)
        .workingHours(workingHours)
        .execute();
  }

  static Future<List<LibraryTask>> fetchTaskLibrary() async {
    final result = await db.libraryTasks().execute();
    return result.data.libraryTasks;
  }

  /// Every task due on [day] in the household (owner only).
  static Future<List<HouseholdTask>> fetchHouseholdTasks({
    required String householdId,
    required DateTime day,
  }) async {
    final result = await db
        .householdTasksForDay(householdId: householdId, dueDate: day)
        .execute();
    return result.data.tasks;
  }

  /// The signed-in staff member's own tasks due on [day].
  static Future<List<MyTask>> fetchMyTasks(DateTime day) async {
    final result = await db.myTasksForDay(dueDate: day).execute();
    return result.data.tasks;
  }

  /// Owner adds a task for [day], assigned to the staff member
  /// [assignedToId] — or to nobody yet when that's null (see
  /// [assignDailyTask]). Pass either [libraryId] (a task from the shared
  /// library) or [customTitle], and optionally a [photoUrl] explaining the
  /// task (from [uploadTaskPhoto]).
  static Future<void> addDailyTask({
    required String householdId,
    String? assignedToId,
    required DateTime day,
    String? libraryId,
    String? customTitle,
    String? customTitleSi,
    String? customTitleTa,
    int? estMinutes,
    required String priority,
    String? photoUrl,
  }) async {
    await db
        .addDailyTask(
          householdId: householdId,
          dueDate: day,
          priority: TaskPriority.values.byName(priority),
        )
        .assignedToId(assignedToId)
        .libraryId(libraryId)
        .customTitle(customTitle)
        .customTitleSi(customTitleSi)
        .customTitleTa(customTitleTa)
        .estMinutes(estMinutes)
        .photoUrl(photoUrl)
        .execute();
  }

  /// Uploads a photo explaining a task (JPEG [bytes]) to Cloud Storage and
  /// returns its download URL, to pass to [addDailyTask] as `photoUrl`.
  static Future<String> uploadTaskPhoto({
    required String householdId,
    required Uint8List bytes,
  }) async {
    final name =
        '${DateTime.now().microsecondsSinceEpoch}_${Random().nextInt(1 << 32)}.jpg';
    final ref = storage.ref('households/$householdId/tasks/$name');
    await ref.putData(bytes, SettableMetadata(contentType: 'image/jpeg'));
    return ref.getDownloadURL();
  }

  /// Owner assigns a task to [assignedToId], or moves it to them from
  /// someone else. The task starts over as pending.
  static Future<void> assignDailyTask({
    required String taskId,
    required String assignedToId,
  }) async {
    await db.assignDailyTask(id: taskId, assignedToId: assignedToId).execute();
  }

  static Future<void> deleteDailyTask(String taskId) async {
    await db.deleteDailyTask(id: taskId).execute();
  }

  /// Staff member reports progress on their own task: [status] is one of
  /// 'started', 'done', 'need_help' or 'cant_do', and [cantDoReason] is
  /// required for 'cant_do' (and only then). [note] and [photoUrl] are an
  /// optional explanation for 'need_help' / 'cant_do' that the owner sees.
  /// Also logged in TaskLog.
  static Future<void> updateMyTaskStatus({
    required String taskId,
    required String status,
    String? cantDoReason,
    String? note,
    String? photoUrl,
  }) async {
    await db
        .updateMyTaskStatus(
          id: taskId,
          status: TaskStatus.values.byName(status),
          action: TaskLogAction.values.byName(
            status == 'need_help' ? 'help' : status,
          ),
        )
        .cantDoReason(
          cantDoReason == null
              ? null
              : CantDoReason.values.byName(cantDoReason),
        )
        .note(note)
        .photoUrl(photoUrl)
        .execute();
  }

  // ── Attendance and Leave Methods ──

  static Future<void> checkIn({
    required String memberId,
    required DateTime day,
    required String dayType,
  }) async {
    await db
        .checkIn(
          memberId: memberId,
          day: day,
          dayType: AttendanceDayType.values.byName(dayType),
        )
        .execute();
  }

  static Future<void> checkOut({
    required String memberId,
    required DateTime day,
    required double overtimeHours,
  }) async {
    await db
        .checkOut(
          memberId: memberId,
          day: day,
          overtimeHours: overtimeHours,
        )
        .execute();
  }

  static Future<void> submitLeaveRequest({
    required String memberId,
    required DateTime fromDate,
    required DateTime toDate,
    required String leaveType,
    required bool isHalfDay,
    String? reason,
  }) async {
    await db
        .submitLeaveRequest(
          memberId: memberId,
          fromDate: fromDate,
          toDate: toDate,
          leaveType: LeaveType.values.byName(leaveType),
          isHalfDay: isHalfDay,
        )
        .reason(reason)
        .execute();
  }

  static Future<void> reviewLeaveRequest({
    required String id,
    required String status,
  }) async {
    await db
        .reviewLeaveRequest(
          id: id,
          status: LeaveStatus.values.byName(status),
        )
        .execute();
  }

  static Future<void> deleteLeaveRequest(String id) async {
    await db.deleteLeaveRequest(id: id).execute();
  }

  static Future<List<AttendanceRecord>> fetchMyAttendance() async {
    final result = await db.myAttendance().execute();
    return result.data.attendances;
  }

  static Future<List<HouseholdAttendance>> fetchHouseholdAttendance(
      String householdId) async {
    final result =
        await db.householdAttendance(householdId: householdId).execute();
    return result.data.attendances;
  }

  static Future<List<LeaveRequest>> fetchMyLeaveRequests() async {
    final result = await db.myLeaveRequests().execute();
    return result.data.leaveRequests;
  }

  static Future<List<HouseholdLeaveRequest>> fetchHouseholdLeaveRequests(
      String householdId) async {
    final result =
        await db.householdLeaveRequests(householdId: householdId).execute();
    return result.data.leaveRequests;
  }

  static Future<List<MySalaryPayment>> fetchMySalaryPayments() async {
    final result = await db.mySalaryPayments().execute();
    return result.data.salaryPayments;
  }

  static Future<List<HouseholdSalaryPayment>> fetchHouseholdSalaryPayments(
    String householdId,
  ) async {
    final result =
        await db.householdSalaryPayments(householdId: householdId).execute();
    return result.data.salaryPayments;
  }

  static Future<void> scheduleSalaryPayment({
    required String memberId,
    required double amount,
    required DateTime paymentDate,
    String? note,
  }) async {
    await db
        .scheduleSalaryPayment(
          memberId: memberId,
          amount: amount,
          paymentDate: paymentDate,
        )
        .note(note)
        .execute();
  }

  static Future<void> markSalaryPaymentPaid({
    required String id,
    required DateTime paymentDate,
    required String method,
  }) async {
    final month =
        '${paymentDate.year}-${paymentDate.month.toString().padLeft(2, '0')}';
    await db
        .markSalaryPaymentPaid(
          id: id,
          month: month,
          method: PaymentMethod.values.byName(method),
        )
        .execute();
  }

  static Future<List<MyAdvanceRequest>> fetchMyAdvanceRequests() async {
    final result = await db.myAdvanceRequests().execute();
    return result.data.advanceRequests;
  }

  static Future<List<HouseholdAdvanceRequest>> fetchHouseholdAdvanceRequests(
    String householdId,
  ) async {
    final result =
        await db.householdAdvanceRequests(householdId: householdId).execute();
    return result.data.advanceRequests;
  }

  static Future<void> requestAdvance({
    required String memberId,
    required double amount,
    String? reason,
  }) async {
    await db
        .requestAdvance(memberId: memberId, amount: amount)
        .reason(reason)
        .execute();
  }

  static Future<void> reviewAdvanceRequest({
    required String id,
    required String status,
  }) async {
    switch (AdvanceRequestStatus.values.byName(status)) {
      case AdvanceRequestStatus.approved:
        final now = DateTime.now();
        final month = '${now.year}-${now.month.toString().padLeft(2, '0')}';
        await db.approveAdvanceRequest(id: id, month: month).execute();
      case AdvanceRequestStatus.rejected:
        await db.rejectAdvanceRequest(id: id).execute();
      case AdvanceRequestStatus.pending:
        throw ArgumentError.value(
            status, 'status', 'Must be approved or rejected');
    }
  }
}
