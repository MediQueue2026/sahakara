import 'package:flutter/material.dart';

import '../../core/app_data.dart';
import '../../core/app_language.dart';
import '../../core/strings.dart';
import '../../core/theme.dart';

const _payTypes = ['monthly', 'daily', 'hourly', 'per_visit'];

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

  String _payType = _payTypes.first;
  final _rateController = TextEditingController();
  final _offDaysController = TextEditingController();
  final _hoursController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _load();
  }

  Future<void> _load() async {
    final contract = await AppData.fetchCurrentContract(widget.memberId);
    if (contract != null) {
      _payType = contract.payType.stringValue;
      _rateController.text = contract.rate.toString();
      _offDaysController.text = contract.offDays ?? '';
      _hoursController.text = contract.workingHours ?? '';
    }
    setState(() {
      _contract = contract;
      _loading = false;
    });
  }

  Future<void> _save() async {
    final rate = double.tryParse(_rateController.text.trim());
    if (rate == null) {
      setState(() => _error = 'Enter a valid rate');
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
        offDays: _offDaysController.text.trim(),
        workingHours: _hoursController.text.trim(),
      );
      await _load();
    } catch (e) {
      setState(() => _error = e.toString());
    } finally {
      setState(() => _busy = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<AppLanguage>(
      valueListenable: widget.lang,
      builder: (context, lang, _) {
        return Scaffold(
          appBar: AppBar(title: Text(widget.memberName)),
          body: _loading
              ? const Center(child: CircularProgressIndicator())
              : SingleChildScrollView(
                  padding: const EdgeInsets.all(16),
                  child: widget.editable
                      ? _buildForm(lang)
                      : _buildReadOnly(lang),
                ),
        );
      },
    );
  }

  Widget _buildReadOnly(AppLanguage lang) {
    if (_contract == null) {
      return Text(Strings.of('noContract', lang));
    }
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _row(Strings.of('payType', lang), _contract!.payType.stringValue),
        _row(Strings.of('rate', lang), '${_contract!.rate}'),
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
        DropdownButtonFormField<String>(
          initialValue: _payType,
          decoration: InputDecoration(labelText: Strings.of('payType', lang)),
          items: _payTypes
              .map((t) => DropdownMenuItem(value: t, child: Text(t)))
              .toList(),
          onChanged: (v) => setState(() => _payType = v!),
        ),
        const SizedBox(height: 12),
        TextField(
          controller: _rateController,
          keyboardType: TextInputType.number,
          decoration: InputDecoration(labelText: Strings.of('rate', lang)),
        ),
        const SizedBox(height: 12),
        TextField(
          controller: _offDaysController,
          decoration: InputDecoration(labelText: Strings.of('offDays', lang)),
        ),
        const SizedBox(height: 12),
        TextField(
          controller: _hoursController,
          decoration: InputDecoration(
            labelText: Strings.of('workingHours', lang),
          ),
        ),
        const SizedBox(height: 20),
        FilledButton(
          onPressed: _busy ? null : _save,
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
