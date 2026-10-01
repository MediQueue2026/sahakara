import 'package:flutter/material.dart';

import '../../core/app_data.dart';
import '../../core/app_language.dart';
import '../../core/strings.dart';
import '../../core/firebase_client.dart';
import '../../core/theme.dart';

class SettingsScreen extends StatelessWidget {
  final LanguageController lang;
  final Profile profile;

  const SettingsScreen({super.key, required this.lang, required this.profile});

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<AppLanguage>(
      valueListenable: lang,
      builder: (context, current, _) {
        return ListView(
          padding: const EdgeInsets.all(16),
          children: [
            Text(profile.name, style: Theme.of(context).textTheme.titleMedium),
            Text(profile.email, style: const TextStyle(color: mutedText)),
            const SizedBox(height: 24),
            Text(
              Strings.of('language', current),
              style: Theme.of(context).textTheme.titleSmall,
            ),
            const SizedBox(height: 8),
            Wrap(
              spacing: 8,
              children: AppLanguage.values
                  .map(
                    (l) => ChoiceChip(
                      label: Text(l.label),
                      selected: current == l,
                      onSelected: (_) {
                        lang.value = l;
                        AppData.setLanguage(l.name);
                      },
                    ),
                  )
                  .toList(),
            ),
            const SizedBox(height: 32),
            OutlinedButton.icon(
              onPressed: () => auth.signOut(),
              icon: const Icon(Icons.logout),
              label: Text(Strings.of('signOut', current)),
            ),
          ],
        );
      },
    );
  }
}
