import 'package:flutter/material.dart';

import '../../core/supabase_client.dart';

class HouseholdsAdminPage extends StatefulWidget {
  const HouseholdsAdminPage({super.key});

  @override
  State<HouseholdsAdminPage> createState() => _HouseholdsAdminPageState();
}

class _HouseholdsAdminPageState extends State<HouseholdsAdminPage> {
  List<Map<String, dynamic>> _households = [];
  bool _loading = true;
  String? _error;

  @override
  void initState() {
    super.initState();
    _load();
  }

  Future<void> _load() async {
    try {
      final rows = await supabase
          .from('households')
          .select('id, name, address, created_at, household_members(count)')
          .order('created_at', ascending: false);
      setState(() => _households = List<Map<String, dynamic>>.from(rows));
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
          style: TextStyle(color: Colors.grey),
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
                      title: Text(h['name'] as String),
                      subtitle: Text(
                        (h['address'] as String?)?.isNotEmpty == true
                            ? h['address']
                            : 'No address on file',
                      ),
                      trailing: Text(
                        '${(h['household_members'] as List?)?.firstOrNull?['count'] ?? 0} member(s)',
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
