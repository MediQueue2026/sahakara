import 'package:flutter/material.dart';

import '../../core/supabase_client.dart';

const _categories = ['kitchen', 'cleaning', 'laundry', 'cooking', 'other'];

class TaskLibraryAdminPage extends StatefulWidget {
  const TaskLibraryAdminPage({super.key});

  @override
  State<TaskLibraryAdminPage> createState() => _TaskLibraryAdminPageState();
}

class _TaskLibraryAdminPageState extends State<TaskLibraryAdminPage> {
  List<Map<String, dynamic>> _tasks = [];
  bool _loading = true;
  String? _error;

  String _category = _categories.first;
  final _nameEn = TextEditingController();
  final _nameSi = TextEditingController();
  final _nameTa = TextEditingController();
  bool _saving = false;

  @override
  void initState() {
    super.initState();
    _load();
  }

  Future<void> _load() async {
    setState(() => _loading = true);
    try {
      final rows = await supabase
          .from('task_library')
          .select()
          .order('category')
          .order('name_en');
      setState(() {
        _tasks = List<Map<String, dynamic>>.from(rows);
        _error = null;
      });
    } catch (e) {
      setState(() => _error = e.toString());
    } finally {
      setState(() => _loading = false);
    }
  }

  Future<void> _add() async {
    if (_nameEn.text.trim().isEmpty) return;
    setState(() => _saving = true);
    try {
      await supabase.from('task_library').insert({
        'category': _category,
        'name_en': _nameEn.text.trim(),
        'name_si': _nameSi.text.trim(),
        'name_ta': _nameTa.text.trim(),
      });
      _nameEn.clear();
      _nameSi.clear();
      _nameTa.clear();
      await _load();
    } catch (e) {
      setState(() => _error = e.toString());
    } finally {
      setState(() => _saving = false);
    }
  }

  Future<void> _remove(String id) async {
    try {
      await supabase.from('task_library').delete().eq('id', id);
      await _load();
    } catch (e) {
      setState(() => _error = e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        Text('Task library', style: Theme.of(context).textTheme.titleLarge),
        const Text(
          'The shared, trilingual task list every household picks tasks from.',
          style: TextStyle(color: Colors.grey),
        ),
        const SizedBox(height: 16),
        Card(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Wrap(
              spacing: 12,
              runSpacing: 12,
              crossAxisAlignment: WrapCrossAlignment.end,
              children: [
                DropdownButton<String>(
                  value: _category,
                  items: _categories
                      .map((c) => DropdownMenuItem(value: c, child: Text(c)))
                      .toList(),
                  onChanged: (v) => setState(() => _category = v!),
                ),
                SizedBox(
                  width: 220,
                  child: TextField(
                    controller: _nameEn,
                    decoration: const InputDecoration(
                      labelText: 'Name (English)',
                    ),
                  ),
                ),
                SizedBox(
                  width: 220,
                  child: TextField(
                    controller: _nameSi,
                    decoration: const InputDecoration(
                      labelText: 'Name (Sinhala)',
                    ),
                  ),
                ),
                SizedBox(
                  width: 220,
                  child: TextField(
                    controller: _nameTa,
                    decoration: const InputDecoration(
                      labelText: 'Name (Tamil)',
                    ),
                  ),
                ),
                FilledButton.icon(
                  onPressed: _saving ? null : _add,
                  icon: const Icon(Icons.add),
                  label: const Text('Add task'),
                ),
              ],
            ),
          ),
        ),
        if (_error != null)
          Padding(
            padding: const EdgeInsets.only(top: 8),
            child: Text(_error!, style: const TextStyle(color: Colors.red)),
          ),
        const SizedBox(height: 16),
        if (_loading) const Center(child: CircularProgressIndicator()),
        if (!_loading)
          Card(
            child: Column(
              children: _tasks
                  .map(
                    (t) => ListTile(
                      title: Text(t['name_en'] as String),
                      subtitle: Text(
                        '${t['category']} · ${t['name_si'] ?? '—'} · ${t['name_ta'] ?? '—'}',
                      ),
                      trailing: IconButton(
                        icon: const Icon(Icons.delete_outline),
                        onPressed: () => _remove(t['id'] as String),
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
