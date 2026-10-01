import 'package:flutter/material.dart';

import '../../core/app_data.dart';
import '../../core/app_language.dart';
import '../../core/strings.dart';
import '../../core/theme.dart';

const _priorities = ['high', 'medium', 'low'];

/// The order library tasks are grouped in on this screen, with each
/// category's tab icon.
const _categories = {
  'cleaning': Icons.cleaning_services_outlined,
  'kitchen': Icons.kitchen_outlined,
  'cooking': Icons.soup_kitchen_outlined,
  'laundry': Icons.local_laundry_service_outlined,
  'other': Icons.yard_outlined,
};

/// The task dropdown's value for "type a custom title instead".
const _customTask = '';

/// The assignee dropdown's value for "nobody yet".
const _unassigned = '';

/// Owner: add a task — tapped from the shared library's default tasks, or a
/// custom one typed in — for one
/// day, assigned to a staff member or to nobody yet (assigned later from the
/// Daily tasks list). Once it's saved, pops the day it was added to.
class AddDailyTaskScreen extends StatefulWidget {
  final LanguageController lang;
  final String householdId;
  final DateTime day;

  const AddDailyTaskScreen({
    super.key,
    required this.lang,
    required this.householdId,
    required this.day,
  });

  @override
  State<AddDailyTaskScreen> createState() => _AddDailyTaskScreenState();
}

class _AddDailyTaskScreenState extends State<AddDailyTaskScreen> {
  List<Member> _staff = [];
  List<LibraryTask> _library = [];
  bool _loading = true;
  bool _busy = false;
  String? _error;

  String _assigneeId = _unassigned;
  String? _taskChoice;
  late DateTime _day;
  String _priority = 'medium';
  String _category = _categories.keys.first;
  String _search = '';
  final _titleController = TextEditingController();
  final _minutesController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _day = widget.day;
    _load();
  }

  Future<void> _load() async {
    final members = await AppData.fetchHouseholdMembers(widget.householdId);
    final library = await AppData.fetchTaskLibrary();
    setState(() {
      _staff = members
          .where((m) => m.active && m.role.stringValue != 'owner')
          .toList();
      _library = library;
      // Open on the first category that has tasks.
      _category = _categories.keys.firstWhere(
        (c) => library.any((t) => t.category.stringValue == c),
        orElse: () => _category,
      );
      if (_staff.length == 1) _assigneeId = _staff.first.id;
      _loading = false;
    });
  }

  Future<void> _pickDay() async {
    final picked = await showDatePicker(
      context: context,
      initialDate: _day,
      firstDate: DateTime(_day.year - 1),
      lastDate: DateTime(_day.year + 1, 12, 31),
    );
    if (picked != null) setState(() => _day = picked);
  }

  Future<void> _save() async {
    final custom = _taskChoice == _customTask;
    final title = _titleController.text.trim();
    final minutesText = _minutesController.text.trim();
    final minutes = int.tryParse(minutesText);
    if (_taskChoice == null || (custom && title.isEmpty)) {
      setState(() => _error = 'Choose a task or type one in');
      return;
    }
    if (minutesText.isNotEmpty && (minutes == null || minutes <= 0)) {
      setState(() => _error = 'Enter the minutes as a whole number');
      return;
    }
    setState(() {
      _busy = true;
      _error = null;
    });
    try {
      await AppData.addDailyTask(
        householdId: widget.householdId,
        assignedToId: _assigneeId == _unassigned ? null : _assigneeId,
        day: _day,
        libraryId: custom ? null : _taskChoice,
        customTitle: custom ? title : null,
        estMinutes: minutes,
        priority: _priority,
      );
      if (mounted) Navigator.of(context).pop(_day);
    } catch (e) {
      setState(() => _error = e.toString());
    } finally {
      if (mounted) setState(() => _busy = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<AppLanguage>(
      valueListenable: widget.lang,
      builder: (context, lang, _) {
        return Scaffold(
          appBar: AppBar(title: Text(Strings.of('addTask', lang))),
          body: _loading
              ? const Center(child: CircularProgressIndicator())
              : SingleChildScrollView(
                  padding: const EdgeInsets.all(16),
                  child: _buildForm(lang),
                ),
        );
      },
    );
  }

  /// The library tasks to show: those matching the search in any language,
  /// from every category, or else just the selected category's.
  List<LibraryTask> _visibleTasks() {
    final q = _search.trim().toLowerCase();
    if (q.isEmpty) {
      return _library
          .where((t) => t.category.stringValue == _category)
          .toList();
    }
    return _library
        .where(
          (t) => [
            t.nameEn,
            t.nameSi,
            t.nameTa,
          ].any((n) => n != null && n.toLowerCase().contains(q)),
        )
        .toList();
  }

  /// The chosen library task, shown above the picker so it stays in view
  /// after switching category or searching.
  Widget _selectedTaskCard(LibraryTask t, AppLanguage lang) {
    final category = t.category.stringValue;
    return Card(
      color: brandCream,
      margin: EdgeInsets.zero,
      child: ListTile(
        leading: Icon(_categories[category] ?? Icons.task_alt),
        title: Text(pickName(lang, en: t.nameEn, si: t.nameSi, ta: t.nameTa)),
        subtitle: Text(Strings.of('category_$category', lang)),
        trailing: IconButton(
          icon: const Icon(Icons.close),
          onPressed: () => setState(() => _taskChoice = null),
        ),
      ),
    );
  }

  /// One tab per category that has tasks, scrolling sideways.
  Widget _categoryTabs(AppLanguage lang) {
    final present = _categories.entries
        .where((e) => _library.any((t) => t.category.stringValue == e.key))
        .toList();
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: [
          for (final e in present)
            Padding(
              padding: const EdgeInsets.only(right: 8),
              child: ChoiceChip(
                avatar: Icon(e.value, size: 18),
                label: Text(Strings.of('category_${e.key}', lang)),
                showCheckmark: false,
                selected: _search.isEmpty && _category == e.key,
                onSelected: (_) => setState(() => _category = e.key),
              ),
            ),
        ],
      ),
    );
  }

  /// The task picker: search, category tabs, then the matching tasks.
  List<Widget> _taskPicker(AppLanguage lang) {
    LibraryTask? selected;
    for (final t in _library) {
      if (t.id == _taskChoice) selected = t;
    }
    final tasks = _visibleTasks();
    return [
      if (selected != null) ...[
        _selectedTaskCard(selected, lang),
        const SizedBox(height: 12),
      ],
      TextField(
        decoration: InputDecoration(
          prefixIcon: const Icon(Icons.search),
          hintText: Strings.of('searchTasks', lang),
          border: const OutlineInputBorder(),
          isDense: true,
        ),
        onChanged: (v) => setState(() => _search = v),
      ),
      const SizedBox(height: 8),
      _categoryTabs(lang),
      const SizedBox(height: 8),
      if (tasks.isEmpty)
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 8),
          child: Text(
            Strings.of('noTaskMatches', lang),
            style: const TextStyle(color: mutedText),
          ),
        )
      else
        Wrap(
          spacing: 8,
          runSpacing: 4,
          children: [
            for (final t in tasks)
              ChoiceChip(
                label: Text(
                  pickName(lang, en: t.nameEn, si: t.nameSi, ta: t.nameTa),
                ),
                selected: _taskChoice == t.id,
                onSelected: (_) => setState(() => _taskChoice = t.id),
              ),
          ],
        ),
    ];
  }

  Widget _buildForm(AppLanguage lang) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        DropdownButtonFormField<String>(
          initialValue: _assigneeId,
          decoration: InputDecoration(labelText: Strings.of('assignTo', lang)),
          items: [
            DropdownMenuItem(
              value: _unassigned,
              child: Text(Strings.of('unassigned', lang)),
            ),
            ..._staff.map(
              (m) => DropdownMenuItem(value: m.id, child: Text(m.user.name)),
            ),
          ],
          onChanged: (v) => setState(() => _assigneeId = v!),
        ),
        if (_staff.isEmpty) ...[
          const SizedBox(height: 8),
          Text(
            Strings.of('assignLaterHint', lang),
            style: Theme.of(context).textTheme.bodySmall,
          ),
        ],
        const SizedBox(height: 12),
        Text(
          Strings.of('task', lang),
          style: Theme.of(context).textTheme.titleSmall,
        ),
        const SizedBox(height: 8),
        if (_library.isEmpty)
          Text(
            Strings.of('noLibraryTasks', lang),
            style: Theme.of(context).textTheme.bodySmall,
          )
        else
          ..._taskPicker(lang),
        const SizedBox(height: 8),
        Wrap(
          children: [
            ChoiceChip(
              avatar: const Icon(Icons.edit_outlined, size: 18),
              label: Text(Strings.of('customTask', lang)),
              selected: _taskChoice == _customTask,
              onSelected: (_) => setState(() => _taskChoice = _customTask),
            ),
          ],
        ),
        if (_taskChoice == _customTask) ...[
          const SizedBox(height: 12),
          TextField(
            controller: _titleController,
            decoration: InputDecoration(
              labelText: Strings.of('customTaskTitle', lang),
            ),
          ),
        ],
        const SizedBox(height: 12),
        TextField(
          controller: _minutesController,
          keyboardType: TextInputType.number,
          decoration: InputDecoration(
            labelText: Strings.of('estMinutes', lang),
          ),
        ),
        const SizedBox(height: 16),
        Text(Strings.of('priority', lang)),
        const SizedBox(height: 8),
        SegmentedButton<String>(
          segments: _priorities
              .map(
                (p) => ButtonSegment(
                  value: p,
                  label: Text(Strings.of('priority_$p', lang)),
                ),
              )
              .toList(),
          selected: {_priority},
          onSelectionChanged: (s) => setState(() => _priority = s.first),
        ),
        const SizedBox(height: 16),
        OutlinedButton.icon(
          onPressed: _pickDay,
          icon: const Icon(Icons.calendar_today_outlined),
          label: Text(
            '${Strings.of('date', lang)}: '
            '${_day.toIso8601String().substring(0, 10)}',
          ),
        ),
        const SizedBox(height: 20),
        FilledButton(
          onPressed: _busy ? null : _save,
          child: Text(Strings.of('save', lang)),
        ),
        if (_error != null) ...[
          const SizedBox(height: 8),
          Text(_error!, style: const TextStyle(color: Colors.red)),
        ],
      ],
    );
  }
}
