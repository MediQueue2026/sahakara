import 'package:flutter/material.dart';

import '../../core/app_data.dart';
import '../../core/app_language.dart';
import '../../core/strings.dart';
import 'add_daily_task_screen.dart';

/// Statuses a staff member can set on their own task (see
/// UpdateMyTaskStatus in dataconnect/connector/mutations.gql).
const _staffStatuses = ['started', 'done', 'need_help', 'cant_do'];

const _cantDoReasons = [
  'no_supplies',
  'power_cut',
  'water_cut',
  'sick',
  'no_time',
  'other',
];

const _statusIcons = {
  'pending': Icons.radio_button_unchecked,
  'started': Icons.play_circle_outline,
  'done': Icons.check_circle,
  'need_help': Icons.help_outline,
  'cant_do': Icons.block,
  'carried_forward': Icons.redo,
};

Color? _statusColor(String status) => switch (status) {
  'started' => Colors.blue,
  'done' => Colors.green,
  'need_help' => Colors.orange,
  'cant_do' => Colors.red,
  _ => null,
};

/// One day's tasks. Owner: every task in the household, grouped by the staff
/// member it's assigned to (unassigned ones first), with a button to add
/// more and each task's status; tapping a task assigns or reassigns it.
/// Staff: their own tasks for the day, tapped to report progress.
class DailyTasksScreen extends StatefulWidget {
  final LanguageController lang;
  final Profile profile;
  final Membership membership;

  const DailyTasksScreen({
    super.key,
    required this.lang,
    required this.profile,
    required this.membership,
  });

  @override
  State<DailyTasksScreen> createState() => _DailyTasksScreenState();
}

/// The fields the screen shows, from either the owner's or the staff
/// member's query result.
class _TaskRow {
  final String id;
  final String status;
  final String? cantDoReason;
  final String priority;
  final int? estMinutes;
  final String? customTitle;
  final String? nameEn;
  final String? nameSi;
  final String? nameTa;
  final String? assigneeId;
  final String? assigneeName;

  const _TaskRow({
    required this.id,
    required this.status,
    this.cantDoReason,
    required this.priority,
    this.estMinutes,
    this.customTitle,
    this.nameEn,
    this.nameSi,
    this.nameTa,
    this.assigneeId,
    this.assigneeName,
  });

  String title(AppLanguage lang) {
    if (nameEn == null) return customTitle ?? '';
    return pickName(lang, en: nameEn!, si: nameSi, ta: nameTa);
  }
}

class _DailyTasksScreenState extends State<DailyTasksScreen> {
  late DateTime _day;
  late Future<List<_TaskRow>> _tasks;

  bool get _isOwner => widget.membership.role.stringValue == 'owner';

  @override
  void initState() {
    super.initState();
    final now = DateTime.now();
    _day = DateTime(now.year, now.month, now.day);
    _load();
  }

  void _load() {
    _tasks = _isOwner ? _fetchHouseholdTasks() : _fetchMyTasks();
  }

  Future<List<_TaskRow>> _fetchHouseholdTasks() async {
    final tasks = await AppData.fetchHouseholdTasks(
      householdId: widget.membership.household.id,
      day: _day,
    );
    return tasks
        .map(
          (t) => _TaskRow(
            id: t.id,
            status: t.status.stringValue,
            cantDoReason: t.cantDoReason?.stringValue,
            priority: t.template.priority.stringValue,
            estMinutes: t.template.estMinutes,
            customTitle: t.template.customTitle,
            nameEn: t.template.library?.nameEn,
            nameSi: t.template.library?.nameSi,
            nameTa: t.template.library?.nameTa,
            assigneeId: t.assignedTo?.id,
            assigneeName: t.assignedTo?.user.name,
          ),
        )
        .toList();
  }

  Future<List<_TaskRow>> _fetchMyTasks() async {
    final tasks = await AppData.fetchMyTasks(_day);
    return tasks
        .map(
          (t) => _TaskRow(
            id: t.id,
            status: t.status.stringValue,
            cantDoReason: t.cantDoReason?.stringValue,
            priority: t.template.priority.stringValue,
            estMinutes: t.template.estMinutes,
            customTitle: t.template.customTitle,
            nameEn: t.template.library?.nameEn,
            nameSi: t.template.library?.nameSi,
            nameTa: t.template.library?.nameTa,
          ),
        )
        .toList();
  }

  void _changeDay(DateTime day) {
    setState(() {
      _day = day;
      _load();
    });
  }

  Future<void> _pickDay() async {
    final picked = await showDatePicker(
      context: context,
      initialDate: _day,
      firstDate: DateTime(_day.year - 1),
      lastDate: DateTime(_day.year + 1, 12, 31),
    );
    if (picked != null) _changeDay(picked);
  }

  Future<void> _addTask() async {
    final addedDay = await Navigator.of(context).push<DateTime>(
      MaterialPageRoute(
        builder: (_) => AddDailyTaskScreen(
          lang: widget.lang,
          householdId: widget.membership.household.id,
          day: _day,
        ),
      ),
    );
    // Show the day the task was added to, which the owner may have changed
    // on the form.
    if (addedDay != null) _changeDay(addedDay);
  }

  Future<void> _remove(String taskId) async {
    try {
      await AppData.deleteDailyTask(taskId);
      setState(_load);
    } catch (e) {
      _showError(e);
    }
  }

  /// Owner: pick which staff member [t] is assigned to.
  Future<void> _assign(_TaskRow t, AppLanguage lang) async {
    try {
      final staff = (await AppData.fetchHouseholdMembers(
        widget.membership.household.id,
      )).where((m) => m.active && m.role.stringValue != 'owner').toList();
      if (staff.isEmpty) {
        _showError(Strings.of('noStaffYet', lang));
        return;
      }
      final names = {for (final m in staff) m.id: m.user.name};
      final memberId = await _pick(
        title: '${Strings.of('assignTo', lang)}: ${t.title(lang)}',
        options: names.keys.toList(),
        label: (id) => names[id]!,
        icon: (_) => const Icon(Icons.person_outline),
        selected: t.assigneeId,
      );
      if (memberId == null || memberId == t.assigneeId) return;
      await AppData.assignDailyTask(taskId: t.id, assignedToId: memberId);
      setState(_load);
    } catch (e) {
      _showError(e);
    }
  }

  /// Staff: pick a new status for [t] — and for "can't do", the reason.
  Future<void> _changeStatus(_TaskRow t, AppLanguage lang) async {
    final status = await _pick(
      title: t.title(lang),
      options: _staffStatuses,
      label: (s) => Strings.of('status_$s', lang),
      icon: (s) => Icon(_statusIcons[s], color: _statusColor(s)),
      selected: t.status,
    );
    if (status == null) return;
    String? reason;
    if (status == 'cant_do') {
      reason = await _pick(
        title: Strings.of('whyCantDo', lang),
        options: _cantDoReasons,
        label: (r) => Strings.of('reason_$r', lang),
        selected: t.cantDoReason,
      );
      if (reason == null) return;
    }
    try {
      await AppData.updateMyTaskStatus(
        taskId: t.id,
        status: status,
        cantDoReason: reason,
      );
      setState(_load);
    } catch (e) {
      _showError(e);
    }
  }

  /// A bottom sheet listing [options]; returns the tapped one, or null if
  /// dismissed.
  Future<String?> _pick({
    required String title,
    required List<String> options,
    required String Function(String) label,
    Widget Function(String)? icon,
    String? selected,
  }) {
    return showModalBottomSheet<String>(
      context: context,
      builder: (context) => SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              title: Text(
                title,
                style: Theme.of(context).textTheme.titleMedium,
              ),
            ),
            for (final o in options)
              ListTile(
                leading: icon?.call(o),
                title: Text(label(o)),
                selected: o == selected,
                onTap: () => Navigator.of(context).pop(o),
              ),
          ],
        ),
      ),
    );
  }

  void _showError(Object e) {
    if (!mounted) return;
    ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text(e.toString())));
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<AppLanguage>(
      valueListenable: widget.lang,
      builder: (context, lang, _) {
        return Scaffold(
          floatingActionButton: _isOwner
              ? FloatingActionButton.extended(
                  onPressed: _addTask,
                  icon: const Icon(Icons.add),
                  label: Text(Strings.of('addTask', lang)),
                )
              : null,
          body: Column(
            children: [
              _buildDaySwitcher(),
              Expanded(
                child: FutureBuilder<List<_TaskRow>>(
                  future: _tasks,
                  builder: (context, snapshot) {
                    if (snapshot.hasError) {
                      return Center(child: Text('${snapshot.error}'));
                    }
                    if (!snapshot.hasData) {
                      return const Center(child: CircularProgressIndicator());
                    }
                    final tasks = snapshot.data!;
                    if (tasks.isEmpty) {
                      return Center(
                        child: Text(Strings.of('noTasksForDay', lang)),
                      );
                    }
                    return _isOwner
                        ? _buildGrouped(tasks, lang)
                        : _buildList(tasks, lang);
                  },
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildDaySwitcher() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          IconButton(
            icon: const Icon(Icons.chevron_left),
            onPressed: () => _changeDay(_day.subtract(const Duration(days: 1))),
          ),
          TextButton.icon(
            onPressed: _pickDay,
            icon: const Icon(Icons.calendar_today_outlined),
            label: Text(_day.toIso8601String().substring(0, 10)),
          ),
          IconButton(
            icon: const Icon(Icons.chevron_right),
            onPressed: () => _changeDay(_day.add(const Duration(days: 1))),
          ),
        ],
      ),
    );
  }

  /// Owner view: one card per staff member, headed by their name and the
  /// day's total estimated time, after a card of tasks not assigned yet.
  Widget _buildGrouped(List<_TaskRow> tasks, AppLanguage lang) {
    // '' holds the unassigned tasks, and goes first so they're noticed.
    final byAssignee = <String, List<_TaskRow>>{
      if (tasks.any((t) => t.assigneeId == null)) '': [],
    };
    for (final t in tasks) {
      byAssignee.putIfAbsent(t.assigneeId ?? '', () => []).add(t);
    }
    return ListView(
      // Leaves room so the last task isn't hidden behind the add button.
      padding: const EdgeInsets.fromLTRB(8, 0, 8, 88),
      children: byAssignee.values.map((group) {
        final minutes = group.fold<int>(
          0,
          (sum, t) => sum + (t.estMinutes ?? 0),
        );
        return Card(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              ListTile(
                title: Text(
                  group.first.assigneeName ?? Strings.of('unassigned', lang),
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                trailing: minutes > 0
                    ? Text('$minutes ${Strings.of('minutes', lang)}')
                    : null,
              ),
              ...group.map((t) => _taskTile(t, lang)),
            ],
          ),
        );
      }).toList(),
    );
  }

  Widget _buildList(List<_TaskRow> tasks, AppLanguage lang) {
    return ListView(
      padding: const EdgeInsets.all(8),
      children: tasks.map((t) => Card(child: _taskTile(t, lang))).toList(),
    );
  }

  Widget _taskTile(_TaskRow t, AppLanguage lang) {
    final status = [
      Strings.of('status_${t.status}', lang),
      if (t.cantDoReason != null) Strings.of('reason_${t.cantDoReason}', lang),
    ].join(': ');
    final details = [
      if (t.estMinutes != null)
        '${t.estMinutes} ${Strings.of('minutes', lang)}',
      Strings.of('priority_${t.priority}', lang),
    ];
    return ListTile(
      leading: Icon(
        _statusIcons[t.status] ?? Icons.radio_button_unchecked,
        color: _statusColor(t.status),
      ),
      title: Text(t.title(lang)),
      subtitle: Text.rich(
        TextSpan(
          children: [
            TextSpan(
              text: status,
              style: TextStyle(color: _statusColor(t.status)),
            ),
            TextSpan(text: ' · ${details.join(' · ')}'),
          ],
        ),
      ),
      onTap: _isOwner ? () => _assign(t, lang) : () => _changeStatus(t, lang),
      trailing: _isOwner
          ? IconButton(
              icon: const Icon(Icons.delete_outline),
              onPressed: () => _remove(t.id),
            )
          : const Icon(Icons.chevron_right),
    );
  }
}
