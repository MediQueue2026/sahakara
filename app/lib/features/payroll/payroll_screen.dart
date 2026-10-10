import 'package:flutter/material.dart';

import '../../core/app_data.dart';
import '../../core/app_language.dart';
import '../../core/strings.dart';
import '../../core/theme.dart';
import '../../dataconnect_generated/sahakara.dart' hide AppLanguage;

class PayrollScreen extends StatefulWidget {
  final LanguageController lang;
  final Membership membership;
  final bool readOnly;

  const PayrollScreen({
    super.key,
    required this.lang,
    required this.membership,
    this.readOnly = false,
  });

  @override
  State<PayrollScreen> createState() => _PayrollScreenState();
}

class _PayrollScreenState extends State<PayrollScreen> {
  bool get _isOwner => widget.membership.role.stringValue == 'owner';
  String get _householdId => widget.membership.household.id;
  String get _memberId => widget.membership.id;

  bool _loading = true;
  bool _busy = false;
  List<Member> _staff = [];
  List<HouseholdSalaryPayment> _householdPayments = [];
  List<MySalaryPayment> _myPayments = [];
  List<HouseholdAdvanceRequest> _householdAdvanceRequests = [];
  List<MyAdvanceRequest> _myAdvanceRequests = [];

  @override
  void initState() {
    super.initState();
    _refresh();
  }

  Future<void> _refresh() async {
    if (!mounted) return;
    setState(() => _loading = true);
    try {
      if (_isOwner) {
        final members = await AppData.fetchHouseholdMembers(_householdId);
        _staff = members
            .where(
              (member) =>
                  member.role.stringValue != 'owner' &&
                  member.active &&
                  member.status.stringValue == 'accepted',
            )
            .toList();
        _householdPayments = await AppData.fetchHouseholdSalaryPayments(
          _householdId,
        );
        _householdAdvanceRequests =
            await AppData.fetchHouseholdAdvanceRequests(_householdId);
      } else {
        _myPayments = await AppData.fetchMySalaryPayments();
        _myAdvanceRequests = await AppData.fetchMyAdvanceRequests();
      }
    } catch (error) {
      if (mounted) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text(error.toString())));
      }
    } finally {
      if (mounted) setState(() => _loading = false);
    }
  }

  Future<void> _schedulePayment() async {
    if (_staff.isEmpty) return;
    final result = await showDialog<_ScheduledPaymentInput>(
      context: context,
      builder: (context) => _SchedulePaymentDialog(
        lang: widget.lang,
        staff: _staff,
      ),
    );
    if (result == null) return;

    await _runBusy(() async {
      await AppData.scheduleSalaryPayment(
        memberId: result.memberId,
        amount: result.amount,
        paymentDate: result.paymentDate,
        note: result.note,
      );
      await _refresh();
    });
  }

  Future<void> _requestAdvance() async {
    final result = await showDialog<_AdvanceRequestInput>(
      context: context,
      builder: (context) => _RequestAdvanceDialog(lang: widget.lang),
    );
    if (result == null) return;

    await _runBusy(() async {
      await AppData.requestAdvance(
        memberId: _memberId,
        amount: result.amount,
        reason: result.reason,
      );
      await _refresh();
    });
  }

  Future<void> _markPaymentPaid(HouseholdSalaryPayment payment) async {
    final method = await showDialog<String>(
      context: context,
      builder: (context) => _PaymentMethodDialog(lang: widget.lang),
    );
    if (method == null) return;

    await _runBusy(() async {
      await AppData.markSalaryPaymentPaid(
        id: payment.id,
        paymentDate: payment.paymentDate,
        method: method,
      );
      await _refresh();
    });
  }

  Future<void> _reviewAdvance(
    HouseholdAdvanceRequest request,
    String status,
  ) async {
    final approved = status == 'approved';
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(
          Strings.of(approved ? 'approve' : 'reject', widget.lang.value),
        ),
        content: Text(
          Strings.of(
            approved ? 'confirmApproveAdvance' : 'confirmRejectAdvance',
            widget.lang.value,
          ).replaceFirst(
            '{amount}',
            'LKR ${request.amount.toStringAsFixed(2)}',
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: Text(Strings.of('cancel', widget.lang.value)),
          ),
          FilledButton(
            onPressed: () => Navigator.pop(context, true),
            child: Text(
              Strings.of(approved ? 'approve' : 'reject', widget.lang.value),
            ),
          ),
        ],
      ),
    );
    if (confirmed != true) return;
    await _runBusy(() async {
      await AppData.reviewAdvanceRequest(id: request.id, status: status);
      await _refresh();
    });
  }

  Future<void> _runBusy(Future<void> Function() action) async {
    setState(() => _busy = true);
    try {
      await action();
    } catch (error) {
      if (mounted) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text(error.toString())));
      }
    } finally {
      if (mounted) setState(() => _busy = false);
    }
  }

  bool _isSameDate(DateTime a, DateTime b) =>
      a.year == b.year && a.month == b.month && a.day == b.day;

  String _formatDate(DateTime date) =>
      '${date.year}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}';

  String _formatAmount(double amount) => 'LKR ${amount.toStringAsFixed(2)}';

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<AppLanguage>(
      valueListenable: widget.lang,
      builder: (context, language, _) => Scaffold(
        body: RefreshIndicator(
          onRefresh: _refresh,
          child: _loading
              ? ListView(
                  physics: const AlwaysScrollableScrollPhysics(),
                  children: const [
                    SizedBox(
                      height: 300,
                      child: Center(child: CircularProgressIndicator()),
                    ),
                  ],
                )
              : ListView(
                  physics: const AlwaysScrollableScrollPhysics(),
                  padding: const EdgeInsets.all(16),
                  children: [
                    if (_isOwner) ..._buildOwnerContent(language),
                    if (!_isOwner) ..._buildStaffContent(language),
                  ],
                ),
        ),
      ),
    );
  }

  List<Widget> _buildOwnerContent(AppLanguage language) {
    final now = DateTime.now();
    final tomorrow = DateTime(now.year, now.month, now.day + 1);
    final dueTomorrow = _householdPayments.where(
      (payment) =>
          payment.status.stringValue == 'scheduled' &&
          _isSameDate(payment.paymentDate, tomorrow),
    );

    return [
      if (dueTomorrow.isNotEmpty)
        Card(
          color: Theme.of(context).colorScheme.tertiaryContainer,
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  Strings.of('paymentDueTomorrow', language),
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                for (final payment in dueTomorrow)
                  Padding(
                    padding: const EdgeInsets.only(top: 8),
                    child: Text(
                      '${payment.member.user.name} · ${_formatAmount(payment.amount)}',
                    ),
                  ),
              ],
            ),
          ),
        ),
      Align(
        alignment: Alignment.centerRight,
        child: FilledButton.icon(
          onPressed: _busy || _staff.isEmpty ? null : _schedulePayment,
          icon: const Icon(Icons.event_available),
          label: Text(Strings.of('addPaymentDate', language)),
        ),
      ),
      const SizedBox(height: 8),
      _sectionTitle(Strings.of('scheduledPayments', language)),
      if (_householdPayments.isEmpty)
        _empty(Strings.of('noPayments', language))
      else
        for (final payment in _householdPayments)
          _householdPaymentTile(payment, language),
      const SizedBox(height: 16),
      _sectionTitle(Strings.of('advanceRequests', language)),
      if (_householdAdvanceRequests.isEmpty)
        _empty(Strings.of('noAdvanceRequests', language))
      else
        for (final request in _householdAdvanceRequests)
          _householdAdvanceTile(request, language),
    ];
  }

  List<Widget> _buildStaffContent(AppLanguage language) => [
        Align(
          alignment: Alignment.centerRight,
          child: FilledButton.icon(
            onPressed: _busy || widget.readOnly ? null : _requestAdvance,
            icon: const Icon(Icons.payments_outlined),
            label: Text(Strings.of('requestAdvance', language)),
          ),
        ),
        const SizedBox(height: 8),
        _sectionTitle(Strings.of('salaryPayments', language)),
        if (_myPayments.isEmpty)
          _empty(Strings.of('noPayments', language))
        else
          for (final payment in _myPayments) _myPaymentTile(payment, language),
        const SizedBox(height: 16),
        _sectionTitle(Strings.of('advanceRequests', language)),
        if (_myAdvanceRequests.isEmpty)
          _empty(Strings.of('noAdvanceRequests', language))
        else
          for (final request in _myAdvanceRequests)
            _myAdvanceTile(request, language),
      ];

  Widget _sectionTitle(String title) => Padding(
        padding: const EdgeInsets.symmetric(vertical: 8),
        child: Text(title, style: Theme.of(context).textTheme.titleLarge),
      );

  Widget _empty(String message) => Card(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Text(message, textAlign: TextAlign.center),
        ),
      );

  Widget _householdPaymentTile(
    HouseholdSalaryPayment payment,
    AppLanguage language,
  ) {
    final scheduled = payment.status.stringValue == 'scheduled';
    return Card(
      child: ListTile(
        title: Text(payment.member.user.name),
        subtitle: Text(
          '${_formatAmount(payment.amount)} · ${_formatDate(payment.paymentDate)}'
          '${payment.note == null ? '' : '\n${payment.note}'}\n'
          '${Strings.of('paymentStatus_${payment.status.stringValue}', language)}',
        ),
        isThreeLine: true,
        trailing: scheduled
            ? IconButton(
                tooltip: Strings.of('markPaid', language),
                onPressed: _busy ? null : () => _markPaymentPaid(payment),
                icon: const Icon(Icons.check_circle_outline),
              )
            : const Icon(Icons.check_circle, color: brandGold),
      ),
    );
  }

  Widget _myPaymentTile(MySalaryPayment payment, AppLanguage language) => Card(
        child: ListTile(
          leading: const Icon(Icons.payments_outlined),
          title: Text(_formatAmount(payment.amount)),
          subtitle: Text(
            '${_formatDate(payment.paymentDate)} · '
            '${Strings.of('paymentStatus_${payment.status.stringValue}', language)}'
            '${payment.note == null ? '' : '\n${payment.note}'}',
          ),
          isThreeLine: payment.note != null,
        ),
      );

  Widget _householdAdvanceTile(
    HouseholdAdvanceRequest request,
    AppLanguage language,
  ) {
    final pending = request.status.stringValue == 'pending';
    return Card(
      child: ListTile(
        title: Text(
          '${request.member.user.name} · ${_formatAmount(request.amount)}',
        ),
        subtitle: Text(
          '${Strings.of('advanceStatus_${request.status.stringValue}', language)}'
          '${request.reason == null ? '' : '\n${request.reason}'}',
        ),
        isThreeLine: request.reason != null,
        trailing: pending
            ? Wrap(
                children: [
                  IconButton(
                    tooltip: Strings.of('approve', language),
                    onPressed: _busy
                        ? null
                        : () => _reviewAdvance(request, 'approved'),
                    icon: const Icon(Icons.check_circle, color: brandGold),
                  ),
                  IconButton(
                    tooltip: Strings.of('reject', language),
                    onPressed: _busy
                        ? null
                        : () => _reviewAdvance(request, 'rejected'),
                    icon: const Icon(Icons.cancel_outlined, color: brandMaroon),
                  ),
                ],
              )
            : null,
      ),
    );
  }

  Widget _myAdvanceTile(MyAdvanceRequest request, AppLanguage language) => Card(
        child: ListTile(
          leading: const Icon(Icons.request_quote_outlined),
          title: Text(
            '${_formatAmount(request.amount)} · '
            '${Strings.of('advanceStatus_${request.status.stringValue}', language)}',
          ),
          subtitle: request.reason == null ? null : Text(request.reason!),
        ),
      );
}

class _ScheduledPaymentInput {
  final String memberId;
  final double amount;
  final DateTime paymentDate;
  final String? note;

  const _ScheduledPaymentInput({
    required this.memberId,
    required this.amount,
    required this.paymentDate,
    this.note,
  });
}

class _AdvanceRequestInput {
  final double amount;
  final String? reason;

  const _AdvanceRequestInput({required this.amount, this.reason});
}

class _SchedulePaymentDialog extends StatefulWidget {
  final LanguageController lang;
  final List<Member> staff;

  const _SchedulePaymentDialog({required this.lang, required this.staff});

  @override
  State<_SchedulePaymentDialog> createState() => _SchedulePaymentDialogState();
}

class _SchedulePaymentDialogState extends State<_SchedulePaymentDialog> {
  final _amountController = TextEditingController();
  final _noteController = TextEditingController();
  late String _memberId = widget.staff.first.id;
  DateTime? _paymentDate;
  String? _error;
  bool _busy = false;

  @override
  void dispose() {
    _amountController.dispose();
    _noteController.dispose();
    super.dispose();
  }

  Future<void> _selectDate() async {
    final now = DateTime.now();
    final selected = await showDatePicker(
      context: context,
      initialDate: _paymentDate ?? now,
      firstDate: DateTime(2000),
      lastDate: DateTime(now.year + 10),
    );
    if (selected != null) setState(() => _paymentDate = selected);
  }

  void _submit() {
    final amount = double.tryParse(_amountController.text.trim());
    if (amount == null || amount <= 0 || _paymentDate == null) {
      setState(
        () => _error = Strings.of(
          amount == null || amount <= 0 ? 'enterValidAmount' : 'paymentDate',
          widget.lang.value,
        ),
      );
      return;
    }
    setState(() => _busy = true);
    Navigator.pop(
      context,
      _ScheduledPaymentInput(
        memberId: _memberId,
        amount: amount,
        paymentDate: _paymentDate!,
        note: _noteController.text.trim().isEmpty
            ? null
            : _noteController.text.trim(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final language = widget.lang.value;
    return AlertDialog(
      title: Text(Strings.of('addPaymentDate', language)),
      content: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            DropdownButtonFormField<String>(
              initialValue: _memberId,
              decoration: InputDecoration(
                labelText: Strings.of('selectStaff', language),
              ),
              items: widget.staff
                  .map(
                    (member) => DropdownMenuItem(
                      value: member.id,
                      child: Text(member.user.name),
                    ),
                  )
                  .toList(),
              onChanged: (value) {
                if (value != null) setState(() => _memberId = value);
              },
            ),
            const SizedBox(height: 12),
            TextField(
              controller: _amountController,
              keyboardType: const TextInputType.numberWithOptions(
                decimal: true,
              ),
              decoration: InputDecoration(
                labelText: Strings.of('amount', language),
              ),
            ),
            const SizedBox(height: 12),
            SizedBox(
              width: double.infinity,
              child: OutlinedButton.icon(
                onPressed: _selectDate,
                icon: const Icon(Icons.calendar_month),
                label: Text(
                  _paymentDate == null
                      ? Strings.of('paymentDate', language)
                      : _dateText(_paymentDate!),
                ),
              ),
            ),
            const SizedBox(height: 12),
            TextField(
              controller: _noteController,
              decoration: InputDecoration(
                labelText: Strings.of('noteOptional', language),
              ),
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
        TextButton(
          onPressed: _busy ? null : () => Navigator.pop(context),
          child: Text(Strings.of('cancel', language)),
        ),
        FilledButton(
          onPressed: _busy ? null : _submit,
          child: Text(Strings.of('save', language)),
        ),
      ],
    );
  }
}

class _RequestAdvanceDialog extends StatefulWidget {
  final LanguageController lang;

  const _RequestAdvanceDialog({required this.lang});

  @override
  State<_RequestAdvanceDialog> createState() => _RequestAdvanceDialogState();
}

class _RequestAdvanceDialogState extends State<_RequestAdvanceDialog> {
  final _amountController = TextEditingController();
  final _reasonController = TextEditingController();
  String? _error;
  bool _busy = false;

  @override
  void dispose() {
    _amountController.dispose();
    _reasonController.dispose();
    super.dispose();
  }

  void _submit() {
    final amount = double.tryParse(_amountController.text.trim());
    if (amount == null || amount <= 0) {
      setState(
          () => _error = Strings.of('enterValidAmount', widget.lang.value));
      return;
    }
    setState(() => _busy = true);
    Navigator.pop(
      context,
      _AdvanceRequestInput(
        amount: amount,
        reason: _reasonController.text.trim().isEmpty
            ? null
            : _reasonController.text.trim(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final language = widget.lang.value;
    return AlertDialog(
      title: Text(Strings.of('requestAdvance', language)),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          TextField(
            controller: _amountController,
            keyboardType: const TextInputType.numberWithOptions(decimal: true),
            decoration:
                InputDecoration(labelText: Strings.of('amount', language)),
          ),
          const SizedBox(height: 12),
          TextField(
            controller: _reasonController,
            decoration: InputDecoration(
              labelText: Strings.of('reasonOptional', language),
            ),
            maxLines: 3,
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
      actions: [
        TextButton(
          onPressed: _busy ? null : () => Navigator.pop(context),
          child: Text(Strings.of('cancel', language)),
        ),
        FilledButton(
          onPressed: _busy ? null : _submit,
          child: Text(Strings.of('submit', language)),
        ),
      ],
    );
  }
}

class _PaymentMethodDialog extends StatefulWidget {
  final LanguageController lang;

  const _PaymentMethodDialog({required this.lang});

  @override
  State<_PaymentMethodDialog> createState() => _PaymentMethodDialogState();
}

class _PaymentMethodDialogState extends State<_PaymentMethodDialog> {
  String _method = 'cash';

  @override
  Widget build(BuildContext context) {
    final language = widget.lang.value;
    return AlertDialog(
      title: Text(Strings.of('paymentMethod', language)),
      content: DropdownButtonFormField<String>(
        initialValue: _method,
        items: PaymentMethod.values
            .map(
              (method) => DropdownMenuItem(
                value: method.name,
                child: Text(Strings.of('method_${method.name}', language)),
              ),
            )
            .toList(),
        onChanged: (value) {
          if (value != null) setState(() => _method = value);
        },
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: Text(Strings.of('cancel', language)),
        ),
        FilledButton(
          onPressed: () => Navigator.pop(context, _method),
          child: Text(Strings.of('markPaid', language)),
        ),
      ],
    );
  }
}

String _dateText(DateTime date) =>
    '${date.year}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}';
