import 'package:flutter/material.dart';

import '../../core/app_data.dart';
import '../../core/app_language.dart';

/// Read-only view of the shared task library, in the user's language.
/// Owners assign library tasks to staff from the Daily tasks tab
/// (see add_daily_task_screen.dart).
class TaskLibraryScreen extends StatefulWidget {
  final LanguageController lang;
  const TaskLibraryScreen({super.key, required this.lang});

  @override
  State<TaskLibraryScreen> createState() => _TaskLibraryScreenState();
}

class _TaskLibraryScreenState extends State<TaskLibraryScreen> {
  late Future<List<LibraryTask>> _tasks;

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
        return FutureBuilder<List<LibraryTask>>(
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
                final name = pickName(
                  lang,
                  en: t.nameEn,
                  si: t.nameSi,
                  ta: t.nameTa,
                );
                return ListTile(
                  leading: const Icon(Icons.cleaning_services_outlined),
                  title: Text(name),
                  subtitle: Text(t.category.stringValue),
                );
              },
            );
          },
        );
      },
    );
  }
}
