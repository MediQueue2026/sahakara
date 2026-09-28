import 'package:flutter/material.dart';

import '../../core/app_language.dart';
import '../../core/firebase_client.dart';
import '../../core/strings.dart';

/// Shown to a maid account with no household membership yet. Only an owner
/// can add her (by the email she signed up with), so there's nothing to do
/// here but wait and check again.
class WaitingForHouseholdScreen extends StatelessWidget {
  final LanguageController lang;
  final String email;
  final VoidCallback onRefresh;

  const WaitingForHouseholdScreen({
    super.key,
    required this.lang,
    required this.email,
    required this.onRefresh,
  });

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<AppLanguage>(
      valueListenable: lang,
      builder: (context, lang, _) {
        return Scaffold(
          body: SafeArea(
            child: Center(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(24),
                child: ConstrainedBox(
                  constraints: const BoxConstraints(maxWidth: 360),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Icon(Icons.hourglass_empty, size: 48),
                      const SizedBox(height: 16),
                      Text(
                        Strings.of('waitingForHousehold', lang),
                        textAlign: TextAlign.center,
                        style: Theme.of(context).textTheme.titleLarge,
                      ),
                      const SizedBox(height: 12),
                      Text(
                        Strings.of('waitingForHouseholdBody', lang),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 8),
                      Text(
                        email,
                        textAlign: TextAlign.center,
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 24),
                      FilledButton(
                        onPressed: onRefresh,
                        child: Text(Strings.of('checkAgain', lang)),
                      ),
                      const SizedBox(height: 8),
                      TextButton(
                        onPressed: () => auth.signOut(),
                        child: Text(Strings.of('signOut', lang)),
                      ),
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
