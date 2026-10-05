import 'package:flutter/material.dart';

import '../../core/app_data.dart';
import '../../core/app_language.dart';
import '../../core/strings.dart';
import '../../core/firebase_client.dart';
import '../../core/theme.dart';
import 'change_password_dialog.dart';
import 'profile_section.dart';

class SettingsScreen extends StatefulWidget {
  final LanguageController lang;
  final Profile profile;

  const SettingsScreen({super.key, required this.lang, required this.profile});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  // The profile handed in was loaded at sign-in, so it misses edits made
  // here earlier; show it straight away, then swap in the saved one.
  late Profile _profile = widget.profile;
  Household? _household;
  bool _loaded = false;

  @override
  void initState() {
    super.initState();
    _reload();
  }

  Future<void> _reload() async {
    final fresh = await AppData.fetchMyProfile();
    // Owners also edit their house's location here.
    final membership = fresh?.accountType.stringValue == 'owner'
        ? await AppData.fetchMyMembership()
        : null;
    if (!mounted) return;
    setState(() {
      if (fresh != null) _profile = fresh;
      _household = membership?.role.stringValue == 'owner'
          ? membership!.household
          : null;
      _loaded = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    final lang = widget.lang;
    final profile = _profile;
    final isMaid = profile.accountType.stringValue == 'maid';
    return ValueListenableBuilder<AppLanguage>(
      valueListenable: lang,
      builder: (context, current, _) {
        return ListView(
          padding: const EdgeInsets.all(16),
          children: [
            Text(profile.name, style: Theme.of(context).textTheme.titleMedium),
            Text(profile.email, style: const TextStyle(color: mutedText)),
            const SizedBox(height: 24),
            if (_loaded)
              ProfileSection(
                // A new key after each save starts the form from what
                // was saved.
                key: ValueKey(profile),
                profile: profile,
                lang: current,
                showAreas: isMaid,
                household: _household,
                onSaved: _reload,
              )
            else
              const Center(child: CircularProgressIndicator()),
            const SizedBox(height: 24),
            Text(
              Strings.of('appLanguage', current),
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
              onPressed: () => showChangePasswordDialog(context, current),
              icon: const Icon(Icons.lock_outline),
              label: Text(Strings.of('changePassword', current)),
            ),
            const SizedBox(height: 12),
            OutlinedButton.icon(
              // Settings opens as a page over the home shell; close it so the
              // login screen isn't left hidden underneath.
              onPressed: () {
                Navigator.of(context).popUntil((route) => route.isFirst);
                auth.signOut();
              },
              icon: const Icon(Icons.logout),
              label: Text(Strings.of('signOut', current)),
            ),
          ],
        );
      },
    );
  }
}
