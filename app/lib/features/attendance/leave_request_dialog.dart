import 'package:flutter/material.dart';
import '../../core/app_data.dart';
import '../../core/app_language.dart';
import '../../core/strings.dart';
import '../../dataconnect_generated/sahakara.dart' hide AppLanguage;

class LeaveRequestDialog extends StatefulWidget {
  final String memberId;
  final LanguageController lang;

  const LeaveRequestDialog({
    super.key,
    required this.memberId,
    required this.lang,
  });

  @override
  State<LeaveRequestDialog> createState() => _LeaveRequestDialogState();
}

class _LeaveRequestDialogState extends State<LeaveRequestDialog> {
  DateTime? _fromDate;
  DateTime? _toDate;
  LeaveType _leaveType = LeaveType.paid;
  final _reasonController = TextEditingController();
  bool _busy = false;
  bool _isHalfDay = false;

  @override
  void dispose() {
    _reasonController.dispose();
    super.dispose();
  }

  Future<void> _submit() async {
    if (_fromDate == null || _toDate == null) return;
    setState(() => _busy = true);
    try {
      await AppData.submitLeaveRequest(
        memberId: widget.memberId,
        fromDate: _fromDate!,
        toDate: _toDate!,
        leaveType: _leaveType.name,
        isHalfDay: _isHalfDay,
        reason: _reasonController.text.trim().isEmpty ? null : _reasonController.text.trim(),
      );
      if (mounted) {
        Navigator.of(context).pop(true);
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(e.toString())));
      }
    } finally {
      if (mounted) setState(() => _busy = false);
    }
  }

  Future<void> _selectDate(bool isFrom) async {
    final date = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now().subtract(const Duration(days: 30)),
      lastDate: DateTime.now().add(const Duration(days: 365)),
    );
    if (date != null) {
      setState(() {
        if (isFrom) {
          _fromDate = date;
          if (_isHalfDay || _toDate == null || _toDate!.isBefore(_fromDate!)) {
            _toDate = _fromDate;
          }
        } else {
          _toDate = date;
          if (_fromDate == null || _fromDate!.isAfter(_toDate!)) {
            _fromDate = _toDate;
          }
        }
        if (_isHalfDay && _fromDate != null) _toDate = _fromDate;
      });
    }
  }

  String _getLeaveTypeName(LeaveType type) {
    switch (type) {
      case LeaveType.paid:
        return Strings.of('leave_paid', widget.lang.value);
      case LeaveType.unpaid:
        return Strings.of('leave_unpaid', widget.lang.value);
      case LeaveType.sick:
        return Strings.of('leave_sick', widget.lang.value);
    }
  }

  @override
  Widget build(BuildContext context) {
    final l = widget.lang.value;
    return AlertDialog(
      title: Text(Strings.of('requestLeave', l)),
      content: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            if (_isHalfDay)
              OutlinedButton(
                onPressed: () => _selectDate(true),
                child: Text(
                  _fromDate == null
                      ? Strings.of('startDate', l)
                      : '${_fromDate!.year}-${_fromDate!.month}-${_fromDate!.day}',
                ),
              )
            else
              Row(
                children: [
                  Expanded(
                    child: OutlinedButton(
                      onPressed: () => _selectDate(true),
                      child: Text(
                        _fromDate == null
                            ? Strings.of('startDate', l)
                            : '${_fromDate!.year}-${_fromDate!.month}-${_fromDate!.day}',
                      ),
                    ),
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: OutlinedButton(
                      onPressed: () => _selectDate(false),
                      child: Text(
                        _toDate == null
                            ? Strings.of('endDate', l)
                            : '${_toDate!.year}-${_toDate!.month}-${_toDate!.day}',
                      ),
                    ),
                  ),
                ],
              ),
            SwitchListTile(
              contentPadding: EdgeInsets.zero,
              title: Text(Strings.of('halfDay', l)),
              value: _isHalfDay,
              onChanged: (value) => setState(() {
                _isHalfDay = value;
                if (value && _fromDate != null) _toDate = _fromDate;
              }),
            ),
            const SizedBox(height: 16),
            DropdownButtonFormField<LeaveType>(
              initialValue: _leaveType,
              decoration: InputDecoration(labelText: Strings.of('leaveType', l), border: const OutlineInputBorder()),
              items: LeaveType.values.map((type) {
                return DropdownMenuItem(
                  value: type,
                  child: Text(_getLeaveTypeName(type)),
                );
              }).toList(),
              onChanged: (val) {
                if (val != null) setState(() => _leaveType = val);
              },
            ),
            const SizedBox(height: 16),
            TextField(
              controller: _reasonController,
              decoration: InputDecoration(labelText: Strings.of('reasonOptional', l), border: const OutlineInputBorder()),
              maxLines: 3,
            ),
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: _busy ? null : () => Navigator.of(context).pop(),
          child: Text(Strings.of('cancel', l)),
        ),
        FilledButton(
          onPressed: _busy || _fromDate == null || _toDate == null ? null : _submit,
          child: _busy ? const SizedBox(width: 20, height: 20, child: CircularProgressIndicator(color: Colors.white, strokeWidth: 2)) : Text(Strings.of('submit', l)),
        ),
      ],
    );
  }
}
