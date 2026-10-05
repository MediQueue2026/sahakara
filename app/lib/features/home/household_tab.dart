import 'package:flutter/material.dart';

import '../../core/app_data.dart';
import '../../core/app_language.dart';
import '../../core/strings.dart';
import '../../core/theme.dart';
import 'add_maid_screen.dart';

/// Owner: the household's details and members — including maids who
/// haven't accepted their request yet — and asking a maid to join.
class HouseholdTab extends StatefulWidget {
  final LanguageController lang;
  final Membership membership;

  const HouseholdTab({super.key, required this.lang, required this.membership});

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

  /// A member's card: name and role, and for a request that hasn't been
  /// accepted, where it stands and a button to cancel or remove it.
  Widget _memberCard(Member m, AppLanguage lang) {
    final status = m.status.stringValue;
    final accepted = status == 'accepted';
    return Card(
      child: ListTile(
        leading: accepted
            ? null
            : Icon(
                status == 'pending'
                    ? Icons.hourglass_empty
                    : Icons.cancel_outlined,
                color: mutedText,
              ),
        title: Text(m.user.name),
        subtitle: Text(
          accepted ? m.role.stringValue : Strings.of('invite_$status', lang),
        ),
        trailing: accepted
            ? null
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
          padding: const EdgeInsets.all(16),
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
            const SizedBox(height: 20),
            FutureBuilder<List<Member>>(
              future: _members,
              builder: (context, snapshot) {
                if (!snapshot.hasData) {
                  return const Center(child: CircularProgressIndicator());
                }
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children:
                      snapshot.data!.map((m) => _memberCard(m, lang)).toList(),
                );
              },
            ),
            const SizedBox(height: 16),
            FilledButton.icon(
              onPressed: _addMaid,
              icon: const Icon(Icons.person_add_alt_1_outlined),
              label: Text(Strings.of('addMaid', lang)),
            ),
          ],
        );
      },
    );
  }
}
