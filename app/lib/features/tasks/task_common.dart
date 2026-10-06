import 'package:flutter/material.dart';

import '../../core/app_language.dart';
import '../../core/theme.dart';

/// Pieces shared by the owner's Daily tasks screen and staff's My tasks
/// screen.

/// Statuses a staff member can set on their own task (see
/// UpdateMyTaskStatus in dataconnect/connector/mutations.gql).
const staffStatuses = ['started', 'done', 'need_help', 'cant_do'];

const cantDoReasons = [
  'no_supplies',
  'power_cut',
  'water_cut',
  'sick',
  'no_time',
  'other',
];

const statusIcons = {
  'pending': Icons.radio_button_unchecked,
  'started': Icons.play_circle_outline,
  'done': Icons.check_circle,
  'need_help': Icons.help_outline,
  'cant_do': Icons.block,
  'carried_forward': Icons.redo,
};

/// Only finished tasks are coloured (amber); the icon tells the other
/// statuses apart.
Color? statusColor(String status) => status == 'done' ? brandAmber : null;

/// The fields the task screens show, from either the owner's or the staff
/// member's query result.
class TaskRow {
  final String id;
  final String status;
  final String? cantDoReason;
  // The staff member's optional explanation for need_help / cant_do.
  final String? statusNote;
  final String? statusNoteEn;
  final String? statusNoteSi;
  final String? statusNoteTa;
  final String? statusPhoto;
  final String priority;
  final int? estMinutes;
  final String? customTitle;
  final String? customTitleSi;
  final String? customTitleTa;
  final String? nameEn;
  final String? nameSi;
  final String? nameTa;
  final String? photoUrl;
  final String? assigneeId;
  final String? assigneeName;

  const TaskRow({
    required this.id,
    required this.status,
    this.cantDoReason,
    this.statusNote,
    this.statusNoteEn,
    this.statusNoteSi,
    this.statusNoteTa,
    this.statusPhoto,
    required this.priority,
    this.estMinutes,
    this.customTitle,
    this.customTitleSi,
    this.customTitleTa,
    this.nameEn,
    this.nameSi,
    this.nameTa,
    this.photoUrl,
    this.assigneeId,
    this.assigneeName,
  });

  String title(AppLanguage lang) {
    if (nameEn == null) {
      if (lang == AppLanguage.si && customTitleSi != null)
        return customTitleSi!;
      if (lang == AppLanguage.ta && customTitleTa != null)
        return customTitleTa!;
      return customTitle ?? '';
    }
    return pickName(lang, en: nameEn!, si: nameSi, ta: nameTa);
  }

  /// [statusNote] in [lang], or as written if it has no translation.
  String? note(AppLanguage lang) {
    final translated = switch (lang) {
      AppLanguage.en => statusNoteEn,
      AppLanguage.si => statusNoteSi,
      AppLanguage.ta => statusNoteTa,
    };
    return translated ?? statusNote;
  }
}

/// The staff member's note and photo on a task marked need help / can't do,
/// or nothing if they didn't add any.
class TaskStatusDetails extends StatelessWidget {
  final TaskRow task;
  final AppLanguage lang;

  const TaskStatusDetails({super.key, required this.task, required this.lang});

  @override
  Widget build(BuildContext context) {
    final note = task.note(lang);
    final photo = task.statusPhoto;
    if (note == null && photo == null) return const SizedBox.shrink();
    return Padding(
      padding: const EdgeInsets.only(top: 6),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (photo != null) ...[
            TaskPhotoThumb(url: photo, size: 48),
            const SizedBox(width: 8),
          ],
          if (note != null)
            Expanded(
              child: Text(
                '"$note"',
                style: const TextStyle(
                  fontStyle: FontStyle.italic,
                  color: Colors.black87,
                ),
              ),
            ),
        ],
      ),
    );
  }
}

/// A square thumbnail of the photo explaining a task; tapping it opens the
/// photo full screen.
class TaskPhotoThumb extends StatelessWidget {
  final String url;
  final double size;

  const TaskPhotoThumb({super.key, required this.url, this.size = 56});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Navigator.of(context).push(
        MaterialPageRoute(builder: (_) => _TaskPhotoView(url: url)),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(8),
        child: Image.network(
          url,
          width: size,
          height: size,
          fit: BoxFit.cover,
          errorBuilder: (context, error, stack) => SizedBox(
            width: size,
            height: size,
            child: const Icon(Icons.broken_image_outlined, color: mutedText),
          ),
        ),
      ),
    );
  }
}

/// A task's photo, full screen, pinch to zoom.
class _TaskPhotoView extends StatelessWidget {
  final String url;

  const _TaskPhotoView({required this.url});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        foregroundColor: Colors.white,
      ),
      body: InteractiveViewer(
        maxScale: 5,
        child: Center(child: Image.network(url)),
      ),
    );
  }
}

/// A bottom sheet listing [options]; returns the tapped one, or null if
/// dismissed.
Future<String?> pickOption(
  BuildContext context, {
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
            title: Text(title, style: Theme.of(context).textTheme.titleMedium),
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

/// Previous day / pick a date / next day.
class DaySwitcher extends StatelessWidget {
  final DateTime day;
  final ValueChanged<DateTime> onChanged;

  const DaySwitcher({super.key, required this.day, required this.onChanged});

  Future<void> _pickDay(BuildContext context) async {
    final picked = await showDatePicker(
      context: context,
      initialDate: day,
      firstDate: DateTime(day.year - 1),
      lastDate: DateTime(day.year + 1, 12, 31),
    );
    if (picked != null) onChanged(picked);
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          IconButton(
            icon: const Icon(Icons.chevron_left),
            onPressed: () => onChanged(day.subtract(const Duration(days: 1))),
          ),
          TextButton.icon(
            onPressed: () => _pickDay(context),
            icon: const Icon(Icons.calendar_today_outlined),
            label: Text(day.toIso8601String().substring(0, 10)),
          ),
          IconButton(
            icon: const Icon(Icons.chevron_right),
            onPressed: () => onChanged(day.add(const Duration(days: 1))),
          ),
        ],
      ),
    );
  }
}
