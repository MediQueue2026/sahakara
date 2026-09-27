import 'package:flutter/material.dart';

import '../../core/app_data.dart';
import '../../core/app_language.dart';
import '../../core/strings.dart';
import '../../core/supabase_client.dart';

class SettingsScreen extends StatelessWidget {
  final LanguageController lang;
  final Map<String, dynamic> profile;

  const SettingsScreen({super.key, required this.lang, required this.profile});

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<AppLanguage>(
      valueListenable: lang,
      builder: (context, current, _) {
        return ListView(
          padding: const EdgeInsets.all(16),
          children: [
            Text(
              profile['name'] as String? ?? '',
              style: Theme.of(context).textTheme.titleMedium,
            ),
            Text(
              profile['phone'] as String? ?? '',
              style: const TextStyle(color: Colors.grey),
            ),
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
                        AppData.setLanguage(profile['id'] as String, l.name);
                      },
                    ),
                  )
                  .toList(),
            ),
            const SizedBox(height: 32),
            OutlinedButton.icon(
              onPressed: () => supabase.auth.signOut(),
              icon: const Icon(Icons.logout),
              label: Text(Strings.of('signOut', current)),
            ),
          ],
        );
      },
    );
  }
}
