import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shimmer/shimmer.dart';
import 'package:confetti/confetti.dart';

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
  final bool readOnly;

  const MyTasksScreen({
    super.key,
    required this.lang,
    required this.profile,
    required this.membership,
    this.readOnly = false,
  });

  @override
  State<MyTasksScreen> createState() => _MyTasksScreenState();
}

class _MyTasksScreenState extends State<MyTasksScreen> {
  late DateTime _day;
  late Future<List<TaskRow>> _tasks;
  late FlutterTts _flutterTts;

  late ConfettiController _confettiController;

  @override
  void initState() {
    super.initState();
    _confettiController =
        ConfettiController(duration: const Duration(seconds: 1));
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
    final tasks = await AppData.fetchMyTasks(
      householdId: widget.membership.household.id,
      day: _day,
      generateRecurringTasks: !widget.readOnly,
    );
    return tasks
        .map(
          (t) => TaskRow(
            id: t.id,
            status: t.status.stringValue,
            cantDoReason: t.cantDoReason?.stringValue,
            statusNote: t.statusNote,
            statusNoteEn: t.statusNoteEn,
            statusNoteSi: t.statusNoteSi,
            statusNoteTa: t.statusNoteTa,
            statusPhoto: t.statusPhoto,
            priority: t.template.priority.stringValue,
            estMinutes: t.template.estMinutes,
            customTitle: t.template.customTitle,
            nameEn: t.template.library?.nameEn,
            nameSi: t.template.library?.nameSi,
            nameTa: t.template.library?.nameTa,
            customTitleSi: t.template.customTitleSi,
            customTitleTa: t.template.customTitleTa,
            photoUrl: t.template.photoUrl,
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

  /// Pick a new status for [t] — for "can't do", the reason — and for "need
  /// help" / "can't do", an optional note and photo for the owner.
  Future<void> _changeStatus(TaskRow t, AppLanguage lang) async {
    if (widget.readOnly) return;
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
    _ProblemDetails? details;
    if (status == 'need_help' || status == 'cant_do') {
      if (!mounted) return;
      details = await showModalBottomSheet<_ProblemDetails>(
        context: context,
        isScrollControlled: true,
        builder: (_) => _ProblemDetailsSheet(
          lang: lang,
          initialNote: t.status == status ? t.statusNote : null,
        ),
      );
      if (details == null) return;
    }
    if (!mounted) return;
    showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (_) => const Center(child: CircularProgressIndicator()),
    );
    try {
      final photo = details?.photo;
      await AppData.updateMyTaskStatus(
        taskId: t.id,
        status: status,
        cantDoReason: reason,
        note: details?.note,
        photoUrl: photo == null
            ? null
            : await AppData.uploadTaskPhoto(
                householdId: widget.membership.household.id,
                bytes: photo,
              ),
      );
      if (!mounted) return;
      Navigator.of(context).pop();
      if (status == 'done') {
        _confettiController.play();
      }
      setState(_load);
    } catch (e) {
      if (!mounted) return;
      Navigator.of(context).pop();
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(e.toString())));
    }
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<AppLanguage>(
      valueListenable: widget.lang,
      builder: (context, lang, _) {
        final futureBuilder = FutureBuilder<List<TaskRow>>(
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
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    child: Shimmer.fromColors(
                      baseColor: Colors.grey[300]!,
                      highlightColor: Colors.grey[100]!,
                      child: Column(
                        children: List.generate(
                          3,
                          (index) => Padding(
                            padding: const EdgeInsets.only(bottom: 8.0),
                            child: Container(
                              height: 120,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(12),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
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

        return Stack(
          alignment: Alignment.topCenter,
          children: [
            futureBuilder,
            ConfettiWidget(
              confettiController: _confettiController,
              blastDirectionality: BlastDirectionality.explosive,
              particleDrag: 0.05,
              emissionFrequency: 0.05,
              numberOfParticles: 50,
              gravity: 0.2,
              shouldLoop: false,
              colors: const [
                Colors.green,
                Colors.blue,
                Colors.pink,
                Colors.orange,
                Colors.purple
              ],
            ),
          ],
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
        onTap: widget.readOnly ? null : () => _changeStatus(t, lang),
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
                            decoration:
                                done ? TextDecoration.lineThrough : null,
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
                    TaskStatusDetails(task: t, lang: lang),
                  ],
                ),
              ),
              IconButton(
                icon: const Icon(Icons.volume_up_outlined),
                onPressed: () => _speakTask(t.title(lang), lang),
                tooltip: 'Read Aloud',
              ),
              if (t.photoUrl != null) ...[
                const SizedBox(width: 8),
                TaskPhotoThumb(url: t.photoUrl!, size: 64),
              ],
              if (!widget.readOnly) const Icon(Icons.chevron_right),
            ],
          ),
        ),
      ),
    );
  }
}

/// What the staff member added in [_ProblemDetailsSheet]; both optional.
class _ProblemDetails {
  final String? note;
  final Uint8List? photo;

  const _ProblemDetails({this.note, this.photo});
}

/// After marking a task "need help" or "can't do": an optional note and
/// photo for the owner. Skip sends neither; dismissing cancels the change.
class _ProblemDetailsSheet extends StatefulWidget {
  final AppLanguage lang;
  final String? initialNote;

  const _ProblemDetailsSheet({required this.lang, this.initialNote});

  @override
  State<_ProblemDetailsSheet> createState() => _ProblemDetailsSheetState();
}

class _ProblemDetailsSheetState extends State<_ProblemDetailsSheet> {
  late final _note = TextEditingController(text: widget.initialNote);
  Uint8List? _photo;

  @override
  void dispose() {
    _note.dispose();
    super.dispose();
  }

  Future<void> _pickPhoto() async {
    final lang = widget.lang;
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
      setState(() => _photo = bytes);
    } catch (e) {
      if (!mounted) return;
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(e.toString())));
    }
  }

  @override
  Widget build(BuildContext context) {
    final lang = widget.lang;
    final photo = _photo;
    return SafeArea(
      child: Padding(
        padding: EdgeInsets.fromLTRB(
          16,
          16,
          16,
          16 + MediaQuery.of(context).viewInsets.bottom,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              Strings.of('tellOwnerMore', lang),
              style: Theme.of(context).textTheme.titleMedium,
            ),
            const SizedBox(height: 12),
            TextField(
              controller: _note,
              minLines: 2,
              maxLines: 4,
              textCapitalization: TextCapitalization.sentences,
              decoration: InputDecoration(
                hintText: Strings.of('whatHappened', lang),
                border: const OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 12),
            if (photo == null)
              OutlinedButton.icon(
                onPressed: _pickPhoto,
                icon: const Icon(Icons.add_a_photo_outlined),
                label: Text(Strings.of('addPhoto', lang)),
              )
            else
              Stack(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                    child: Image.memory(
                      photo,
                      height: 160,
                      width: double.infinity,
                      fit: BoxFit.cover,
                    ),
                  ),
                  Positioned(
                    top: 4,
                    right: 4,
                    child: IconButton.filledTonal(
                      icon: const Icon(Icons.close),
                      onPressed: () => setState(() => _photo = null),
                    ),
                  ),
                ],
              ),
            const SizedBox(height: 16),
            Row(
              children: [
                Expanded(
                  child: TextButton(
                    onPressed: () =>
                        Navigator.of(context).pop(const _ProblemDetails()),
                    child: Text(Strings.of('skip', lang)),
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: FilledButton(
                    onPressed: () {
                      final note = _note.text.trim();
                      Navigator.of(context).pop(
                        _ProblemDetails(
                          note: note.isEmpty ? null : note,
                          photo: _photo,
                        ),
                      );
                    },
                    child: Text(Strings.of('send', lang)),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
