import '../dataconnect_generated/sahakara.dart';
import 'firebase_client.dart';

// Shorter names for the generated Data Connect result types the screens use.
typedef Profile = MyProfileUsers;
typedef Membership = MyMembershipHouseholdMembers;
typedef Member = HouseholdMembersHouseholdMembers;
typedef CurrentContract = CurrentContractContracts;
typedef LibraryTask = LibraryTasksLibraryTasks;

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
  /// An owner can add a maid by email before she has ever logged in
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

  /// The signed-in user's first active household membership. The schema
  /// supports several (multi-house, Phase 3) — the basics here just use
  /// the first one.
  static Future<Membership?> fetchMyMembership() async {
    final result = await db.myMembership().execute();
    return result.data.householdMembers.firstOrNull;
  }

  /// Creates the household with the signed-in user as its owner.
  static Future<void> createHousehold({
    required String name,
    required String address,
  }) async {
    await db.createHousehold(name: name).address(address).execute();
  }

  static Future<List<Member>> fetchHouseholdMembers(String householdId) async {
    final result = await db
        .householdMembers(householdId: householdId)
        .execute();
    return result.data.householdMembers;
  }

  /// Owner adds a maid by email address — links her existing `User` row, or
  /// pre-creates one (see [ensureUserProfile] for the matching
  /// claim-on-login side), into the household.
  static Future<void> addMaidByEmail({
    required String householdId,
    required String email,
  }) async {
    // Firebase Auth lower-cases emails, so match that when looking up and
    // pre-creating rows.
    email = email.trim().toLowerCase();
    final existing = await db.userIdByEmail(email: email).execute();
    final userId = existing.data.users.firstOrNull?.id;
    if (userId != null) {
      await db
          .addHouseholdMember(
            householdId: householdId,
            userId: userId,
            role: MemberRole.maid,
          )
          .execute();
    } else {
      await db
          .inviteHouseholdMember(
            householdId: householdId,
            email: email,
            role: MemberRole.maid,
          )
          .execute();
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
    required String offDays,
    required String workingHours,
  }) async {
    await db
        .saveContract(
          memberId: memberId,
          payType: PayType.values.byName(payType),
          rate: rate,
        )
        .offDays(offDays)
        .workingHours(workingHours)
        .execute();
  }

  static Future<List<LibraryTask>> fetchTaskLibrary() async {
    final result = await db.libraryTasks().execute();
    return result.data.libraryTasks;
  }
}
