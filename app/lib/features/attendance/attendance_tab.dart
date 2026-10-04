import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';
import '../../core/app_data.dart';
import '../../core/app_language.dart';
import '../../core/strings.dart';
import 'leave_request_dialog.dart';
import '../../dataconnect_generated/sahakara.dart' hide AppLanguage;

class AttendanceTab extends StatefulWidget {
  final LanguageController lang;
  final Membership membership;
  final Profile profile;

  const AttendanceTab({
    super.key,
    required this.lang,
    required this.membership,
    required this.profile,
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
  bool _busy = false;
  bool _loading = true;

  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDay = DateTime.now();

  @override
  void initState() {
    super.initState();
    _refresh();
  }

  Future<void> _refresh() async {
    setState(() => _loading = true);
    try {
      if (_isOwner) {
        _attendance = await AppData.fetchHouseholdAttendance(_householdId);
        _leaveRequests = await AppData.fetchHouseholdLeaveRequests(_householdId);
      } else {
        _attendance = await AppData.fetchMyAttendance();
        _leaveRequests = await AppData.fetchMyLeaveRequests();
      }
    } catch (e) {
      if (mounted) ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(e.toString())));
    } finally {
      if (mounted) setState(() => _loading = false);
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
        dayType: 'full',
      );
      await _refresh();
    } catch (e) {
      if (mounted) ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(e.toString())));
    } finally {
      if (mounted) setState(() => _busy = false);
    }
  }

  Future<void> _checkOut() async {
    setState(() => _busy = true);
    try {
      final now = DateTime.now();
      final today = DateTime(now.year, now.month, now.day);
      await AppData.checkOut(
        memberId: _memberId,
        day: today,
      );
      await _refresh();
    } catch (e) {
      if (mounted) ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(e.toString())));
    } finally {
      if (mounted) setState(() => _busy = false);
    }
  }

  Future<void> _requestLeave() async {
    final result = await showDialog<bool>(
      context: context,
      builder: (context) => LeaveRequestDialog(memberId: _memberId, lang: widget.lang),
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
      if (mounted) ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(e.toString())));
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
      if (mounted) ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(e.toString())));
    } finally {
      if (mounted) setState(() => _busy = false);
    }
  }

  bool _isDayInLeave(DateTime day, dynamic req) {
    final from = DateTime(req.fromDate.year, req.fromDate.month, req.fromDate.day);
    final to = DateTime(req.toDate.year, req.toDate.month, req.toDate.day);
    final d = DateTime(day.year, day.month, day.day);
    return d.compareTo(from) >= 0 && d.compareTo(to) <= 0;
  }

  List<dynamic> _getEventsForDay(DateTime day) {
    final events = [];
    events.addAll(_attendance.where((a) => isSameDay(a.day, day)));
    events.addAll(_leaveRequests.where((l) => _isDayInLeave(day, l)));
    return events;
  }

  Widget _buildMaidActions(AppLanguage l) {
    return Card(
      margin: const EdgeInsets.only(bottom: 16),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Row(
              children: [
                Expanded(
                  child: FilledButton.icon(
                    onPressed: _busy ? null : _checkIn,
                    icon: const Icon(Icons.login),
                    label: Text(Strings.of('checkIn', widget.lang.value)),
                    style: FilledButton.styleFrom(backgroundColor: Colors.green),
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: FilledButton.icon(
                    onPressed: _busy ? null : _checkOut,
                    icon: const Icon(Icons.logout),
                    label: Text(Strings.of('checkOut', widget.lang.value)),
                    style: FilledButton.styleFrom(backgroundColor: Colors.orange),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            SizedBox(
              width: double.infinity,
              child: OutlinedButton.icon(
                onPressed: _busy ? null : _requestLeave,
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
        child: Text(Strings.of('noAttendanceRecords', widget.lang.value), textAlign: TextAlign.center),
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

          String title = '$leaveTypeTranslated: ${fromDate.year}-${fromDate.month}-${fromDate.day} to ${toDate.year}-${toDate.month}-${toDate.day}';
          if (_isOwner) {
            title = '${ev.member.user.name} - $title';
          }

          return Card(
            child: ListTile(
              title: Text(title),
              subtitle: Text('${Strings.of('status', l) ?? 'Status'}: $statusTranslated\n$reason'),
              isThreeLine: true,
              trailing: _isOwner && statusStr == 'pending'
                  ? Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(
                          icon: const Icon(Icons.check_circle, color: Colors.green),
                          onPressed: _busy ? null : () => _reviewLeave(id, 'approved'),
                        ),
                        IconButton(
                          icon: const Icon(Icons.cancel, color: Colors.red),
                          onPressed: _busy ? null : () => _reviewLeave(id, 'rejected'),
                        ),
                      ],
                    )
                  : (!_isOwner && statusStr == 'pending') ? IconButton(
                      icon: const Icon(Icons.delete_outline, color: Colors.red),
                      onPressed: _busy ? null : () => _cancelLeave(id),
                    ) : Icon(
                      statusStr == 'approved' ? Icons.check_circle : (statusStr == 'rejected' ? Icons.cancel : Icons.hourglass_empty),
                      color: statusStr == 'approved' ? Colors.green : (statusStr == 'rejected' ? Colors.red : Colors.grey),
                    ),
            ),
          );
        } else {
          final day = ev.day;
          final checkIn = ev.checkIn;
          final checkOut = ev.checkOut;
          final dayType = ev.dayType.stringValue;

          String title = '${day.year}-${day.month}-${day.day} ($dayType)';
          if (_isOwner) {
            title = '${ev.member.user.name} - $title';
          }

          String subtitle = '${Strings.of('checkIn', l)}: ${checkIn != null ? '${checkIn.toDateTime().toLocal().hour}:${checkIn.toDateTime().toLocal().minute.toString().padLeft(2, '0')}' : '...'}';
          if (checkOut != null) {
            subtitle += '\n${Strings.of('checkOut', l)}: ${checkOut.toDateTime().toLocal().hour}:${checkOut.toDateTime().toLocal().minute.toString().padLeft(2, '0')}';
          }

          return Card(
            child: ListTile(
              title: Text(title),
              subtitle: Text(subtitle),
              trailing: const Icon(Icons.access_time),
            ),
          );
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final l = widget.lang.value;
    final selectedEvents = _selectedDay != null ? _getEventsForDay(_selectedDay!) : [];

    return RefreshIndicator(
      onRefresh: () async => _refresh(),
      child: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          if (!_isOwner) _buildMaidActions(l),
          
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
              eventLoader: _getEventsForDay,
              calendarBuilders: CalendarBuilders(
                markerBuilder: (context, date, events) {
                  if (events.isEmpty) return const SizedBox();
                  return Positioned(
                    bottom: 1,
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: events.take(4).map((e) {
                        Color c = Colors.green;
                        if (e.runtimeType.toString().contains('Leave')) {
                           final status = (e as dynamic).status.stringValue;
                           c = status == 'approved' ? Colors.blue : (status == 'rejected' ? Colors.red : Colors.orange);
                        }
                        return Container(
                          margin: const EdgeInsets.symmetric(horizontal: 1),
                          width: 6, height: 6,
                          decoration: BoxDecoration(shape: BoxShape.circle, color: c),
                        );
                      }).toList(),
                    ),
                  );
                },
              ),
            ),
          ),
          
          const SizedBox(height: 16),
          
          if (_loading) 
             const Center(child: Padding(padding: EdgeInsets.all(16.0), child: CircularProgressIndicator()))
          else
             _buildEventList(selectedEvents, l),
        ],
      ),
    );
  }
}
