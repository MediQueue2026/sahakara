import 'package:flutter/material.dart';
import 'package:translator/translator.dart';

import '../../core/firebase_client.dart';
import '../../dataconnect_generated/sahakara.dart';
import '../../core/theme.dart';

class TaskLibraryAdminPage extends StatefulWidget {
  const TaskLibraryAdminPage({super.key});

  @override
  State<TaskLibraryAdminPage> createState() => _TaskLibraryAdminPageState();
}

class _TaskLibraryAdminPageState extends State<TaskLibraryAdminPage> {
  List<LibraryTasksLibraryTasks> _tasks = [];
  bool _loading = true;
  String? _error;

  TaskCategory _category = TaskCategory.values.first;
  final _nameEn = TextEditingController();
  bool _saving = false;

  @override
  void dispose() {
    _nameEn.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    _load();
  }

  Future<void> _load() async {
    setState(() => _loading = true);
    try {
      final result = await db.libraryTasks().execute();
      setState(() {
        _tasks = result.data.libraryTasks;
        _error = null;
      });
    } catch (e) {
      setState(() => _error = e.toString());
    } finally {
      setState(() => _loading = false);
    }
  }

  /// Translates the English name into Sinhala and Tamil, lets the admin
  /// review and edit all three, then saves the task.
  Future<void> _add() async {
    final nameEn = _nameEn.text.trim();
    if (nameEn.isEmpty) return;
    setState(() => _saving = true);
    try {
      String nameSi = '';
      String nameTa = '';
      final translator = GoogleTranslator();
      try {
        nameSi =
            (await translator.translate(nameEn, from: 'en', to: 'si')).text;
        nameTa =
            (await translator.translate(nameEn, from: 'en', to: 'ta')).text;
      } catch (e) {
        // Leave the translations blank for the admin to fill in
      }
      if (!mounted) return;
      final names = await showDialog<_TaskNames>(
        context: context,
        builder: (_) => _ConfirmTaskDialog(
          category: _category,
          nameEn: nameEn,
          nameSi: nameSi,
          nameTa: nameTa,
        ),
      );
      if (names == null) return;
      await db
          .addLibraryTask(category: _category, nameEn: names.en)
          .nameSi(names.si.isEmpty ? null : names.si)
          .nameTa(names.ta.isEmpty ? null : names.ta)
          .execute();
      _nameEn.clear();
      await _load();
    } catch (e) {
      setState(() => _error = e.toString());
    } finally {
      if (mounted) setState(() => _saving = false);
    }
  }

  Future<void> _remove(String id) async {
    try {
      await db.deleteLibraryTask(id: id).execute();
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
          style: TextStyle(color: mutedText),
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
                DropdownButton<TaskCategory>(
                  value: _category,
                  items: TaskCategory.values
                      .map(
                        (c) => DropdownMenuItem(value: c, child: Text(c.name)),
                      )
                      .toList(),
                  onChanged: (v) => setState(() => _category = v!),
                ),
                SizedBox(
                  width: 220,
                  child: TextField(
                    controller: _nameEn,
                    onSubmitted: (_) => _saving ? null : _add(),
                    decoration: const InputDecoration(
                      labelText: 'Name (English)',
                    ),
                  ),
                ),
                FilledButton.icon(
                  onPressed: _saving ? null : _add,
                  icon: _saving
                      ? const SizedBox(
                          width: 18,
                          height: 18,
                          child: CircularProgressIndicator(strokeWidth: 2),
                        )
                      : const Icon(Icons.add),
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
                      title: Text(t.nameEn),
                      subtitle: Text(
                        '${t.category.stringValue} · ${t.nameSi ?? '—'} · ${t.nameTa ?? '—'}',
                      ),
                      trailing: IconButton(
                        icon: const Icon(Icons.delete_outline),
                        onPressed: () => _remove(t.id),
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

/// The task name in each app language, as confirmed by the admin.
class _TaskNames {
  final String en;
  final String si;
  final String ta;

  const _TaskNames({required this.en, required this.si, required this.ta});
}

/// Shows the English name with its automatic Sinhala and Tamil translations,
/// all editable, before the task is added.
class _ConfirmTaskDialog extends StatefulWidget {
  final TaskCategory category;
  final String nameEn;
  final String nameSi;
  final String nameTa;

  const _ConfirmTaskDialog({
    required this.category,
    required this.nameEn,
    required this.nameSi,
    required this.nameTa,
  });

  @override
  State<_ConfirmTaskDialog> createState() => _ConfirmTaskDialogState();
}

class _ConfirmTaskDialogState extends State<_ConfirmTaskDialog> {
  late final _en = TextEditingController(text: widget.nameEn);
  late final _si = TextEditingController(text: widget.nameSi);
  late final _ta = TextEditingController(text: widget.nameTa);

  @override
  void dispose() {
    _en.dispose();
    _si.dispose();
    _ta.dispose();
    super.dispose();
  }

  void _confirm() {
    final en = _en.text.trim();
    if (en.isEmpty) return;
    Navigator.of(context).pop(
      _TaskNames(en: en, si: _si.text.trim(), ta: _ta.text.trim()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Confirm task'),
      content: SizedBox(
        width: 360,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              'Category: ${widget.category.name}. Check the translations '
              'and edit them if needed.',
              style: const TextStyle(color: mutedText),
            ),
            const SizedBox(height: 12),
            TextField(
              controller: _en,
              decoration: const InputDecoration(labelText: 'Name (English)'),
            ),
            const SizedBox(height: 8),
            TextField(
              controller: _si,
              decoration: const InputDecoration(labelText: 'Name (Sinhala)'),
            ),
            const SizedBox(height: 8),
            TextField(
              controller: _ta,
              decoration: const InputDecoration(labelText: 'Name (Tamil)'),
            ),
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: const Text('Cancel'),
        ),
        FilledButton(onPressed: _confirm, child: const Text('Add task')),
      ],
    );
  }
}
