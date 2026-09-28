import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../../core/app_data.dart';
import '../../core/app_language.dart';
import '../../core/firebase_client.dart';
import '../../core/strings.dart';
import '../../dataconnect_generated/sahakara.dart' show AccountType;

/// Email + password sign in / sign up, with separate front doors for house
/// owners and maids. No email verification — a new account can use the app
/// straight away.
class EmailLoginScreen extends StatefulWidget {
  final LanguageController lang;

  /// Called just before signing in or up, so the router that takes over
  /// once Firebase Auth reports the session knows which account type (and,
  /// on sign-up, which name) to save or expect.
  final ValueChanged<AuthIntent> onIntent;

  /// Opens straight on this account type's form, e.g. after a sign-in was
  /// rejected for using the wrong one.
  final AccountType? initialAccountType;

  /// A [Strings] key to show as an error when the screen opens.
  final String? initialErrorKey;

  const EmailLoginScreen({
    super.key,
    required this.lang,
    required this.onIntent,
    this.initialAccountType,
    this.initialErrorKey,
  });

  @override
  State<EmailLoginScreen> createState() => _EmailLoginScreenState();
}

class _EmailLoginScreenState extends State<EmailLoginScreen> {
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmController = TextEditingController();
  late AccountType? _accountType = widget.initialAccountType;
  bool _signUp = false;
  bool _busy = false;
  String? _error;

  @override
  void initState() {
    super.initState();
    final key = widget.initialErrorKey;
    if (key != null) _error = Strings.of(key, widget.lang.value);
  }

  // Lower-cased so it matches the address an owner typed when inviting a
  // maid (see AppData.addMaidByEmail).
  String get _email => _emailController.text.trim().toLowerCase();

  Future<void> _submit(AppLanguage lang) async {
    final name = _nameController.text.trim();
    if (_signUp && name.isEmpty) {
      setState(() => _error = Strings.of('nameRequired', lang));
      return;
    }
    if (_signUp && _passwordController.text != _confirmController.text) {
      setState(() => _error = Strings.of('passwordsDontMatch', lang));
      return;
    }
    setState(() {
      _busy = true;
      _error = null;
    });
    widget.onIntent(
      AuthIntent(accountType: _accountType!, name: _signUp ? name : null),
    );
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
      // On success, MobileApp's auth stream rebuilds into the router, which
      // saves the new user to the database.
    } on FirebaseAuthException catch (e) {
      if (mounted) setState(() => _error = e.message ?? e.code);
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
                      if (_accountType == null) ...[
                        AccountTypeChoice(
                          lang: lang,
                          onSelected: (type) => setState(() {
                            _accountType = type;
                            _error = null;
                          }),
                        ),
                        if (_error != null) ...[
                          const SizedBox(height: 16),
                          Text(
                            _error!,
                            style: const TextStyle(color: Colors.red),
                          ),
                        ],
                      ] else
                        ..._form(context, lang),
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

  List<Widget> _form(BuildContext context, AppLanguage lang) {
    return [
      Row(
        children: [
          IconButton(
            onPressed: _busy
                ? null
                : () => setState(() {
                    _accountType = null;
                    _error = null;
                  }),
            icon: const Icon(Icons.arrow_back),
          ),
          Expanded(
            child: Text(
              Strings.of(
                _accountType == AccountType.owner ? 'imOwner' : 'imMaid',
                lang,
              ),
              style: Theme.of(context).textTheme.titleMedium,
            ),
          ),
        ],
      ),
      const SizedBox(height: 12),
      if (_signUp) ...[
        TextField(
          controller: _nameController,
          textCapitalization: TextCapitalization.words,
          decoration: InputDecoration(labelText: Strings.of('name', lang)),
        ),
        const SizedBox(height: 12),
      ],
      TextField(
        controller: _emailController,
        keyboardType: TextInputType.emailAddress,
        autocorrect: false,
        decoration: InputDecoration(labelText: Strings.of('email', lang)),
      ),
      const SizedBox(height: 12),
      TextField(
        controller: _passwordController,
        obscureText: true,
        decoration: InputDecoration(labelText: Strings.of('password', lang)),
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
        child: Text(Strings.of(_signUp ? 'signUp' : 'signIn', lang)),
      ),
      const SizedBox(height: 8),
      TextButton(
        onPressed: _busy
            ? null
            : () => setState(() {
                _signUp = !_signUp;
                _error = null;
              }),
        child: Text(Strings.of(_signUp ? 'haveAccount' : 'noAccount', lang)),
      ),
      if (_error != null) ...[
        const SizedBox(height: 16),
        Text(_error!, style: const TextStyle(color: Colors.red)),
      ],
    ];
  }
}

/// The two front doors: "I'm a house owner" and "I'm a maid".
class AccountTypeChoice extends StatelessWidget {
  final AppLanguage lang;
  final ValueChanged<AccountType> onSelected;

  const AccountTypeChoice({
    super.key,
    required this.lang,
    required this.onSelected,
  });

  @override
  Widget build(BuildContext context) {
    Widget option(AccountType type, IconData icon, String title, String body) {
      return Card(
        child: ListTile(
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 16,
            vertical: 8,
          ),
          leading: Icon(icon, size: 32),
          title: Text(Strings.of(title, lang)),
          subtitle: Text(Strings.of(body, lang)),
          trailing: const Icon(Icons.chevron_right),
          onTap: () => onSelected(type),
        ),
      );
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        option(AccountType.owner, Icons.home_outlined, 'imOwner', 'ownerBlurb'),
        const SizedBox(height: 12),
        option(
          AccountType.maid,
          Icons.cleaning_services_outlined,
          'imMaid',
          'maidBlurb',
        ),
      ],
    );
  }
}
