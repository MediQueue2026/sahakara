import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../../core/app_language.dart';
import '../../core/firebase_client.dart';
import '../../core/strings.dart';

/// Email + password sign in / sign up. No email verification — a new
/// account can use the app straight away.
class EmailLoginScreen extends StatefulWidget {
  final LanguageController lang;
  const EmailLoginScreen({super.key, required this.lang});

  @override
  State<EmailLoginScreen> createState() => _EmailLoginScreenState();
}

class _EmailLoginScreenState extends State<EmailLoginScreen> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmController = TextEditingController();
  bool _signUp = false;
  bool _busy = false;
  String? _error;

  // Lower-cased so it matches the address an owner typed when inviting a
  // maid (see AppData.addMaidByEmail).
  String get _email => _emailController.text.trim().toLowerCase();

  Future<void> _submit(AppLanguage lang) async {
    if (_signUp && _passwordController.text != _confirmController.text) {
      setState(() => _error = Strings.of('passwordsDontMatch', lang));
      return;
    }
    setState(() {
      _busy = true;
      _error = null;
    });
    try {
      if (_signUp) {
        await auth.createUserWithEmailAndPassword(
          email: _email,
          password: _passwordController.text,
        );
      } else {
        await auth.signInWithEmailAndPassword(
          email: _email,
          password: _passwordController.text,
        );
      }
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
                      TextField(
                        controller: _emailController,
                        keyboardType: TextInputType.emailAddress,
                        autocorrect: false,
                        decoration: InputDecoration(
                          labelText: Strings.of('email', lang),
                        ),
                      ),
                      const SizedBox(height: 12),
                      TextField(
                        controller: _passwordController,
                        obscureText: true,
                        decoration: InputDecoration(
                          labelText: Strings.of('password', lang),
                        ),
                        onSubmitted: _signUp ? null : (_) => _submit(lang),
                      ),
                      if (_signUp) ...[
                        const SizedBox(height: 12),
                        TextField(
                          controller: _confirmController,
                          obscureText: true,
                          decoration: InputDecoration(
                            labelText: Strings.of('confirmPassword', lang),
                          ),
                          onSubmitted: (_) => _submit(lang),
                        ),
                      ],
                      const SizedBox(height: 20),
                      FilledButton(
                        onPressed: _busy ? null : () => _submit(lang),
                        child: Text(
                          Strings.of(_signUp ? 'signUp' : 'signIn', lang),
                        ),
                      ),
                      const SizedBox(height: 8),
                      TextButton(
                        onPressed: _busy
                            ? null
                            : () => setState(() {
                                _signUp = !_signUp;
                                _error = null;
                              }),
                        child: Text(
                          Strings.of(
                            _signUp ? 'haveAccount' : 'noAccount',
                            lang,
                          ),
                        ),
                      ),
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
