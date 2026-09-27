import 'package:flutter/material.dart';

import '../../core/app_data.dart';
import '../../core/app_language.dart';

/// Read-only view of the shared task library, in the user's language.
/// Turning a library entry into a household's recurring task_template is a
/// Sprint 2 feature — this is the Sprint 1 basics: everyone can browse it.
class TaskLibraryScreen extends StatefulWidget {
  final LanguageController lang;
  const TaskLibraryScreen({super.key, required this.lang});

  @override
  State<TaskLibraryScreen> createState() => _TaskLibraryScreenState();
}

class _TaskLibraryScreenState extends State<TaskLibraryScreen> {
  late Future<List<Map<String, dynamic>>> _tasks;

  @override
  void initState() {
    super.initState();
    _tasks = AppData.fetchTaskLibrary();
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<AppLanguage>(
      valueListenable: widget.lang,
      builder: (context, lang, _) {
        return FutureBuilder<List<Map<String, dynamic>>>(
          future: _tasks,
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              return const Center(child: CircularProgressIndicator());
            }
            final tasks = snapshot.data!;
            if (tasks.isEmpty) {
              return const Center(child: Text('No tasks in the library yet.'));
            }
            return ListView.builder(
              padding: const EdgeInsets.all(8),
              itemCount: tasks.length,
              itemBuilder: (context, i) {
                final t = tasks[i];
                final name = switch (lang) {
                  AppLanguage.si => (t['name_si'] as String?) ?? t['name_en'],
                  AppLanguage.ta => (t['name_ta'] as String?) ?? t['name_en'],
                  AppLanguage.en => t['name_en'],
                };
                return ListTile(
                  leading: const Icon(Icons.cleaning_services_outlined),
                  title: Text(name as String),
                  subtitle: Text(t['category'] as String),
                );
              },
            );
          },
        );
      },
    );
  }
}
