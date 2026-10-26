import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';
import '../../core/app_data.dart';
import '../../core/auto_refresh.dart';
import '../../core/app_language.dart';
import '../../core/strings.dart';
import '../../core/theme.dart';
import '../home/staff_filter.dart';
import 'attendance_record_dialog.dart';
import 'leave_request_dialog.dart';

class AttendanceTab extends StatefulWidget {
  final LanguageController lang;
  final Membership membership;
  final Profile profile;
  final bool readOnly;

  const AttendanceTab({
    super.key,
    required this.lang,
    required this.membership,
    required this.profile,
    this.readOnly = false,
  });

  @override
  State<AttendanceTab> createState() => _AttendanceTabState();
}

class _AttendanceTabState extends State<AttendanceTab> {
  bool get _isOwner => widget.membership.role.stringValue == 'owner';
  String get _householdId => widget.membership.household.id;
  String get _memberId => widget.membership.id;

  List<dynamic> _attendance = [];
  List<dynamic> _leaveRequests = [];
  List<Member> _staff = [];

  /// The staff member whose attendance the owner is looking at, or null for
  /// everyone in the household.
  String? _selectedMemberId;
  bool _busy = false;
  bool _loading = true;
  String _dayType = 'full';

  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDay = DateTime.now();

  @override
  void initState() {
    super.initState();
    _refresh();
  }

  /// Reloads everything. [quiet] is for the automatic reloads: no spinner
  /// over what's on screen and no error message, and it skips while an
  /// action is running, since that reloads when it's done.
  Future<void> _refresh({bool quiet = false}) async {
    if (quiet && _busy) return;
    if (!quiet) setState(() => _loading = true);
    try {
      if (_isOwner) {
        _attendance = await AppData.fetchHouseholdAttendance(_householdId);
        _leaveRequests =
            await AppData.fetchHouseholdLeaveRequests(_householdId);
        final members = await AppData.fetchHouseholdMembers(_householdId);
        _staff = members
            .where(
              (member) =>
                  member.role.stringValue != 'owner' &&
                  member.active &&
                  member.status.stringValue == 'accepted',
            )
            .toList();
        if (!_staffOptions().any((option) => option.id == _selectedMemberId)) {
          _selectedMemberId = null;
        }
      } else {
        _attendance = await AppData.fetchMyAttendance();
        _leaveRequests = await AppData.fetchMyLeaveRequests();
      }
    } catch (e) {
      if (mounted && !quiet) {
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text(e.toString())));
      }
    } finally {
      if (mounted) setState(() => _loading = false);
    }
  }

  Future<double?> _promptOvertimeHours() async {
    final controller = TextEditingController(text: '0');
    try {
      return await showDialog<double>(
        context: context,
        builder: (dialogContext) {
          String? error;
          return StatefulBuilder(
            builder: (context, setDialogState) => AlertDialog(
              title: Text(Strings.of('overtimeHours', widget.lang.value)),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  TextField(
                    controller: controller,
                    autofocus: true,
                    keyboardType: const TextInputType.numberWithOptions(
                      decimal: true,
                    ),
                    decoration: InputDecoration(
                      labelText: Strings.of('overtimeHours', widget.lang.value),
                      errorText: error,
                    ),
                  ),
                ],
              ),
              actions: [
                TextButton(
                  onPressed: () => Navigator.pop(dialogContext),
                  child: Text(Strings.of('cancel', widget.lang.value)),
                ),
                FilledButton(
                  onPressed: () {
                    final value = double.tryParse(controller.text.trim());
                    if (value == null || value < 0 || value > 24) {
                      setDialogState(
                        () => error = Strings.of(
                          'enterValidOvertime',
                          widget.lang.value,
                        ),
                      );
                      return;
                    }
                    Navigator.pop(dialogContext, value);
                  },
                  child: Text(Strings.of('save', widget.lang.value)),
                ),
              ],
            ),
          );
        },
      );
    } finally {
      controller.dispose();
    }
  }

  Future<void> _checkIn() async {
    setState(() => _busy = true);
    try {
      final now = DateTime.now();
      final today = DateTime(now.year, now.month, now.day);
      await AppData.checkIn(
        memberId: _memberId,
        day: today,
        dayType: _dayType,
      );
      await _refresh();
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text(e.toString())));
      }
    } finally {
      if (mounted) setState(() => _busy = false);
    }
  }

  Future<void> _checkOut() async {
    final overtimeHours = await _promptOvertimeHours();
    if (overtimeHours == null) return;
    setState(() => _busy = true);
    try {
      final now = DateTime.now();
      final today = DateTime(now.year, now.month, now.day);
      await AppData.checkOut(
        memberId: _memberId,
        day: today,
        overtimeHours: overtimeHours,
      );
      await _refresh();
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text(e.toString())));
      }
    } finally {
      if (mounted) setState(() => _busy = false);
    }
  }

  Future<void> _requestLeave() async {
    final result = await showDialog<bool>(
      context: context,
      builder: (context) =>
          LeaveRequestDialog(memberId: _memberId, lang: widget.lang),
    );
    if (result == true) {
      await _refresh();
    }
  }

  Future<void> _reviewLeave(String id, String status) async {
    setState(() => _busy = true);
    try {
      await AppData.reviewLeaveRequest(id: id, status: status);
      await _refresh();
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text(e.toString())));
      }
    } finally {
      if (mounted) setState(() => _busy = false);
    }
  }

  Future<void> _cancelLeave(String id) async {
    setState(() => _busy = true);
    try {
      await AppData.deleteLeaveRequest(id);
      await _refresh();
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text(e.toString())));
      }
    } finally {
      if (mounted) setState(() => _busy = false);
    }
  }

  /// Current staff with nothing recorded on [day], for the owner to add.
  List<StaffOption> _staffWithoutRecord(DateTime day) => [
        for (final member in _staff)
          if (!_attendance.any(
            (a) => a.member.id == member.id && isSameDay(a.day, day),
          ))
            StaffOption(member.id, member.user.name),
      ];

  /// Owner only: adds a missing day, or corrects or removes [record].
  Future<void> _openRecordDialog(DateTime day, {dynamic record}) async {
    final input = await showDialog<AttendanceRecordInput>(
      context: context,
      builder: (context) => AttendanceRecordDialog(
        lang: widget.lang,
        day: day,
        staff: _staffWithoutRecord(day),
        initialMemberId: _selectedMemberId,
        record: record as HouseholdAttendance?,
      ),
    );
    if (input == null) return;

    setState(() => _busy = true);
    try {
      if (record == null) {
        await AppData.addAttendanceRecord(
          memberId: input.memberId,
          day: DateTime(day.year, day.month, day.day),
          checkIn: input.checkIn,
          checkOut: input.checkOut,
          dayType: input.dayType,
          overtimeHours: input.overtimeHours,
          note: input.note,
        );
      } else if (input.delete) {
        await AppData.deleteAttendanceRecord(record.id);
      } else {
        await AppData.updateAttendanceRecord(
          id: record.id,
          checkIn: input.checkIn,
          checkOut: input.checkOut,
          dayType: input.dayType,
          overtimeHours: input.overtimeHours,
          note: input.note,
        );
      }
      await _refresh();
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text(e.toString())));
      }
    } finally {
      if (mounted) setState(() => _busy = false);
    }
  }

  Widget _buildAddRecordButton(AppLanguage l) {
    final day = _selectedDay!;
    final now = DateTime.now();
    final isFuture = DateTime(day.year, day.month, day.day)
        .isAfter(DateTime(now.year, now.month, now.day));
    return Align(
      alignment: Alignment.centerRight,
      child: Padding(
        padding: const EdgeInsets.only(bottom: 8),
        child: FilledButton.icon(
          onPressed: _busy || isFuture || _staffWithoutRecord(day).isEmpty
              ? null
              : () => _openRecordDialog(day),
          icon: const Icon(Icons.edit_calendar),
          label: Text(Strings.of('addAttendance', l)),
        ),
      ),
    );
  }

  bool _isDayInLeave(DateTime day, dynamic req) {
    final from =
        DateTime(req.fromDate.year, req.fromDate.month, req.fromDate.day);
    final to = DateTime(req.toDate.year, req.toDate.month, req.toDate.day);
    final d = DateTime(day.year, day.month, day.day);
    return d.compareTo(from) >= 0 && d.compareTo(to) <= 0;
  }

  /// Current staff first, then former staff who still have attendance or
  /// leave on record.
  List<StaffOption> _staffOptions() => StaffOption.collect(
        [for (final member in _staff) StaffOption(member.id, member.user.name)],
        [
          for (final record in _attendance)
            (record.member.id as String, record.member.user.name as String),
          for (final request in _leaveRequests)
            (request.member.id as String, request.member.user.name as String),
        ],
      );

  // Staff only ever load their own records, so these filter just for the
  // owner.
  Iterable<dynamic> get _visibleAttendance => _selectedMemberId == null
      ? _attendance
      : _attendance.where((a) => a.member.id == _selectedMemberId);

  Iterable<dynamic> get _visibleLeaveRequests => _selectedMemberId == null
      ? _leaveRequests
      : _leaveRequests.where((l) => l.member.id == _selectedMemberId);

  List<dynamic> _getEventsForDay(DateTime day) {
    final events = [];
    events.addAll(_visibleAttendance.where((a) => isSameDay(a.day, day)));
    events.addAll(_visibleLeaveRequests.where((l) => _isDayInLeave(day, l)));
    return events;
  }

  /// The selected staff member's totals for the month shown on the calendar.
  Widget _buildMonthSummary(AppLanguage l) {
    bool inMonth(DateTime day) =>
        day.year == _focusedDay.year && day.month == _focusedDay.month;

    final records = _visibleAttendance.where((a) => inMonth(a.day));
    final fullDays =
        records.where((a) => a.dayType.stringValue == 'full').length;
    final halfDays =
        records.where((a) => a.dayType.stringValue == 'half').length;
    final overtime = records.fold<double>(
      0,
      (total, a) => total + (a.overtimeHours as num).toDouble(),
    );

    var leaveDays = 0.0;
    final daysInMonth =
        DateTime(_focusedDay.year, _focusedDay.month + 1, 0).day;
    for (final request in _visibleLeaveRequests) {
      if (request.status.stringValue != 'approved') continue;
      for (var d = 1; d <= daysInMonth; d++) {
        final day = DateTime(_focusedDay.year, _focusedDay.month, d);
        if (_isDayInLeave(day, request)) {
          leaveDays += request.isHalfDay ? 0.5 : 1;
        }
      }
    }

    String number(num value) =>
        value == value.roundToDouble() ? '${value.round()}' : '$value';

    Widget row(String key, num value) => Padding(
          padding: const EdgeInsets.symmetric(vertical: 2),
          child: Row(
            children: [
              Expanded(child: Text(Strings.of(key, l))),
              Text(
                number(value),
                style: const TextStyle(fontWeight: FontWeight.w600),
              ),
            ],
          ),
        );

    return Card(
      margin: const EdgeInsets.only(bottom: 16),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              MaterialLocalizations.of(context).formatMonthYear(_focusedDay),
              style: Theme.of(context).textTheme.titleMedium,
            ),
            const SizedBox(height: 8),
            row('fullDaysWorked', fullDays),
            row('halfDaysWorked', halfDays),
            row('overtimeHours', overtime),
            row('leaveDaysApproved', leaveDays),
          ],
        ),
      ),
    );
  }

  Widget _buildMaidActions(AppLanguage l) {
    final today = DateTime.now();
    final todayAttendance = _attendance.where((record) {
      return isSameDay(record.day, today);
    }).firstOrNull;
    final canCheckIn =
        todayAttendance == null || todayAttendance.checkIn == null;
    final canCheckOut =
        todayAttendance?.checkIn != null && todayAttendance?.checkOut == null;
    final selectedDayType = todayAttendance?.dayType.stringValue ?? _dayType;

    return Card(
      margin: const EdgeInsets.only(bottom: 16),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            DropdownButtonFormField<String>(
              initialValue: selectedDayType,
              decoration: InputDecoration(
                labelText: Strings.of('attendanceType', l),
              ),
              items: [
                DropdownMenuItem(
                  value: 'full',
                  child: Text(Strings.of('dayType_full', l)),
                ),
                DropdownMenuItem(
                  value: 'half',
                  child: Text(Strings.of('dayType_half', l)),
                ),
              ],
              onChanged: canCheckIn && !widget.readOnly
                  ? (value) {
                      if (value != null) setState(() => _dayType = value);
                    }
                  : null,
            ),
            const SizedBox(height: 12),
            Row(
              children: [
                Expanded(
                  child: FilledButton.icon(
                    onPressed: _busy || !canCheckIn || widget.readOnly
                        ? null
                        : _checkIn,
                    icon: const Icon(Icons.login),
                    label: Text(Strings.of('checkIn', widget.lang.value)),
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: FilledButton.icon(
                    onPressed: _busy || !canCheckOut || widget.readOnly
                        ? null
                        : _checkOut,
                    icon: const Icon(Icons.logout),
                    label: Text(Strings.of('checkOut', widget.lang.value)),
                    style:
                        FilledButton.styleFrom(
                            backgroundColor: brandMaroon,
                            foregroundColor: Colors.white),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            SizedBox(
              width: double.infinity,
              child: OutlinedButton.icon(
                onPressed: _busy || widget.readOnly ? null : _requestLeave,
                icon: const Icon(Icons.event_busy),
                label: Text(Strings.of('requestLeave', widget.lang.value)),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildEventList(List<dynamic> events, AppLanguage l) {
    if (events.isEmpty) {
      return Padding(
        padding: const EdgeInsets.all(24.0),
        child: Text(Strings.of('noAttendanceRecords', widget.lang.value),
            textAlign: TextAlign.center),
      );
    }

    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: events.length,
      itemBuilder: (context, index) {
        final ev = events[index];
        final isLeave = ev.runtimeType.toString().contains('Leave');

        if (isLeave) {
          final id = ev.id;
          final fromDate = ev.fromDate;
          final toDate = ev.toDate;
          final statusStr = ev.status.stringValue;
          final leaveTypeStr = ev.leaveType.stringValue;
          final reason = ev.reason ?? Strings.of('noReasonProvided', l);

          final leaveTypeTranslated = Strings.of('leave_$leaveTypeStr', l);
          final statusTranslated = Strings.of('leave_status_$statusStr', l);

          String title =
              '$leaveTypeTranslated: ${fromDate.year}-${fromDate.month}-${fromDate.day} to ${toDate.year}-${toDate.month}-${toDate.day}';
          if (ev.isHalfDay) title += ' (${Strings.of('halfDay', l)})';
          if (_isOwner) {
            title = '${ev.member.user.name} - $title';
          }

          return Card(
            child: ListTile(
              title: Text(title),
              subtitle: Text(
                  '${Strings.of('status', l)}: $statusTranslated\n$reason'),
              isThreeLine: true,
              trailing: _isOwner && statusStr == 'pending'
                  ? Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(
                          icon: const Icon(Icons.check_circle,
                              color: brandGold),
                          onPressed:
                              _busy ? null : () => _reviewLeave(id, 'approved'),
                        ),
                        IconButton(
                          icon: const Icon(Icons.cancel, color: brandMaroon),
                          onPressed:
                              _busy ? null : () => _reviewLeave(id, 'rejected'),
                        ),
                      ],
                    )
                  : (!_isOwner && statusStr == 'pending')
                      ? IconButton(
                          icon: const Icon(Icons.delete_outline,
                              color: brandMaroon),
                          onPressed: _busy || widget.readOnly
                              ? null
                              : () => _cancelLeave(id),
                        )
                      : Icon(
                          statusStr == 'approved'
                              ? Icons.check_circle
                              : (statusStr == 'rejected'
                                  ? Icons.cancel
                                  : Icons.hourglass_empty),
                          color: statusStr == 'approved'
                              ? brandGold
                              : (statusStr == 'rejected'
                                  ? brandMaroon
                                  : Colors.black38),
                        ),
            ),
          );
        } else {
          final day = ev.day;
          final checkIn = ev.checkIn;
          final checkOut = ev.checkOut;
          final dayType = ev.dayType.stringValue;

          String title =
              '${day.year}-${day.month}-${day.day} (${Strings.of('dayType_$dayType', l)})';
          if (_isOwner) {
            title = '${ev.member.user.name} - $title';
          }

          String subtitle =
              '${Strings.of('checkIn', l)}: ${checkIn != null ? '${checkIn.toDateTime().toLocal().hour}:${checkIn.toDateTime().toLocal().minute.toString().padLeft(2, '0')}' : '...'}';
          if (checkOut != null) {
            subtitle +=
                '\n${Strings.of('checkOut', l)}: ${checkOut.toDateTime().toLocal().hour}:${checkOut.toDateTime().toLocal().minute.toString().padLeft(2, '0')}';
          }
          if (ev.overtimeHours > 0) {
            subtitle +=
                '\n${Strings.of('overtimeHours', l)}: ${ev.overtimeHours}';
          }
          if (ev.note != null) subtitle += '\n${ev.note}';

          return Card(
            child: ListTile(
              title: Text(title),
              subtitle: Text(subtitle),
              onTap: _isOwner && !_busy
                  ? () => _openRecordDialog(day, record: ev)
                  : null,
              trailing: Icon(
                _isOwner ? Icons.edit_outlined : Icons.access_time,
              ),
            ),
          );
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final l = widget.lang.value;
    final selectedEvents =
        _selectedDay != null ? _getEventsForDay(_selectedDay!) : [];

    return AutoRefresh(
      onRefresh: () => _refresh(quiet: true),
      child: RefreshIndicator(
        onRefresh: () async => _refresh(),
        child: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            if (!_isOwner) _buildMaidActions(l),
            if (_isOwner && _staffOptions().isNotEmpty)
              StaffFilter(
                options: _staffOptions(),
                selectedId: _selectedMemberId,
                onSelected: (id) => setState(() => _selectedMemberId = id),
                lang: l,
              ),
            if (_isOwner && _selectedMemberId != null) _buildMonthSummary(l),
            Card(
              clipBehavior: Clip.antiAlias,
              child: TableCalendar(
                firstDay: DateTime.now().subtract(const Duration(days: 365)),
                lastDay: DateTime.now().add(const Duration(days: 365)),
                focusedDay: _focusedDay,
                selectedDayPredicate: (day) => isSameDay(_selectedDay, day),
                onDaySelected: (selectedDay, focusedDay) {
                  setState(() {
                    _selectedDay = selectedDay;
                    _focusedDay = focusedDay;
                  });
                },
                // Keeps the month summary in step with the month on screen.
                onPageChanged: (focusedDay) =>
                    setState(() => _focusedDay = focusedDay),
                eventLoader: _getEventsForDay,
                calendarBuilders: CalendarBuilders(
                  markerBuilder: (context, date, events) {
                    if (events.isEmpty) return const SizedBox();
                    return Positioned(
                      bottom: 1,
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: events.take(4).map((e) {
                          Color c = brandGold;
                          if (e.runtimeType.toString().contains('Leave')) {
                            final status = (e as dynamic).status.stringValue;
                            c = status == 'approved'
                                ? brandMaroon
                                : (status == 'rejected'
                                    ? Colors.black
                                    : Colors.black38);
                          }
                          return Container(
                            margin: const EdgeInsets.symmetric(horizontal: 1),
                            width: 6,
                            height: 6,
                            decoration:
                                BoxDecoration(shape: BoxShape.circle, color: c),
                          );
                        }).toList(),
                      ),
                    );
                  },
                ),
              ),
            ),
            const SizedBox(height: 16),
            if (_isOwner && !_loading && _selectedDay != null)
              _buildAddRecordButton(l),
            if (_loading)
              const Center(
                  child: Padding(
                      padding: EdgeInsets.all(16.0),
                      child: CircularProgressIndicator()))
            else
              _buildEventList(selectedEvents, l),
          ],
        ),
      ),
    );
  }
}
