import 'package:flutter/material.dart';

import '../../core/app_data.dart';
import '../../core/app_language.dart';
import '../../core/strings.dart';
import '../../core/theme.dart';
import '../home/staff_filter.dart';

/// What the owner entered in an [AttendanceRecordDialog].
class AttendanceRecordInput {
  final String memberId;
  final DateTime checkIn;
  final DateTime? checkOut;
  final String dayType;
  final double overtimeHours;
  final String? note;

  /// The owner chose to remove the record; the other fields are unused.
  final bool delete;

  const AttendanceRecordInput({
    required this.memberId,
    required this.checkIn,
    this.checkOut,
    required this.dayType,
    required this.overtimeHours,
    this.note,
    this.delete = false,
  });
}

/// Lets the owner add a day a staff member forgot to record, or correct
/// one. Pass [record] to edit it; otherwise pick from [staff].
class AttendanceRecordDialog extends StatefulWidget {
  final LanguageController lang;
  final DateTime day;
  final List<StaffOption> staff;
  final String? initialMemberId;
  final HouseholdAttendance? record;

  const AttendanceRecordDialog({
    super.key,
    required this.lang,
    required this.day,
    this.staff = const [],
    this.initialMemberId,
    this.record,
  });

  @override
  State<AttendanceRecordDialog> createState() => _AttendanceRecordDialogState();
}

class _AttendanceRecordDialogState extends State<AttendanceRecordDialog> {
  late String _memberId;
  late String _dayType;
  late TimeOfDay _checkIn;
  TimeOfDay? _checkOut;
  late final TextEditingController _overtime;
  late final TextEditingController _note;
  String? _error;

  bool get _editing => widget.record != null;

  @override
  void initState() {
    super.initState();
    final record = widget.record;
    if (record != null) {
      _memberId = record.member.id;
      _dayType = record.dayType.stringValue;
      final checkIn = record.checkIn?.toDateTime().toLocal();
      final checkOut = record.checkOut?.toDateTime().toLocal();
      _checkIn = checkIn == null
          ? const TimeOfDay(hour: 8, minute: 0)
          : TimeOfDay.fromDateTime(checkIn);
      _checkOut = checkOut == null ? null : TimeOfDay.fromDateTime(checkOut);
      _overtime = TextEditingController(text: _number(record.overtimeHours));
      _note = TextEditingController(text: record.note ?? '');
    } else {
      _memberId = widget.staff.any((s) => s.id == widget.initialMemberId)
          ? widget.initialMemberId!
          : widget.staff.first.id;
      _dayType = 'full';
      _checkIn = const TimeOfDay(hour: 8, minute: 0);
      _overtime = TextEditingController(text: '0');
      _note = TextEditingController();
    }
  }

  @override
  void dispose() {
    _overtime.dispose();
    _note.dispose();
    super.dispose();
  }

  String _number(double value) =>
      value == value.roundToDouble() ? '${value.round()}' : '$value';

  DateTime _onDay(TimeOfDay time) => DateTime(
        widget.day.year,
        widget.day.month,
        widget.day.day,
        time.hour,
        time.minute,
      );

  Future<void> _pickCheckIn() async {
    final picked =
        await showTimePicker(context: context, initialTime: _checkIn);
    if (picked != null) setState(() => _checkIn = picked);
  }

  Future<void> _pickCheckOut() async {
    final picked = await showTimePicker(
      context: context,
      initialTime: _checkOut ?? const TimeOfDay(hour: 17, minute: 0),
    );
    if (picked != null) setState(() => _checkOut = picked);
  }

  void _submit() {
    final l = widget.lang.value;
    final overtime = double.tryParse(_overtime.text.trim());
    if (overtime == null || overtime < 0 || overtime > 24) {
      setState(() => _error = Strings.of('enterValidOvertime', l));
      return;
    }
    final checkIn = _onDay(_checkIn);
    final checkOut = _checkOut == null ? null : _onDay(_checkOut!);
    if (checkOut != null && !checkOut.isAfter(checkIn)) {
      setState(() => _error = Strings.of('checkOutAfterCheckIn', l));
      return;
    }
    final note = _note.text.trim();
    Navigator.pop(
      context,
      AttendanceRecordInput(
        memberId: _memberId,
        checkIn: checkIn,
        checkOut: checkOut,
        dayType: _dayType,
        overtimeHours: overtime,
        note: note.isEmpty ? null : note,
      ),
    );
  }

  Future<void> _delete() async {
    final l = widget.lang.value;
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        content: Text(Strings.of('confirmDeleteAttendance', l)),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: Text(Strings.of('cancel', l)),
          ),
          FilledButton(
            style: FilledButton.styleFrom(backgroundColor: brandMaroon),
            onPressed: () => Navigator.pop(context, true),
            child: Text(Strings.of('remove', l)),
          ),
        ],
      ),
    );
    if (confirmed != true || !mounted) return;
    Navigator.pop(
      context,
      AttendanceRecordInput(
        memberId: _memberId,
        checkIn: _onDay(_checkIn),
        dayType: _dayType,
        overtimeHours: 0,
        delete: true,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final l = widget.lang.value;
    final localizations = MaterialLocalizations.of(context);
    final dayTypes = {'full', 'half', _dayType};

    return AlertDialog(
      title: Text(Strings.of(_editing ? 'editAttendance' : 'addAttendance', l)),
      content: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              _editing
                  ? '${widget.record!.member.user.name} · '
                      '${localizations.formatMediumDate(widget.day)}'
                  : localizations.formatMediumDate(widget.day),
              style: Theme.of(context).textTheme.titleSmall,
            ),
            const SizedBox(height: 12),
            if (!_editing) ...[
              DropdownButtonFormField<String>(
                initialValue: _memberId,
                decoration:
                    InputDecoration(labelText: Strings.of('selectStaff', l)),
                items: [
                  for (final option in widget.staff)
                    DropdownMenuItem(
                      value: option.id,
                      child: Text(option.name),
                    ),
                ],
                onChanged: (value) {
                  if (value != null) setState(() => _memberId = value);
                },
              ),
              const SizedBox(height: 12),
            ],
            DropdownButtonFormField<String>(
              initialValue: _dayType,
              decoration:
                  InputDecoration(labelText: Strings.of('attendanceType', l)),
              items: [
                for (final type in dayTypes)
                  DropdownMenuItem(
                    value: type,
                    child: Text(Strings.of('dayType_$type', l)),
                  ),
              ],
              onChanged: (value) {
                if (value != null) setState(() => _dayType = value);
              },
            ),
            const SizedBox(height: 12),
            OutlinedButton.icon(
              onPressed: _pickCheckIn,
              icon: const Icon(Icons.login),
              label: Text(
                '${Strings.of('checkIn', l)}: '
                '${localizations.formatTimeOfDay(_checkIn)}',
              ),
            ),
            const SizedBox(height: 8),
            Row(
              children: [
                Expanded(
                  child: OutlinedButton.icon(
                    onPressed: _pickCheckOut,
                    icon: const Icon(Icons.logout),
                    label: Text(
                      _checkOut == null
                          ? Strings.of('notCheckedOut', l)
                          : '${Strings.of('checkOut', l)}: '
                              '${localizations.formatTimeOfDay(_checkOut!)}',
                    ),
                  ),
                ),
                if (_checkOut != null)
                  IconButton(
                    tooltip: Strings.of('remove', l),
                    onPressed: () => setState(() => _checkOut = null),
                    icon: const Icon(Icons.close),
                  ),
              ],
            ),
            const SizedBox(height: 12),
            TextField(
              controller: _overtime,
              keyboardType:
                  const TextInputType.numberWithOptions(decimal: true),
              decoration:
                  InputDecoration(labelText: Strings.of('overtimeHours', l)),
            ),
            const SizedBox(height: 12),
            TextField(
              controller: _note,
              decoration:
                  InputDecoration(labelText: Strings.of('noteOptional', l)),
              maxLines: 2,
            ),
            if (_error != null) ...[
              const SizedBox(height: 8),
              Text(
                _error!,
                style: TextStyle(color: Theme.of(context).colorScheme.error),
              ),
            ],
          ],
        ),
      ),
      actions: [
        if (_editing)
          TextButton(
            onPressed: _delete,
            style: TextButton.styleFrom(foregroundColor: brandMaroon),
            child: Text(Strings.of('remove', l)),
          ),
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: Text(Strings.of('cancel', l)),
        ),
        FilledButton(
          onPressed: _submit,
          child: Text(Strings.of('save', l)),
        ),
      ],
    );
  }
}
