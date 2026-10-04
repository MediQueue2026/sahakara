import 'package:flutter/material.dart';

import '../../core/app_data.dart';
import '../../core/app_language.dart';
import '../../core/strings.dart';
import '../../core/theme.dart';

const payTypes = ['monthly', 'daily', 'hourly', 'per_visit'];

/// Owner: an editable form that saves a new contract (closing the old one).
/// Everyone else: a read-only view of the current contract.
class ContractDetailScreen extends StatefulWidget {
  final LanguageController lang;
  final String memberId;
  final String memberName;
  final bool editable;

  const ContractDetailScreen({
    super.key,
    required this.lang,
    required this.memberId,
    required this.memberName,
    required this.editable,
  });

  @override
  State<ContractDetailScreen> createState() => _ContractDetailScreenState();
}

class _ContractDetailScreenState extends State<ContractDetailScreen> {
  CurrentContract? _contract;
  bool _loading = true;
  bool _busy = false;
  String? _error;

  String _payType = payTypes.first;
  final _rateController = TextEditingController();
  final _allowanceController = TextEditingController();
  final _offDaysController = TextEditingController();
  final _hoursController = TextEditingController();

  @override
  void dispose() {
    _rateController.dispose();
    _allowanceController.dispose();
    _offDaysController.dispose();
    _hoursController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    _load();
  }

  Future<void> _load() async {
    if (!mounted) return;
    setState(() {
      _loading = true;
      _error = null;
    });
    try {
      final contract = await AppData.fetchCurrentContract(widget.memberId);
      if (!mounted) return;
      if (contract != null) {
        _payType = contract.payType.stringValue;
        _rateController.text = contract.rate.toString();
        _allowanceController.text = contract.allowance?.toString() ?? '';
        _offDaysController.text = contract.offDays ?? '';
        _hoursController.text = contract.workingHours ?? '';
      }
      setState(() {
        _contract = contract;
        _loading = false;
      });
    } catch (error) {
      if (!mounted) return;
      setState(() {
        _error = error.toString();
        _loading = false;
      });
    }
  }

  Future<void> _save(AppLanguage lang) async {
    final rate = double.tryParse(_rateController.text.trim());
    if (rate == null || rate <= 0) {
      setState(() => _error = Strings.of('enterValidAmount', lang));
      return;
    }
    final allowanceText = _allowanceController.text.trim();
    final allowance = double.tryParse(allowanceText);
    if (allowanceText.isNotEmpty && (allowance == null || allowance < 0)) {
      setState(() => _error = Strings.of('enterValidAllowance', lang));
      return;
    }
    setState(() {
      _busy = true;
      _error = null;
    });
    try {
      await AppData.saveContract(
        memberId: widget.memberId,
        payType: _payType,
        rate: rate,
        allowance: allowance,
        offDays: emptyToNull(_offDaysController.text),
        workingHours: emptyToNull(_hoursController.text),
      );
      await _load();
      if (mounted) {
        await showSuccessDialog(context, Strings.of('contractSaved', lang), lang);
      }
    } catch (e) {
      if (mounted) setState(() => _error = e.toString());
    } finally {
      if (mounted) setState(() => _busy = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<AppLanguage>(
      valueListenable: widget.lang,
      builder: (context, lang, _) {
        return Scaffold(
          appBar: AppBar(
            title: Text(widget.memberName),
            actions: [
              IconButton(
                tooltip: Strings.of('refresh', lang),
                onPressed: _loading ? null : _load,
                icon: const Icon(Icons.refresh),
              ),
            ],
          ),
          body: _loading
              ? const Center(child: CircularProgressIndicator())
              : SingleChildScrollView(
                  padding: const EdgeInsets.all(16),
                  child: _error != null
                      ? Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            Text(
                              Strings.of('contractLoadFailed', lang),
                              style: const TextStyle(color: Colors.red),
                            ),
                            const SizedBox(height: 8),
                            SelectableText(_error!),
                            const SizedBox(height: 16),
                            OutlinedButton.icon(
                              onPressed: _load,
                              icon: const Icon(Icons.refresh),
                              label: Text(Strings.of('retry', lang)),
                            ),
                          ],
                        )
                      : widget.editable
                      ? _buildForm(lang)
                      : _buildReadOnly(lang),
                ),
        );
      },
    );
  }

  Widget _buildReadOnly(AppLanguage lang) {
    if (_contract == null) {
      return Text(
        widget.editable
            ? Strings.of('noContract', lang)
            : Strings.of('contractMissingAskOwner', lang),
      );
    }
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _row(
          Strings.of('payType', lang),
          Strings.of('payType_${_contract!.payType.stringValue}', lang),
        ),
        _row(
          Strings.of('rate_${_contract!.payType.stringValue}', lang),
          '${_contract!.rate}',
        ),
        if (_contract!.allowance != null)
          _row(Strings.of('allowance', lang), '${_contract!.allowance}'),
        _row(Strings.of('offDays', lang), _contract!.offDays ?? '—'),
        _row(Strings.of('workingHours', lang), _contract!.workingHours ?? '—'),
      ],
    );
  }

  Widget _row(String label, String value) => Padding(
    padding: const EdgeInsets.symmetric(vertical: 6),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(label, style: const TextStyle(color: mutedText)),
        Text(value),
      ],
    ),
  );

  Widget _buildForm(AppLanguage lang) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        ContractFields(
          lang: lang,
          payType: _payType,
          onPayTypeChanged: (v) => setState(() => _payType = v),
          rateController: _rateController,
          allowanceController: _allowanceController,
          offDaysController: _offDaysController,
          hoursController: _hoursController,
        ),
        const SizedBox(height: 20),
        FilledButton(
          onPressed: _busy ? null : () => _save(lang),
          child: Text(Strings.of('saveContract', lang)),
        ),
        if (_error != null) ...[
          const SizedBox(height: 12),
          Text(_error!, style: const TextStyle(color: Colors.red)),
        ],
      ],
    );
  }
}

/// The contract terms an owner fills in: pay type, rate (required), and
/// optionally a fixed allowance, off days and working hours. Shared by this screen and adding a maid.
class ContractFields extends StatelessWidget {
  final AppLanguage lang;
  final String payType;
  final ValueChanged<String> onPayTypeChanged;
  final TextEditingController rateController;
  final TextEditingController allowanceController;
  final TextEditingController offDaysController;
  final TextEditingController hoursController;

  const ContractFields({
    super.key,
    required this.lang,
    required this.payType,
    required this.onPayTypeChanged,
    required this.rateController,
    required this.allowanceController,
    required this.offDaysController,
    required this.hoursController,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        DropdownButtonFormField<String>(
          initialValue: payType,
          decoration: InputDecoration(labelText: Strings.of('payType', lang)),
          items: payTypes
              .map(
                (t) => DropdownMenuItem(
                  value: t,
                  child: Text(Strings.of('payType_$t', lang)),
                ),
              )
              .toList(),
          onChanged: (v) => onPayTypeChanged(v!),
        ),
        const SizedBox(height: 12),
        TextField(
          controller: rateController,
          keyboardType: const TextInputType.numberWithOptions(decimal: true),
          decoration: InputDecoration(
            labelText: '${Strings.of('rate_$payType', lang)} *',
            helperText: Strings.of('required', lang),
          ),
        ),
        const SizedBox(height: 12),
        TextField(
          controller: allowanceController,
          keyboardType: const TextInputType.numberWithOptions(decimal: true),
          decoration: InputDecoration(
            labelText: Strings.of('allowance', lang),
            helperText: Strings.of('allowanceHint', lang),
          ),
        ),
        const SizedBox(height: 12),
        TextField(
          controller: offDaysController,
          decoration: InputDecoration(
            labelText: Strings.of('offDays', lang),
            helperText: Strings.of('optional', lang),
          ),
        ),
        const SizedBox(height: 12),
        TextField(
          controller: hoursController,
          decoration: InputDecoration(
            labelText: Strings.of('workingHours', lang),
            helperText: Strings.of('optional', lang),
          ),
        ),
      ],
    );
  }
}

/// [text] trimmed, or null when it's blank — for optional contract fields.
String? emptyToNull(String text) {
  final t = text.trim();
  return t.isEmpty ? null : t;
}

/// A pop-up confirming something saved, with [title] and an optional
/// [message]; completes once it's dismissed.
Future<void> showSuccessDialog(
  BuildContext context,
  String title,
  AppLanguage lang, {
  String? message,
}) {
  return showDialog<void>(
    context: context,
    builder: (context) => AlertDialog(
      icon: const Icon(Icons.check_circle, color: Colors.green, size: 48),
      title: Text(title, textAlign: TextAlign.center),
      content: message == null
          ? null
          : Text(message, textAlign: TextAlign.center),
      actions: [
        FilledButton(
          onPressed: () => Navigator.of(context).pop(),
          child: Text(Strings.of('ok', lang)),
        ),
      ],
    ),
  );
}
