import 'package:flutter/material.dart';

import '../../core/app_data.dart';
import '../../core/app_language.dart';
import 'contract_detail_screen.dart';

/// Owner: pick a household member to view/edit their contract.
/// Everyone else: their own contract, straight away.
class ContractScreen extends StatelessWidget {
  final LanguageController lang;
  final Profile profile;
  final Membership membership;

  const ContractScreen({
    super.key,
    required this.lang,
    required this.profile,
    required this.membership,
  });

  @override
  Widget build(BuildContext context) {
    final isOwner = membership.role.stringValue == 'owner';

    if (!isOwner) {
      return ContractDetailScreen(
        lang: lang,
        memberId: membership.id,
        memberName: profile.name,
        editable: false,
      );
    }

    return FutureBuilder<List<Member>>(
      future: AppData.fetchHouseholdMembers(membership.household.id),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return const Center(child: CircularProgressIndicator());
        }
        final staff = snapshot.data!
            .where((m) => m.role.stringValue != 'owner')
            .toList();
        if (staff.isEmpty) {
          return const Center(
            child: Text('Add household staff from the Household tab first.'),
          );
        }
        return ListView(
          padding: const EdgeInsets.all(16),
          children: staff
              .map(
                (m) => Card(
                  child: ListTile(
                    title: Text(m.user.name),
                    subtitle: Text(m.role.stringValue),
                    trailing: const Icon(Icons.chevron_right),
                    onTap: () => Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (_) => ContractDetailScreen(
                          lang: lang,
                          memberId: m.id,
                          memberName: m.user.name,
                          editable: true,
                        ),
                      ),
                    ),
                  ),
                ),
              )
              .toList(),
        );
      },
    );
  }
}
