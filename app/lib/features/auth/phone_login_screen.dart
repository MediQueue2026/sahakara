import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../../core/app_language.dart';
import '../../core/strings.dart';
import '../../core/supabase_client.dart';

class PhoneLoginScreen extends StatefulWidget {
  final LanguageController lang;
  const PhoneLoginScreen({super.key, required this.lang});

  @override
  State<PhoneLoginScreen> createState() => _PhoneLoginScreenState();
}

class _PhoneLoginScreenState extends State<PhoneLoginScreen> {
  final _phoneController = TextEditingController(text: '+94');
  final _codeController = TextEditingController();
  bool _codeSent = false;
  bool _busy = false;
  String? _error;

  String get _phone => _phoneController.text.trim();

  Future<void> _sendCode() async {
    setState(() {
      _busy = true;
      _error = null;
    });
    try {
      await supabase.auth.signInWithOtp(phone: _phone);
      setState(() => _codeSent = true);
    } catch (e) {
      setState(() => _error = e.toString());
    } finally {
      setState(() => _busy = false);
    }
  }

  Future<void> _verifyCode() async {
    setState(() {
      _busy = true;
      _error = null;
    });
    try {
      await supabase.auth.verifyOTP(
        phone: _phone,
        token: _codeController.text.trim(),
        type: OtpType.sms,
      );
      // On success, MobileApp's auth stream rebuilds into the home shell.
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
          body: SafeArea(
            child: Center(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(24),
                child: ConstrainedBox(
                  constraints: const BoxConstraints(maxWidth: 360),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Text(
                        Strings.of('appName', lang),
                        textAlign: TextAlign.center,
                        style: Theme.of(context).textTheme.headlineMedium,
                      ),
                      const SizedBox(height: 24),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: AppLanguage.values
                            .map(
                              (l) => Padding(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 4,
                                ),
                                child: ChoiceChip(
                                  label: Text(l.short),
                                  selected: lang == l,
                                  onSelected: (_) => widget.lang.value = l,
                                ),
                              ),
                            )
                            .toList(),
                      ),
                      const SizedBox(height: 32),
                      if (!_codeSent) ...[
                        TextField(
                          controller: _phoneController,
                          keyboardType: TextInputType.phone,
                          decoration: InputDecoration(
                            labelText: Strings.of('phoneNumber', lang),
                          ),
                        ),
                        const SizedBox(height: 16),
                        FilledButton(
                          onPressed: _busy ? null : _sendCode,
                          child: Text(Strings.of('sendCode', lang)),
                        ),
                      ] else ...[
                        Text(Strings.of('enterCode', lang)),
                        const SizedBox(height: 8),
                        TextField(
                          controller: _codeController,
                          keyboardType: TextInputType.number,
                          textAlign: TextAlign.center,
                          decoration: const InputDecoration(
                            labelText: '••••••',
                          ),
                        ),
                        const SizedBox(height: 16),
                        FilledButton(
                          onPressed: _busy ? null : _verifyCode,
                          child: Text(Strings.of('verify', lang)),
                        ),
                      ],
                      if (_error != null) ...[
                        const SizedBox(height: 16),
                        Text(
                          _error!,
                          style: const TextStyle(color: Colors.red),
                        ),
                      ],
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
