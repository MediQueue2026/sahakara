import 'package:flutter/material.dart';

import '../../core/firebase_client.dart';
import 'holidays_admin_page.dart';
import 'households_admin_page.dart';
import 'task_library_admin_page.dart';

class AdminShell extends StatefulWidget {
  const AdminShell({super.key});

  @override
  State<AdminShell> createState() => _AdminShellState();
}

class _AdminShellState extends State<AdminShell> {
  int _index = 0;

  static const _destinations = [
    NavigationRailDestination(
      icon: Icon(Icons.home_outlined),
      label: Text('Households'),
    ),
    NavigationRailDestination(
      icon: Icon(Icons.checklist_outlined),
      label: Text('Task library'),
    ),
    NavigationRailDestination(
      icon: Icon(Icons.calendar_month_outlined),
      label: Text('Holidays'),
    ),
  ];

  static const _pages = [
    HouseholdsAdminPage(),
    TaskLibraryAdminPage(),
    HolidaysAdminPage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        children: [
          NavigationRail(
            selectedIndex: _index,
            onDestinationSelected: (i) => setState(() => _index = i),
            labelType: NavigationRailLabelType.all,
            leading: const Padding(
              padding: EdgeInsets.symmetric(vertical: 16),
              child: Text(
                'Sahakara',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
            trailing: Expanded(
              child: Align(
                alignment: Alignment.bottomCenter,
                child: Padding(
                  padding: const EdgeInsets.only(bottom: 16),
                  child: IconButton(
                    onPressed: () => auth.signOut(),
                    icon: const Icon(Icons.logout),
                    tooltip: 'Sign out',
                  ),
                ),
              ),
            ),
            destinations: _destinations,
          ),
          const VerticalDivider(width: 1),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(24),
              child: _pages[_index],
            ),
          ),
        ],
      ),
    );
  }
}
