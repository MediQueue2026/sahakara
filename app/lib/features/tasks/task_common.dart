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
  final String priority;
  final int? estMinutes;
  final String? customTitle;
  final String? nameEn;
  final String? nameSi;
  final String? nameTa;
  final String? assigneeId;
  final String? assigneeName;

  const TaskRow({
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
