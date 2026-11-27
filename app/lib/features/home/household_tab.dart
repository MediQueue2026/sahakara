import 'package:flutter/material.dart';

import '../../core/app_data.dart';
import '../../core/app_language.dart';
import '../../core/strings.dart';
import '../../core/theme.dart';
import '../../core/glass.dart';
import 'add_maid_screen.dart';

/// Owner: the household's details and maids — including those who haven't
/// accepted their request yet — and asking a maid to join.
class HouseholdTab extends StatefulWidget {
  final LanguageController lang;
  final Membership membership;
  final Profile profile;

  const HouseholdTab({
    super.key,
    required this.lang,
    required this.membership,
    required this.profile,
  });

  @override
  State<HouseholdTab> createState() => _HouseholdTabState();
}

class _HouseholdTabState extends State<HouseholdTab> {
  late Future<List<Member>> _members;

  String get _householdId => widget.membership.household.id;

  @override
  void initState() {
    super.initState();
    _members = AppData.fetchHouseholdMembers(_householdId);
  }

  void _reload() => setState(() {
        _members = AppData.fetchHouseholdMembers(_householdId);
      });

  Future<void> _addMaid() async {
    final sent = await Navigator.of(context).push<bool>(
      MaterialPageRoute(
        builder: (_) =>
            AddMaidScreen(lang: widget.lang, householdId: _householdId),
      ),
    );
    if (sent == true) _reload();
  }

  Future<void> _cancelInvite(Member m) async {
    try {
      await AppData.cancelHouseholdInvite(m.id);
      _reload();
    } catch (e) {
      if (!mounted) return;
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(e.toString())));
    }
  }

  Future<void> _removeMember(Member m, AppLanguage lang) async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(Strings.of('removeFromHousehold', lang)),
        content: Text(
          Strings.of('confirmRemoveMember', lang)
              .replaceFirst('{name}', m.user.name),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: Text(Strings.of('cancel', lang)),
          ),
          FilledButton(
            onPressed: () => Navigator.pop(context, true),
            child: Text(Strings.of('remove', lang)),
          ),
        ],
      ),
    );
    if (confirmed != true) return;
    try {
      await AppData.removeHouseholdMember(m.id);
      _reload();
    } catch (e) {
      if (!mounted) return;
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(e.toString())));
    }
  }

  /// Staff the owner removed: they joined once but are no longer active.
  static bool _isRemoved(Member m) =>
      m.status.stringValue == 'accepted' && !m.active;

  Widget _memberAvatar(Member member) {
    return _avatar(
      name: member.user.name,
      photoUrl: member.user.profilePhoto,
    );
  }

  Widget _ownerAvatar() {
    return _avatar(
      name: widget.profile.name,
      photoUrl: widget.profile.profilePhoto,
    );
  }

  Widget _avatar({required String name, required String? photoUrl}) {
    name = name.trim();
    final initial = name.isEmpty
        ? '?'
        : String.fromCharCode(name.runes.first).toUpperCase();

    Widget fallback() => Text(
          initial,
          style: const TextStyle(fontWeight: FontWeight.w600),
        );

    return CircleAvatar(
      backgroundColor: brandGoldSoft,
      child: photoUrl == null || photoUrl.isEmpty
          ? fallback()
          : ClipOval(
              child: Image.network(
                photoUrl,
                width: 40,
                height: 40,
                fit: BoxFit.cover,
                errorBuilder: (_, __, ___) => fallback(),
                loadingBuilder: (_, child, progress) =>
                    progress == null ? child : fallback(),
              ),
            ),
    );
  }

  /// A member's card: name and role, and a button to remove staff; for a
  /// request that hasn't been accepted, where it stands and a button to
  /// cancel or remove it.
  Widget _memberCard(Member m, AppLanguage lang) {
    final status = m.status.stringValue;
    final accepted = status == 'accepted';
    return Card(
      child: ListTile(
        leading: _memberAvatar(m),
        title: Text(m.user.name),
        subtitle: Text(
          accepted ? m.role.stringValue : Strings.of('invite_$status', lang),
        ),
        trailing: accepted
            ? IconButton(
                tooltip: Strings.of('removeFromHousehold', lang),
                icon: const Icon(Icons.person_remove_outlined),
                onPressed: () => _removeMember(m, lang),
              )
            : IconButton(
                tooltip: Strings.of(
                  status == 'pending' ? 'cancelRequest' : 'remove',
                  lang,
                ),
                icon: const Icon(Icons.close),
                onPressed: () => _cancelInvite(m),
              ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final household = widget.membership.household;
    return ValueListenableBuilder<AppLanguage>(
      valueListenable: widget.lang,
      builder: (context, lang, _) {
        return ListView(
          padding: clearOfGlassBar(context, const EdgeInsets.all(16)),
          children: [
            Row(
              children: [
                _ownerAvatar(),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        household.name,
                        style: Theme.of(context).textTheme.headlineSmall,
                      ),
                      if (household.address?.isNotEmpty == true)
                        Text(
                          household.address!,
                          style: Theme.of(context).textTheme.bodyMedium,
                        ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            FutureBuilder<List<Member>>(
              future: _members,
              builder: (context, snapshot) {
                if (!snapshot.hasData) {
                  return const Center(child: CircularProgressIndicator());
                }
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: snapshot.data!
                      .where(
                        (m) => m.role.stringValue != 'owner' && !_isRemoved(m),
                      )
                      .map((m) => _memberCard(m, lang))
                      .toList(),
                );
              },
            ),
            const SizedBox(height: 16),
            FilledButton.icon(
              onPressed: _addMaid,
              icon: const Icon(Icons.person_add_alt_1_outlined),
              label: Text(Strings.of('browseAvailableMaids', lang)),
            ),
          ],
        );
      },
    );
  }
}
