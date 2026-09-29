import 'package:flutter/material.dart';

import '../../core/app_data.dart';
import '../../core/app_language.dart';
import '../../core/strings.dart';
import '../contract/contract_screen.dart';
import '../settings/settings_screen.dart';
import '../tasks/daily_tasks_screen.dart';
import '../tasks/task_library_screen.dart';
import 'household_tab.dart';

/// Bottom-nav shell shown once a signed-in user has a household. The same
/// five tabs serve every role (owner/adult/maid/driver/cook/gardener) —
/// each tab decides internally what to show for the current role.
class HomeShell extends StatefulWidget {
  final LanguageController lang;
  final Profile profile;
  final Membership membership;

  const HomeShell({
    super.key,
    required this.lang,
    required this.profile,
    required this.membership,
  });

  @override
  State<HomeShell> createState() => _HomeShellState();
}

class _HomeShellState extends State<HomeShell> {
  int _index = 0;

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<AppLanguage>(
      valueListenable: widget.lang,
      builder: (context, lang, _) {
        final pages = [
          HouseholdTab(
            lang: widget.lang,
            profile: widget.profile,
            membership: widget.membership,
          ),
          DailyTasksScreen(
            lang: widget.lang,
            profile: widget.profile,
            membership: widget.membership,
          ),
          ContractScreen(
            lang: widget.lang,
            profile: widget.profile,
            membership: widget.membership,
          ),
          TaskLibraryScreen(lang: widget.lang),
          SettingsScreen(lang: widget.lang, profile: widget.profile),
        ];

        return Scaffold(
          body: SafeArea(child: pages[_index]),
          bottomNavigationBar: NavigationBar(
            selectedIndex: _index,
            onDestinationSelected: (i) => setState(() => _index = i),
            destinations: [
              NavigationDestination(
                icon: const Icon(Icons.home_outlined),
                label: Strings.of('household', lang),
              ),
              NavigationDestination(
                icon: const Icon(Icons.task_alt),
                label: Strings.of('dailyTasks', lang),
              ),
              NavigationDestination(
                icon: const Icon(Icons.description_outlined),
                label: Strings.of('contract', lang),
              ),
              NavigationDestination(
                icon: const Icon(Icons.menu_book_outlined),
                label: Strings.of('tasks', lang),
              ),
              NavigationDestination(
                icon: const Icon(Icons.settings_outlined),
                label: Strings.of('settings', lang),
              ),
            ],
          ),
        );
      },
    );
  }
}
