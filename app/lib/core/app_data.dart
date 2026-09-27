import 'supabase_client.dart';

/// Small data-access helpers shared across the mobile screens. Kept as plain
/// static functions over raw maps (no model classes yet) — the schema is in
/// supabase/migrations, this just mirrors it thinly.
class AppData {
  /// Finds or creates the `users` row for the signed-in phone number.
  ///
  /// An owner can add a maid by phone before she has ever logged in
  /// (see [addMaidByPhone]), which creates a `users` row with no
  /// `auth_user_id` yet. The first time that phone number actually signs
  /// in, this claims that row instead of creating a duplicate one.
  static Future<Map<String, dynamic>> ensureUserProfile() async {
    final authUser = supabase.auth.currentUser!;
    final phone = authUser.phone ?? '';

    final existing = await supabase
        .from('users')
        .select()
        .eq('phone', phone)
        .maybeSingle();

    if (existing != null) {
      if (existing['auth_user_id'] == null) {
        return await supabase
            .from('users')
            .update({'auth_user_id': authUser.id})
            .eq('id', existing['id'])
            .select()
            .single();
      }
      return existing;
    }

    return await supabase
        .from('users')
        .insert({
          'auth_user_id': authUser.id,
          'phone': phone,
          'name': phone,
          'language': 'en',
        })
        .select()
        .single();
  }

  static Future<void> setLanguage(String userId, String language) async {
    await supabase
        .from('users')
        .update({'language': language})
        .eq('id', userId);
  }

  /// The signed-in user's first active household membership. The schema
  /// supports several (multi-house, Phase 3) — the basics here just use
  /// the first one.
  static Future<Map<String, dynamic>?> fetchMyMembership(String userId) async {
    final rows = await supabase
        .from('household_members')
        .select('*, households(*)')
        .eq('user_id', userId)
        .eq('active', true)
        .order('joined_on')
        .limit(1);
    if (rows.isEmpty) return null;
    return rows.first;
  }

  static Future<Map<String, dynamic>> createHousehold({
    required String ownerId,
    required String name,
    required String address,
  }) async {
    final household = await supabase
        .from('households')
        .insert({'name': name, 'address': address, 'owner_id': ownerId})
        .select()
        .single();

    await supabase.from('household_members').insert({
      'household_id': household['id'],
      'user_id': ownerId,
      'role': 'owner',
    });

    return household;
  }

  static Future<List<Map<String, dynamic>>> fetchHouseholdMembers(
    String householdId,
  ) async {
    final rows = await supabase
        .from('household_members')
        .select('*, users(*)')
        .eq('household_id', householdId)
        .order('joined_on');
    return List<Map<String, dynamic>>.from(rows);
  }

  /// Owner adds a maid by phone number — finds or creates her `users` row
  /// (see [ensureUserProfile] for the matching claim-on-login side) and
  /// links her into the household.
  static Future<void> addMaidByPhone({
    required String householdId,
    required String phone,
  }) async {
    var user = await supabase
        .from('users')
        .select()
        .eq('phone', phone)
        .maybeSingle();
    user ??= await supabase
        .from('users')
        .insert({'phone': phone, 'name': phone, 'language': 'en'})
        .select()
        .single();

    await supabase.from('household_members').insert({
      'household_id': householdId,
      'user_id': user['id'],
      'role': 'maid',
    });
  }

  static Future<Map<String, dynamic>?> fetchCurrentContract(
    String memberId,
  ) async {
    return await supabase
        .from('contracts')
        .select()
        .eq('member_id', memberId)
        .isFilter('end_date', null)
        .maybeSingle();
  }

  /// Closes any open contract for [memberId] and inserts a new one — a raise
  /// or a changed schedule is a new contract row, not an edit, so past
  /// months still calculate at the old rate.
  static Future<void> saveContract({
    required String memberId,
    required String payType,
    required double rate,
    required String offDays,
    required String workingHours,
  }) async {
    await supabase
        .from('contracts')
        .update({'end_date': DateTime.now().toIso8601String().substring(0, 10)})
        .eq('member_id', memberId)
        .isFilter('end_date', null);

    await supabase.from('contracts').insert({
      'member_id': memberId,
      'pay_type': payType,
      'rate': rate,
      'off_days': offDays,
      'working_hours': workingHours,
    });
  }

  static Future<List<Map<String, dynamic>>> fetchTaskLibrary() async {
    final rows = await supabase
        .from('task_library')
        .select()
        .order('category')
        .order('name_en');
    return List<Map<String, dynamic>>.from(rows);
  }
}
