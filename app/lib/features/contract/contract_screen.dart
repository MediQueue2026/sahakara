import 'package:flutter/material.dart';

import '../../core/app_data.dart';
import '../../core/app_language.dart';
import 'contract_detail_screen.dart';

/// Owner: pick a household member to view/edit their contract.
/// Everyone else: their own contract, straight away.
class ContractScreen extends StatelessWidget {
  final LanguageController lang;
  final Map<String, dynamic> profile;
  final Map<String, dynamic> membership;

  const ContractScreen({
    super.key,
    required this.lang,
    required this.profile,
    required this.membership,
  });

  @override
  Widget build(BuildContext context) {
    final isOwner = membership['role'] == 'owner';

    if (!isOwner) {
      return ContractDetailScreen(
        lang: lang,
        memberId: membership['id'] as String,
        memberName: profile['name'] as String? ?? '',
        editable: false,
      );
    }

    return FutureBuilder<List<Map<String, dynamic>>>(
      future: AppData.fetchHouseholdMembers(
        membership['household_id'] as String,
      ),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return const Center(child: CircularProgressIndicator());
        }
        final staff = snapshot.data!
            .where((m) => m['role'] != 'owner')
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
                    title: Text(
                      (m['users']?['name'] as String?) ??
                          m['users']?['phone'] ??
                          '',
                    ),
                    subtitle: Text(m['role'] as String),
                    trailing: const Icon(Icons.chevron_right),
                    onTap: () => Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (_) => ContractDetailScreen(
                          lang: lang,
                          memberId: m['id'] as String,
                          memberName: (m['users']?['name'] as String?) ?? '',
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
