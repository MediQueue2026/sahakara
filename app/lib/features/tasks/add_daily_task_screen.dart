import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import '../../core/app_data.dart';
import '../../core/app_language.dart';
import '../../core/strings.dart';
import '../../core/theme.dart';
import 'task_common.dart';

/// Each priority with the icon shown on its button.
const _priorities = {
  'high': Icons.keyboard_double_arrow_up,
  'medium': Icons.drag_handle,
  'low': Icons.keyboard_double_arrow_down,
};

/// One-tap choices for the estimated time, in minutes.
const _minutePresets = [15, 30, 45, 60, 90];

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
/// Daily tasks list), optionally with a photo showing what to do. Once it's
/// saved, pops the day it was added to.
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

  /// The optional photo explaining the task, as JPEG bytes, and its download
  /// URL once uploaded — kept so a failed save doesn't upload it again.
  Uint8List? _photo;
  String? _photoUrl;

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

  /// Take or choose a photo for the task, scaled down to keep uploads small.
  Future<void> _pickPhoto(AppLanguage lang) async {
    final source = await pickOption(
      context,
      title: Strings.of('addPhoto', lang),
      options: [ImageSource.camera.name, ImageSource.gallery.name],
      label: (s) => Strings.of(
        s == ImageSource.camera.name ? 'takePhoto' : 'chooseFromGallery',
        lang,
      ),
      icon: (s) => Icon(
        s == ImageSource.camera.name
            ? Icons.photo_camera_outlined
            : Icons.photo_library_outlined,
      ),
    );
    if (source == null) return;
    try {
      final file = await ImagePicker().pickImage(
        source: ImageSource.values.byName(source),
        maxWidth: 1600,
        maxHeight: 1600,
        imageQuality: 80,
      );
      if (file == null) return;
      final bytes = await file.readAsBytes();
      setState(() {
        _photo = bytes;
        _photoUrl = null;
      });
    } catch (e) {
      setState(() => _error = e.toString());
    }
  }

  Future<void> _save(AppLanguage lang) async {
    final custom = _taskChoice == _customTask;
    final title = _titleController.text.trim();
    final minutesText = _minutesController.text.trim();
    final minutes = int.tryParse(minutesText);
    if (_taskChoice == null || (custom && title.isEmpty)) {
      setState(() => _error = Strings.of('chooseTaskError', lang));
      return;
    }
    if (minutesText.isNotEmpty && (minutes == null || minutes <= 0)) {
      setState(() => _error = Strings.of('minutesError', lang));
      return;
    }
    setState(() {
      _busy = true;
      _error = null;
    });
    try {
      if (_photo != null) {
        _photoUrl ??= await AppData.uploadTaskPhoto(
          householdId: widget.householdId,
          bytes: _photo!,
        );
      }
      await AppData.addDailyTask(
        householdId: widget.householdId,
        assignedToId: _assigneeId == _unassigned ? null : _assigneeId,
        day: _day,
        libraryId: custom ? null : _taskChoice,
        customTitle: custom ? title : null,
        estMinutes: minutes,
        priority: _priority,
        photoUrl: _photo == null ? null : _photoUrl,
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
              : ListView(
                  padding: const EdgeInsets.fromLTRB(16, 16, 16, 24),
                  children: [
                    _Section(
                      icon: Icons.checklist,
                      title: Strings.of('whatTask', lang),
                      child: _taskSection(lang),
                    ),
                    const SizedBox(height: 16),
                    _Section(
                      icon: Icons.person_outline,
                      title: Strings.of('whoAndWhen', lang),
                      child: _whoAndWhenSection(lang),
                    ),
                    const SizedBox(height: 16),
                    _Section(
                      icon: Icons.tune,
                      title: Strings.of('detailsOptional', lang),
                      child: _detailsSection(lang),
                    ),
                  ],
                ),
          bottomNavigationBar: _loading ? null : _saveBar(lang),
        );
      },
    );
  }

  /// The Save button, kept in view at the bottom, with any error above it.
  Widget _saveBar(AppLanguage lang) {
    return SafeArea(
      child: Container(
        padding: const EdgeInsets.fromLTRB(16, 8, 16, 12),
        decoration: const BoxDecoration(
          color: Colors.white,
          border: Border(top: BorderSide(color: Colors.black12)),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            if (_error != null)
              Padding(
                padding: const EdgeInsets.only(bottom: 8),
                child: Text(
                  _error!,
                  style: TextStyle(color: Theme.of(context).colorScheme.error),
                ),
              ),
            FilledButton.icon(
              style: FilledButton.styleFrom(
                minimumSize: const Size.fromHeight(52),
                textStyle: Theme.of(context).textTheme.titleMedium,
              ),
              onPressed: _busy ? null : () => _save(lang),
              icon: _busy
                  ? const SizedBox.square(
                      dimension: 20,
                      child: CircularProgressIndicator(strokeWidth: 2),
                    )
                  : const Icon(Icons.check),
              label: Text(Strings.of('save', lang)),
            ),
          ],
        ),
      ),
    );
  }

  /// Section 1: the task — picked from the library, or typed in.
  Widget _taskSection(AppLanguage lang) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        if (_library.isEmpty) ...[
          Text(
            Strings.of('noLibraryTasks', lang),
            style: const TextStyle(color: mutedText),
          ),
          const SizedBox(height: 8),
          Wrap(children: [_customTaskChip(lang)]),
        ] else
          ..._taskPicker(lang),
        if (_taskChoice == _customTask) ...[
          const SizedBox(height: 12),
          TextField(
            controller: _titleController,
            autofocus: true,
            textCapitalization: TextCapitalization.sentences,
            decoration: InputDecoration(
              labelText: Strings.of('customTaskTitle', lang),
              prefixIcon: const Icon(Icons.edit_outlined),
            ),
          ),
        ],
      ],
    );
  }

  /// Section 2: who does it, and on which day.
  Widget _whoAndWhenSection(AppLanguage lang) {
    final textTheme = Theme.of(context).textTheme;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(Strings.of('assignTo', lang), style: textTheme.labelLarge),
        const SizedBox(height: 8),
        Wrap(
          spacing: 8,
          runSpacing: 4,
          children: [
            ChoiceChip(
              avatar: const Icon(Icons.person_off_outlined, size: 18),
              label: Text(Strings.of('unassigned', lang)),
              showCheckmark: false,
              selected: _assigneeId == _unassigned,
              onSelected: (_) => setState(() => _assigneeId = _unassigned),
            ),
            for (final m in _staff)
              ChoiceChip(
                avatar: CircleAvatar(
                  backgroundColor: brandAmber,
                  child: Text(
                    m.user.name.isEmpty ? '?' : m.user.name[0].toUpperCase(),
                    style: const TextStyle(fontSize: 12, color: Colors.black),
                  ),
                ),
                label: Text(m.user.name),
                showCheckmark: false,
                selected: _assigneeId == m.id,
                onSelected: (_) => setState(() => _assigneeId = m.id),
              ),
          ],
        ),
        if (_staff.isEmpty) ...[
          const SizedBox(height: 4),
          Text(
            Strings.of('assignLaterHint', lang),
            style: textTheme.bodySmall?.copyWith(color: mutedText),
          ),
        ],
        const SizedBox(height: 16),
        Text(Strings.of('date', lang), style: textTheme.labelLarge),
        const SizedBox(height: 8),
        _dayChoices(lang),
      ],
    );
  }

  /// Today / Tomorrow, or any other day from the calendar.
  Widget _dayChoices(AppLanguage lang) {
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    final tomorrow = today.add(const Duration(days: 1));
    final day = DateTime(_day.year, _day.month, _day.day);
    final isOther = day != today && day != tomorrow;
    return Wrap(
      spacing: 8,
      runSpacing: 4,
      children: [
        ChoiceChip(
          label: Text(Strings.of('today', lang)),
          selected: day == today,
          onSelected: (_) => setState(() => _day = today),
        ),
        ChoiceChip(
          label: Text(Strings.of('tomorrow', lang)),
          selected: day == tomorrow,
          onSelected: (_) => setState(() => _day = tomorrow),
        ),
        ChoiceChip(
          avatar: const Icon(Icons.calendar_today_outlined, size: 18),
          label: Text(
            isOther
                ? _day.toIso8601String().substring(0, 10)
                : Strings.of('pickDate', lang),
          ),
          showCheckmark: false,
          selected: isOther,
          onSelected: (_) => _pickDay(),
        ),
      ],
    );
  }

  /// Section 3: time needed, priority and a photo — all optional.
  Widget _detailsSection(AppLanguage lang) {
    final textTheme = Theme.of(context).textTheme;
    final minutes = int.tryParse(_minutesController.text.trim());
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(Strings.of('estMinutes', lang), style: textTheme.labelLarge),
        const SizedBox(height: 8),
        Wrap(
          spacing: 8,
          runSpacing: 4,
          children: [
            for (final m in _minutePresets)
              ChoiceChip(
                label: Text('$m ${Strings.of('minutes', lang)}'),
                selected: minutes == m,
                onSelected: (selected) => setState(
                  () => _minutesController.text = selected ? '$m' : '',
                ),
              ),
          ],
        ),
        const SizedBox(height: 8),
        TextField(
          controller: _minutesController,
          keyboardType: TextInputType.number,
          decoration: InputDecoration(
            isDense: true,
            prefixIcon: const Icon(Icons.timer_outlined),
            hintText: Strings.of('otherMinutes', lang),
            suffixText: Strings.of('minutes', lang),
          ),
          onChanged: (_) => setState(() {}),
        ),
        const SizedBox(height: 16),
        Text(Strings.of('priority', lang), style: textTheme.labelLarge),
        const SizedBox(height: 8),
        SegmentedButton<String>(
          segments: [
            for (final e in _priorities.entries)
              ButtonSegment(
                value: e.key,
                icon: Icon(e.value),
                label: Text(Strings.of('priority_${e.key}', lang)),
              ),
          ],
          selected: {_priority},
          showSelectedIcon: false,
          onSelectionChanged: (s) => setState(() => _priority = s.first),
        ),
        const SizedBox(height: 16),
        _photoField(lang),
      ],
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

  /// One tab per category that has tasks, wrapping onto more lines so every
  /// category stays visible without scrolling sideways.
  Widget _categoryTabs(AppLanguage lang) {
    final present = _categories.entries
        .where((e) => _library.any((t) => t.category.stringValue == e.key))
        .toList();
    return Wrap(
      spacing: 8,
      runSpacing: 4,
      children: [
        for (final e in present)
          ChoiceChip(
            avatar: Icon(e.value, size: 18),
            label: Text(Strings.of('category_${e.key}', lang)),
            showCheckmark: false,
            selected: _search.isEmpty && _category == e.key,
            onSelected: (_) => setState(() => _category = e.key),
          ),
      ],
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
          isDense: true,
        ),
        onChanged: (v) => setState(() => _search = v),
      ),
      const SizedBox(height: 12),
      _categoryTabs(lang),
      const Divider(height: 24),
      if (tasks.isEmpty)
        Padding(
          padding: const EdgeInsets.only(bottom: 8),
          child: Text(
            Strings.of('noTaskMatches', lang),
            style: const TextStyle(color: mutedText),
          ),
        ),
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
          _customTaskChip(lang),
        ],
      ),
    ];
  }

  /// "Other (type it in)": a task that isn't in the library.
  Widget _customTaskChip(AppLanguage lang) {
    return ChoiceChip(
      avatar: const Icon(Icons.add, size: 18),
      label: Text(Strings.of('customTask', lang)),
      showCheckmark: false,
      selected: _taskChoice == _customTask,
      onSelected: (_) => setState(() => _taskChoice = _customTask),
    );
  }

  /// The optional photo: a button to add one, or a preview with buttons to
  /// replace or remove it.
  Widget _photoField(AppLanguage lang) {
    final photo = _photo;
    if (photo == null) {
      return Material(
        color: brandCream.withValues(alpha: 0.4),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
          side: const BorderSide(color: Colors.black12),
        ),
        child: InkWell(
          borderRadius: BorderRadius.circular(12),
          onTap: _busy ? null : () => _pickPhoto(lang),
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 16),
            child: Column(
              children: [
                const Icon(Icons.add_a_photo_outlined, size: 32),
                const SizedBox(height: 8),
                Text(
                  Strings.of('addPhoto', lang),
                  style: Theme.of(context).textTheme.titleSmall,
                ),
                Text(
                  Strings.of('addPhotoHint', lang),
                  style: const TextStyle(color: mutedText),
                ),
              ],
            ),
          ),
        ),
      );
    }
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          Strings.of('addPhotoHint', lang),
          style: Theme.of(context).textTheme.titleSmall,
        ),
        const SizedBox(height: 8),
        Stack(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: Image.memory(
                photo,
                height: 200,
                width: double.infinity,
                fit: BoxFit.cover,
              ),
            ),
            Positioned(
              top: 4,
              right: 4,
              child: Row(
                children: [
                  IconButton.filledTonal(
                    icon: const Icon(Icons.refresh),
                    onPressed: _busy ? null : () => _pickPhoto(lang),
                  ),
                  IconButton.filledTonal(
                    icon: const Icon(Icons.close),
                    onPressed: _busy
                        ? null
                        : () => setState(() {
                              _photo = null;
                              _photoUrl = null;
                            }),
                  ),
                ],
              ),
            ),
          ],
        ),
      ],
    );
  }
}

/// A titled, outlined block of the form.
class _Section extends StatelessWidget {
  final IconData icon;
  final String title;
  final Widget child;

  const _Section(
      {required this.icon, required this.title, required this.child});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.black12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            children: [
              CircleAvatar(
                radius: 16,
                backgroundColor: brandCream,
                child: Icon(icon, size: 18, color: Colors.black87),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Text(
                  title,
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.w600,
                      ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          child,
        ],
      ),
    );
  }
}
