import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../../core/app_language.dart';
import '../../core/firebase_client.dart';
import '../../core/strings.dart';
import '../../core/theme.dart';

/// Lets a signed-in owner or maid change their password. Firebase only
/// allows this after a recent sign-in, so the current password is checked
/// first by re-authenticating.
Future<void> showChangePasswordDialog(BuildContext context, AppLanguage lang) {
  return showDialog<void>(
    context: context,
    builder: (_) => _ChangePasswordDialog(lang: lang),
  );
}

class _ChangePasswordDialog extends StatefulWidget {
  final AppLanguage lang;

  const _ChangePasswordDialog({required this.lang});

  @override
  State<_ChangePasswordDialog> createState() => _ChangePasswordDialogState();
}

class _ChangePasswordDialogState extends State<_ChangePasswordDialog> {
  final _currentController = TextEditingController();
  final _newController = TextEditingController();
  final _confirmController = TextEditingController();
  bool _busy = false;
  String? _error;

  @override
  void dispose() {
    _currentController.dispose();
    _newController.dispose();
    _confirmController.dispose();
    super.dispose();
  }

  Future<void> _submit() async {
    final lang = widget.lang;
    if (_newController.text != _confirmController.text) {
      setState(() => _error = Strings.of('passwordsDontMatch', lang));
      return;
    }
    final user = auth.currentUser;
    final email = user?.email;
    if (user == null || email == null) return;
    setState(() {
      _busy = true;
      _error = null;
    });
    try {
      await user.reauthenticateWithCredential(
        EmailAuthProvider.credential(
          email: email,
          password: _currentController.text,
        ),
      );
      await user.updatePassword(_newController.text);
      if (!mounted) return;
      final messenger = ScaffoldMessenger.of(context);
      Navigator.of(context).pop();
      messenger.showSnackBar(
        SnackBar(content: Text(Strings.of('passwordChanged', lang))),
      );
    } on FirebaseAuthException catch (e) {
      final message = switch (e.code) {
        'wrong-password' ||
        'invalid-credential' =>
          Strings.of('wrongCurrentPassword', lang),
        _ => e.message ?? e.code,
      };
      if (mounted) setState(() => _error = message);
    } finally {
      if (mounted) setState(() => _busy = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final lang = widget.lang;
    return AlertDialog(
      title: Text(Strings.of('changePassword', lang)),
      content: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextField(
              controller: _currentController,
              obscureText: true,
              decoration: InputDecoration(
                labelText: Strings.of('currentPassword', lang),
              ),
            ),
            const SizedBox(height: 12),
            TextField(
              controller: _newController,
              obscureText: true,
              decoration: InputDecoration(
                labelText: Strings.of('newPassword', lang),
              ),
            ),
            const SizedBox(height: 12),
            TextField(
              controller: _confirmController,
              obscureText: true,
              decoration: InputDecoration(
                labelText: Strings.of('confirmPassword', lang),
              ),
              onSubmitted: _busy ? null : (_) => _submit(),
            ),
            if (_error != null) ...[
              const SizedBox(height: 16),
              Text(_error!, style: const TextStyle(color: brandMaroon)),
            ],
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: _busy ? null : () => Navigator.of(context).pop(),
          child: Text(Strings.of('cancel', lang)),
        ),
        FilledButton(
          onPressed: _busy ? null : _submit,
          child: Text(Strings.of('save', lang)),
        ),
      ],
    );
  }
}
