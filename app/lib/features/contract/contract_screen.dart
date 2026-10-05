import 'package:flutter/material.dart';

import '../../core/app_data.dart';
import '../../core/app_language.dart';
import 'contract_detail_screen.dart';

/// Owner: pick a staff member to view/edit their contract. Staff see their
/// own contract on the My contract tab instead (see HomeShell).
class ContractScreen extends StatelessWidget {
  final LanguageController lang;
  final Membership membership;

  const ContractScreen({
    super.key,
    required this.lang,
    required this.membership,
  });

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Member>>(
      future: AppData.fetchHouseholdMembers(membership.household.id),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return const Center(child: CircularProgressIndicator());
        }
        final staff = snapshot.data!
            // A maid who hasn't accepted yet has only the contract they were
            // offered, which can't be edited until they answer.
            .where(
              (m) =>
                  m.role.stringValue != 'owner' &&
                  m.status.stringValue == 'accepted',
            )
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
