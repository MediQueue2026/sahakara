import 'package:flutter/material.dart';

import '../../core/app_data.dart';
import '../../core/app_language.dart';
import '../../core/strings.dart';
import '../../core/theme.dart';
import 'task_common.dart';

/// Staff: a greeting, how much of the day's work is done, and their own
/// tasks for the day — tapped to report progress.
class MyTasksScreen extends StatefulWidget {
  final LanguageController lang;
  final Profile profile;
  final Membership membership;

  const MyTasksScreen({
    super.key,
    required this.lang,
    required this.profile,
    required this.membership,
  });

  @override
  State<MyTasksScreen> createState() => _MyTasksScreenState();
}

class _MyTasksScreenState extends State<MyTasksScreen> {
  late DateTime _day;
  late Future<List<TaskRow>> _tasks;

  @override
  void initState() {
    super.initState();
    final now = DateTime.now();
    _day = DateTime(now.year, now.month, now.day);
    _load();
  }

  void _load() {
    _tasks = _fetchTasks();
  }

  Future<List<TaskRow>> _fetchTasks() async {
    final tasks = await AppData.fetchMyTasks(_day);
    return tasks
        .map(
          (t) => TaskRow(
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

  /// Pick a new status for [t] — and for "can't do", the reason.
  Future<void> _changeStatus(TaskRow t, AppLanguage lang) async {
    final status = await pickOption(
      context,
      title: t.title(lang),
      options: staffStatuses,
      label: (s) => Strings.of('status_$s', lang),
      icon: (s) => Icon(statusIcons[s], color: statusColor(s)),
      selected: t.status,
    );
    if (status == null || !mounted) return;
    String? reason;
    if (status == 'cant_do') {
      reason = await pickOption(
        context,
        title: Strings.of('whyCantDo', lang),
        options: cantDoReasons,
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
      if (!mounted) return;
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(e.toString())));
    }
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<AppLanguage>(
      valueListenable: widget.lang,
      builder: (context, lang, _) {
        return FutureBuilder<List<TaskRow>>(
          future: _tasks,
          builder: (context, snapshot) {
            final tasks = snapshot.data;
            return ListView(
              padding: const EdgeInsets.fromLTRB(16, 16, 16, 24),
              children: [
                _header(tasks, lang),
                const SizedBox(height: 8),
                DaySwitcher(day: _day, onChanged: _changeDay),
                const SizedBox(height: 8),
                if (snapshot.hasError)
                  Center(child: Text('${snapshot.error}'))
                else if (tasks == null)
                  const Padding(
                    padding: EdgeInsets.all(32),
                    child: Center(child: CircularProgressIndicator()),
                  )
                else if (tasks.isEmpty)
                  Padding(
                    padding: const EdgeInsets.all(32),
                    child: Center(
                      child: Text(
                        Strings.of('noTasksForDay', lang),
                        style: const TextStyle(color: mutedText),
                      ),
                    ),
                  )
                else
                  for (final t in tasks) _taskCard(t, lang),
              ],
            );
          },
        );
      },
    );
  }

  /// "Hello, name", the household, and a bar of the day's progress.
  Widget _header(List<TaskRow>? tasks, AppLanguage lang) {
    final textTheme = Theme.of(context).textTheme;
    final total = tasks?.length ?? 0;
    final done = tasks?.where((t) => t.status == 'done').length ?? 0;
    return Card(
      color: brandCream,
      margin: EdgeInsets.zero,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              '${Strings.of('hello', lang)}, ${widget.profile.name}',
              style: textTheme.titleLarge,
            ),
            Text(
              widget.membership.household.name,
              style: const TextStyle(color: mutedText),
            ),
            if (total > 0) ...[
              const SizedBox(height: 16),
              Text(
                Strings.of(
                  'tasksDone',
                  lang,
                ).replaceAll('{done}', '$done').replaceAll('{total}', '$total'),
                style: textTheme.titleSmall,
              ),
              const SizedBox(height: 8),
              ClipRRect(
                borderRadius: BorderRadius.circular(4),
                child: LinearProgressIndicator(
                  value: done / total,
                  minHeight: 8,
                  backgroundColor: Colors.white,
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }

  /// A large, tappable card: status icon, task name, time and priority, and
  /// the current status underneath.
  Widget _taskCard(TaskRow t, AppLanguage lang) {
    final done = t.status == 'done';
    final status = [
      Strings.of('status_${t.status}', lang),
      if (t.cantDoReason != null) Strings.of('reason_${t.cantDoReason}', lang),
    ].join(': ');
    final details = [
      if (t.estMinutes != null)
        '${t.estMinutes} ${Strings.of('minutes', lang)}',
      Strings.of('priority_${t.priority}', lang),
    ].join(' · ');
    return Card(
      margin: const EdgeInsets.only(top: 8),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
        side: BorderSide(color: done ? brandAmber : Colors.black12),
      ),
      child: InkWell(
        borderRadius: BorderRadius.circular(12),
        onTap: () => _changeStatus(t, lang),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            children: [
              Icon(
                statusIcons[t.status] ?? Icons.radio_button_unchecked,
                size: 36,
                color: statusColor(t.status) ?? Colors.black54,
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      t.title(lang),
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        decoration: done ? TextDecoration.lineThrough : null,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(details, style: const TextStyle(color: mutedText)),
                    const SizedBox(height: 4),
                    Text(
                      status,
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        color: statusColor(t.status),
                      ),
                    ),
                  ],
                ),
              ),
              const Icon(Icons.chevron_right),
            ],
          ),
        ),
      ),
    );
  }
}
