import 'package:flutter/material.dart';

import '../../core/app_data.dart';
import '../../core/app_language.dart';
import '../../core/strings.dart';
import '../../core/theme.dart';
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
/// - owner: Household, Daily tasks, Contracts, Attendance and Pay
/// - staff: My tasks, My contract, Join requests, Attendance and Pay
/// Settings opens from the gear in the top bar, which every tab shares.
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
          appBar: AppBar(
            title: Text(tabs[index].label),
            actions: [
              IconButton(
                tooltip: Strings.of('settings', lang),
                onPressed: () => _openSettings(lang),
                icon: const Icon(Icons.settings_outlined),
              ),
            ],
          ),
          body: tabs[index].page,
          bottomNavigationBar: _BottomBar(
            selectedIndex: index,
            onSelected: (i) => setState(() => _index = i),
            items: [
              for (var i = 0; i < tabs.length; i++)
                _BottomBarItem(
                  label: tabs[i].label,
                  icon: _tabIcon(
                    i == index ? tabs[i].selectedIcon : tabs[i].icon,
                    isStaff && i == 2,
                  ),
                ),
            ],
          ),
        );
      },
    );
  }

  void _openSettings(AppLanguage lang) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (_) => Scaffold(
          appBar: AppBar(title: Text(Strings.of('settings', lang))),
          body: SettingsScreen(lang: widget.lang, profile: widget.profile),
        ),
      ),
    );
  }

  Widget _tabIcon(IconData iconData, bool showRequestsBadge) {
    final icon = Icon(iconData);
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
          Icons.home,
          Strings.of('household', lang),
          HouseholdTab(lang: widget.lang, membership: widget.membership),
        ),
        _Tab(
          Icons.task_alt,
          Icons.check_circle,
          Strings.of('dailyTasks', lang),
          DailyTasksScreen(lang: widget.lang, membership: widget.membership),
        ),
        _Tab(
          Icons.description_outlined,
          Icons.description,
          Strings.of('contract', lang),
          ContractScreen(lang: widget.lang, membership: widget.membership),
        ),
        _Tab(
          Icons.event_available,
          Icons.event_available,
          Strings.of('attendance', lang),
          AttendanceTab(
              lang: widget.lang,
              membership: widget.membership,
              profile: widget.profile),
        ),
        _Tab(
          Icons.payments_outlined,
          Icons.payments,
          Strings.of('pay', lang),
          PayrollScreen(lang: widget.lang, membership: widget.membership),
        ),
      ];

  List<_Tab> _staffTabs(AppLanguage lang) => [
        _Tab(
          Icons.checklist,
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
          Icons.description,
          Strings.of('myContract', lang),
          ContractDetailScreen(
            lang: widget.lang,
            memberId: widget.membership.id,
            memberName: widget.profile.name,
            editable: false,
            showAppBar: false,
          ),
        ),
        _Tab(
          Icons.mail_outline,
          Icons.mail,
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
          Icons.event_available,
          Strings.of('attendance', lang),
          AttendanceTab(
              lang: widget.lang,
              membership: widget.membership,
              profile: widget.profile),
        ),
        _Tab(
          Icons.payments_outlined,
          Icons.payments,
          Strings.of('pay', lang),
          PayrollScreen(lang: widget.lang, membership: widget.membership),
        ),
      ];
}

class _Tab {
  final IconData icon;
  final IconData selectedIcon;
  final String label;
  final Widget page;

  const _Tab(this.icon, this.selectedIcon, this.label, this.page);
}

class _BottomBarItem {
  final Widget icon;
  final String label;

  const _BottomBarItem({required this.icon, required this.label});
}

/// The cream tab bar along the bottom. Built by hand rather than with
/// [NavigationBar] so that six tabs fit on a phone: labels shrink to fit
/// instead of being cut off, which matters for the longer Sinhala and Tamil
/// labels.
class _BottomBar extends StatelessWidget {
  final List<_BottomBarItem> items;
  final int selectedIndex;
  final ValueChanged<int> onSelected;

  const _BottomBar({
    required this.items,
    required this.selectedIndex,
    required this.onSelected,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: brandCream,
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
        boxShadow: [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 12,
            offset: Offset(0, -2),
          ),
        ],
      ),
      child: SafeArea(
        top: false,
        child: Padding(
          padding: const EdgeInsets.fromLTRB(4, 8, 4, 6),
          child: Row(
            children: [
              for (var i = 0; i < items.length; i++)
                Expanded(
                  child: _BottomBarButton(
                    item: items[i],
                    selected: i == selectedIndex,
                    onTap: () => onSelected(i),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}

class _BottomBarButton extends StatelessWidget {
  final _BottomBarItem item;
  final bool selected;
  final VoidCallback onTap;

  const _BottomBarButton({
    required this.item,
    required this.selected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Semantics(
      button: true,
      selected: selected,
      label: item.label,
      excludeSemantics: true,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 2, vertical: 2),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              AnimatedContainer(
                duration: const Duration(milliseconds: 200),
                curve: Curves.easeOut,
                width: selected ? 52 : 40,
                height: 30,
                decoration: BoxDecoration(
                  color: selected ? brandAmber : Colors.transparent,
                  borderRadius: BorderRadius.circular(15),
                ),
                child: IconTheme(
                  data: IconThemeData(
                    size: 22,
                    color: selected ? Colors.black : mutedText,
                  ),
                  child: Center(child: item.icon),
                ),
              ),
              const SizedBox(height: 4),
              SizedBox(
                height: 16,
                child: FittedBox(
                  fit: BoxFit.scaleDown,
                  child: Text(
                    item.label,
                    maxLines: 1,
                    style: TextStyle(
                      fontSize: 11,
                      fontWeight: selected ? FontWeight.w700 : FontWeight.w500,
                      color: selected ? Colors.black : mutedText,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
