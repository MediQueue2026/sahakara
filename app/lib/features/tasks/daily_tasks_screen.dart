import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';

import '../../core/app_data.dart';
import '../../core/app_language.dart';
import '../../core/strings.dart';
import 'add_daily_task_screen.dart';
import 'task_common.dart';

/// Owner: one day's tasks across the household, grouped by the staff member
/// each is assigned to (unassigned ones first), with a button to add more
/// and each task's status; tapping a task assigns or reassigns it.
/// Staff see their own tasks on MyTasksScreen instead.
class DailyTasksScreen extends StatefulWidget {
  final LanguageController lang;
  final Membership membership;

  const DailyTasksScreen({
    super.key,
    required this.lang,
    required this.membership,
  });

  @override
  State<DailyTasksScreen> createState() => _DailyTasksScreenState();
}

class _DailyTasksScreenState extends State<DailyTasksScreen> {
  late DateTime _day;
  late Future<List<TaskRow>> _tasks;
  late FlutterTts _flutterTts;

  @override
  void initState() {
    super.initState();
    _flutterTts = FlutterTts();
    final now = DateTime.now();
    _day = DateTime(now.year, now.month, now.day);
    _load();
  }

  Future<void> _speakTask(String text, AppLanguage lang) async {
    String languageCode = 'en-US';
    switch (lang) {
      case AppLanguage.en:
        languageCode = 'en-US';
        break;
      case AppLanguage.si:
        languageCode = 'si-LK';
        break;
      case AppLanguage.ta:
        languageCode = 'ta-IN';
        break;
    }

    var available = await _flutterTts.isLanguageAvailable(languageCode);
    if (available == false || available == 0) {
      final baseCode = languageCode.split('-').first;
      available = await _flutterTts.isLanguageAvailable(baseCode);
      if (available == true || available == 1) {
        languageCode = baseCode;
      }
    }

    if (available == true || available == 1) {
      await _flutterTts.setLanguage(languageCode);
      await _flutterTts.speak(text);
    } else {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text(
                "Voice not found! Please change your phone's Default TTS Engine to 'Google' in Settings."),
            duration: Duration(seconds: 4),
          ),
        );
      }
    }
  }

  void _load() {
    _tasks = _fetchTasks();
  }

  Future<List<TaskRow>> _fetchTasks() async {
    final tasks = await AppData.fetchHouseholdTasks(
      householdId: widget.membership.household.id,
      day: _day,
    );
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
            photoUrl: t.template.photoUrl,
            assigneeId: t.assignedTo?.id,
            assigneeName: t.assignedTo?.user.name,
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

  /// Pick which staff member [t] is assigned to.
  Future<void> _assign(TaskRow t, AppLanguage lang) async {
    try {
      final staff = (await AppData.fetchHouseholdMembers(
        widget.membership.household.id,
      ))
          .where((m) => m.active && m.role.stringValue != 'owner')
          .toList();
      if (staff.isEmpty) {
        _showError(Strings.of('noStaffYet', lang));
        return;
      }
      if (!mounted) return;
      final names = {for (final m in staff) m.id: m.user.name};
      final memberId = await pickOption(
        context,
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
          floatingActionButton: FloatingActionButton.extended(
            onPressed: _addTask,
            icon: const Icon(Icons.add),
            label: Text(Strings.of('addTask', lang)),
          ),
          body: Column(
            children: [
              DaySwitcher(day: _day, onChanged: _changeDay),
              Expanded(
                child: FutureBuilder<List<TaskRow>>(
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
                    return _buildGrouped(tasks, lang);
                  },
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  /// One card per staff member, headed by their name and the day's total
  /// estimated time, after a card of tasks not assigned yet.
  Widget _buildGrouped(List<TaskRow> tasks, AppLanguage lang) {
    // '' holds the unassigned tasks, and goes first so they're noticed.
    final byAssignee = <String, List<TaskRow>>{
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

  Widget _taskTile(TaskRow t, AppLanguage lang) {
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
        statusIcons[t.status] ?? Icons.radio_button_unchecked,
        color: statusColor(t.status),
      ),
      title: Text(t.title(lang)),
      subtitle: Text.rich(
        TextSpan(
          children: [
            TextSpan(
              text: status,
              style: TextStyle(color: statusColor(t.status)),
            ),
            TextSpan(text: ' · ${details.join(' · ')}'),
          ],
        ),
      ),
      onTap: () => _assign(t, lang),
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          IconButton(
            icon: const Icon(Icons.volume_up_outlined),
            onPressed: () => _speakTask(t.title(lang), lang),
            tooltip: 'Read Aloud',
          ),
          if (t.photoUrl != null) TaskPhotoThumb(url: t.photoUrl!, size: 40),
          IconButton(
            icon: const Icon(Icons.delete_outline),
            onPressed: () => _remove(t.id),
          ),
        ],
      ),
    );
  }
}
