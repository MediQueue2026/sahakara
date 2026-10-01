import 'package:flutter/material.dart';

import '../../core/firebase_client.dart';
import '../../dataconnect_generated/sahakara.dart';
import '../../core/theme.dart';

class HouseholdsAdminPage extends StatefulWidget {
  const HouseholdsAdminPage({super.key});

  @override
  State<HouseholdsAdminPage> createState() => _HouseholdsAdminPageState();
}

class _HouseholdsAdminPageState extends State<HouseholdsAdminPage> {
  List<AdminHouseholdsHouseholds> _households = [];
  bool _loading = true;
  String? _error;

  @override
  void initState() {
    super.initState();
    _load();
  }

  Future<void> _load() async {
    try {
      final result = await db.adminHouseholds().execute();
      setState(() => _households = result.data.households);
    } catch (e) {
      setState(() => _error = e.toString());
    } finally {
      setState(() => _loading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        Text('Households', style: Theme.of(context).textTheme.titleLarge),
        const Text(
          'Every household registered through the mobile app.',
          style: TextStyle(color: mutedText),
        ),
        const SizedBox(height: 16),
        if (_loading) const Center(child: CircularProgressIndicator()),
        if (_error != null)
          Text(_error!, style: const TextStyle(color: Colors.red)),
        if (!_loading && _households.isEmpty && _error == null)
          const Text('No households yet.'),
        if (!_loading)
          Card(
            child: Column(
              children: _households
                  .map(
                    (h) => ListTile(
                      title: Text(h.name),
                      subtitle: Text(
                        h.address?.isNotEmpty == true
                            ? h.address!
                            : 'No address on file',
                      ),
                      trailing: Text(
                        '${h.householdMembers_on_household.length} member(s)',
                      ),
                    ),
                  )
                  .toList(),
            ),
          ),
      ],
    );
  }
}
