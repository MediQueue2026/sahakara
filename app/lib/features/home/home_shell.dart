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
import '../onboarding/waiting_for_household_screen.dart';
import '../payroll/payroll_screen.dart';
import 'household_tab.dart';

/// Bottom-nav shell shown once a signed-in user has a household. The owner
/// and staff get different tabs:
/// - owner: Household, Daily tasks, Contracts, Attendance, Pay and Settings
/// - staff: My tasks, My contract, Join requests, Attendance, Pay and Settings
class HomeShell extends StatefulWidget {
  final LanguageController lang;
  final Profile profile;
  final Membership membership;
  final ValueChanged<String> onHouseholdAccepted;

  const HomeShell({
    super.key,
    required this.lang,
    required this.profile,
    required this.membership,
    required this.onHouseholdAccepted,
  });

  @override
  State<HomeShell> createState() => _HomeShellState();
}

class _HomeShellState extends State<HomeShell> {
  int _index = 0;

  @override
  Widget build(BuildContext context) {
    final isStaff = widget.membership.role.stringValue != 'owner';
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
              for (var i = 0; i < tabs.length; i++)
                NavigationDestination(
                  icon: _tabIcon(tabs[i], isStaff && i == 2),
                  label: tabs[i].label,
                ),
            ],
          ),
        );
      },
    );
  }

  Widget _tabIcon(_Tab tab, bool showRequestsBadge) {
    final icon = Icon(tab.icon);
    if (!showRequestsBadge) return icon;
    return FutureBuilder<List<HouseholdInvite>>(
      future: AppData.fetchMyHouseholdInvites(),
      builder: (context, snapshot) {
        final count = snapshot.data?.length ?? 0;
        if (count == 0) return icon;
        return Badge(
          backgroundColor: Theme.of(context).colorScheme.error,
          textColor: Theme.of(context).colorScheme.onError,
          label: Text('$count'),
          child: icon,
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
          AttendanceTab(
              lang: widget.lang,
              membership: widget.membership,
              profile: widget.profile),
        ),
        _Tab(
          Icons.payments_outlined,
          Strings.of('pay', lang),
          PayrollScreen(lang: widget.lang, membership: widget.membership),
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
          Icons.mail_outline,
          Strings.of('joinRequests', lang),
          WaitingForHouseholdScreen(
            lang: widget.lang,
            email: widget.profile.email,
            onHouseholdAccepted: widget.onHouseholdAccepted,
            inHomeShell: true,
          ),
        ),
        _Tab(
          Icons.event_available,
          Strings.of('attendance', lang),
          AttendanceTab(
              lang: widget.lang,
              membership: widget.membership,
              profile: widget.profile),
        ),
        _Tab(
          Icons.payments_outlined,
          Strings.of('pay', lang),
          PayrollScreen(lang: widget.lang, membership: widget.membership),
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
