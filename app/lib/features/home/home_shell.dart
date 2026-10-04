import 'package:flutter/material.dart';

import '../../core/app_data.dart';
import '../../core/app_language.dart';
import '../../core/strings.dart';
import '../contract/contract_detail_screen.dart';
import '../contract/contract_screen.dart';
import '../settings/settings_screen.dart';
import '../tasks/daily_tasks_screen.dart';
import '../tasks/my_tasks_screen.dart';
import '../attendance/attendance_tab.dart';
import 'household_tab.dart';

/// Bottom-nav shell shown once a signed-in user has a household. The owner
/// and staff get different tabs:
/// - owner: Household (staff list, add a maid), Daily tasks (everyone's,
///   assign/add/remove), Contracts (each staff member's), Settings
/// - staff: My tasks (their own, report progress), My contract (read-only),
///   Settings
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
        final isOwner = widget.membership.role.stringValue == 'owner';
        final tabs = isOwner ? _ownerTabs(lang) : _staffTabs(lang);
        // The tab count differs by role, so keep the index in range.
        final index = _index < tabs.length ? _index : 0;

        return Scaffold(
          body: SafeArea(child: tabs[index].page),
          bottomNavigationBar: NavigationBar(
            selectedIndex: index,
            onDestinationSelected: (i) => setState(() => _index = i),
            destinations: [
              for (final t in tabs)
                NavigationDestination(icon: Icon(t.icon), label: t.label),
            ],
          ),
        );
      },
    );
  }

  List<_Tab> _ownerTabs(AppLanguage lang) => [
    _Tab(
      Icons.home_outlined,
      Strings.of('household', lang),
      HouseholdTab(lang: widget.lang, membership: widget.membership),
    ),
    _Tab(
      Icons.task_alt,
      Strings.of('dailyTasks', lang),
      DailyTasksScreen(lang: widget.lang, membership: widget.membership),
    ),
    _Tab(
      Icons.description_outlined,
      Strings.of('contract', lang),
      ContractScreen(lang: widget.lang, membership: widget.membership),
    ),
    _Tab(
      Icons.event_available,
      Strings.of('attendance', lang),
      AttendanceTab(lang: widget.lang, membership: widget.membership, profile: widget.profile),
    ),
    _Tab(
      Icons.settings_outlined,
      Strings.of('settings', lang),
      SettingsScreen(lang: widget.lang, profile: widget.profile),
    ),
  ];

  List<_Tab> _staffTabs(AppLanguage lang) => [
    _Tab(
      Icons.checklist,
      Strings.of('myTasks', lang),
      MyTasksScreen(
        lang: widget.lang,
        profile: widget.profile,
        membership: widget.membership,
      ),
    ),
    _Tab(
      Icons.description_outlined,
      Strings.of('myContract', lang),
      ContractDetailScreen(
        lang: widget.lang,
        memberId: widget.membership.id,
        memberName: widget.profile.name,
        editable: false,
      ),
    ),
    _Tab(
      Icons.event_available,
      Strings.of('attendance', lang),
      AttendanceTab(lang: widget.lang, membership: widget.membership, profile: widget.profile),
    ),
    _Tab(
      Icons.settings_outlined,
      Strings.of('settings', lang),
      SettingsScreen(lang: widget.lang, profile: widget.profile),
    ),
  ];
}

class _Tab {
  final IconData icon;
  final String label;
  final Widget page;

  const _Tab(this.icon, this.label, this.page);
}
