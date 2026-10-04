import 'package:flutter/material.dart';

import '../../core/app_data.dart';
import '../../core/app_language.dart';
import '../../core/strings.dart';
import '../contract/contract_detail_screen.dart';

/// Owner: ask a maid to join the household — her email address and the
/// contract being offered. She's sent it as a request and only becomes
/// staff once she accepts. Pops true once the request is sent.
class AddMaidScreen extends StatefulWidget {
  final LanguageController lang;
  final String householdId;

  const AddMaidScreen({
    super.key,
    required this.lang,
    required this.householdId,
  });

  @override
  State<AddMaidScreen> createState() => _AddMaidScreenState();
}

class _AddMaidScreenState extends State<AddMaidScreen> {
  final _emailController = TextEditingController();
  final _rateController = TextEditingController();
  final _allowanceController = TextEditingController();
  final _offDaysController = TextEditingController();
  final _hoursController = TextEditingController();
  String _payType = payTypes.first;
  bool _busy = false;
  String? _error;

  Future<void> _send(AppLanguage lang) async {
    final email = _emailController.text.trim();
    final rate = double.tryParse(_rateController.text.trim());
    if (email.isEmpty) {
      setState(() => _error = Strings.of('enterMaidEmail', lang));
      return;
    }
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
      await AppData.addMaidByEmail(
        householdId: widget.householdId,
        email: email,
        payType: _payType,
        rate: rate,
        allowance: allowance,
        offDays: emptyToNull(_offDaysController.text),
        workingHours: emptyToNull(_hoursController.text),
      );
      if (!mounted) return;
      await showSuccessDialog(
        context,
        Strings.of('requestSent', lang),
        lang,
        message: Strings.of('requestSentBody', lang),
      );
      if (mounted) Navigator.of(context).pop(true);
    } catch (e) {
      setState(() => _error = e.toString());
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
          appBar: AppBar(title: Text(Strings.of('addMaid', lang))),
          body: SingleChildScrollView(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                TextField(
                  controller: _emailController,
                  keyboardType: TextInputType.emailAddress,
                  autocorrect: false,
                  decoration: InputDecoration(
                    labelText: Strings.of('email', lang),
                  ),
                ),
                const SizedBox(height: 24),
                Text(
                  Strings.of('contract', lang),
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                const SizedBox(height: 4),
                Text(
                  Strings.of('contractSentAsRequest', lang),
                  style: Theme.of(context).textTheme.bodySmall,
                ),
                const SizedBox(height: 8),
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
                FilledButton.icon(
                  onPressed: _busy ? null : () => _send(lang),
                  icon: const Icon(Icons.send_outlined),
                  label: Text(Strings.of('sendRequest', lang)),
                ),
                if (_error != null) ...[
                  const SizedBox(height: 8),
                  Text(_error!, style: const TextStyle(color: Colors.red)),
                ],
              ],
            ),
          ),
        );
      },
    );
  }
}
