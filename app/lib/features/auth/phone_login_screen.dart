import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../../core/app_language.dart';
import '../../core/firebase_client.dart';
import '../../core/strings.dart';

class PhoneLoginScreen extends StatefulWidget {
  final LanguageController lang;
  const PhoneLoginScreen({super.key, required this.lang});

  @override
  State<PhoneLoginScreen> createState() => _PhoneLoginScreenState();
}

class _PhoneLoginScreenState extends State<PhoneLoginScreen> {
  final _phoneController = TextEditingController(text: '+94');
  final _codeController = TextEditingController();
  String? _verificationId;
  bool _codeSent = false;
  bool _busy = false;
  String? _error;

  String get _phone => _phoneController.text.trim();

  Future<void> _sendCode() async {
    setState(() {
      _busy = true;
      _error = null;
    });
    await auth.verifyPhoneNumber(
      phoneNumber: _phone,
      // Android can read the SMS itself and sign in without the code being
      // typed; MobileApp's auth stream then rebuilds into the home shell.
      verificationCompleted: auth.signInWithCredential,
      verificationFailed: (e) => setState(() {
        _error = e.message ?? e.code;
        _busy = false;
      }),
      codeSent: (verificationId, _) => setState(() {
        _verificationId = verificationId;
        _codeSent = true;
        _busy = false;
      }),
      codeAutoRetrievalTimeout: (_) {},
    );
  }

  Future<void> _verifyCode() async {
    setState(() {
      _busy = true;
      _error = null;
    });
    try {
      await auth.signInWithCredential(
        PhoneAuthProvider.credential(
          verificationId: _verificationId!,
          smsCode: _codeController.text.trim(),
        ),
      );
      // On success, MobileApp's auth stream rebuilds into the home shell.
    } on FirebaseAuthException catch (e) {
      setState(() => _error = e.message ?? e.code);
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
