import 'package:flutter/material.dart';

import '../../core/app_language.dart';
import '../../core/strings.dart';

/// One staff member the owner can pick in a [StaffFilter].
class StaffOption {
  final String id;
  final String name;

  /// No longer in the household, but still has records on file.
  final bool former;

  const StaffOption(this.id, this.name, {this.former = false});

  /// Current staff first, then anyone else found in [records] (as
  /// `(memberId, name)` pairs) marked as former staff.
  static List<StaffOption> collect(
    Iterable<StaffOption> current,
    Iterable<(String, String)> records,
  ) {
    final options = [...current];
    for (final (id, name) in records) {
      if (options.every((option) => option.id != id)) {
        options.add(StaffOption(id, name, former: true));
      }
    }
    return options;
  }
}

/// A row of chips that lets the owner look at one staff member's records,
/// or everyone's. [selectedId] is null for everyone.
class StaffFilter extends StatelessWidget {
  final List<StaffOption> options;
  final String? selectedId;
  final ValueChanged<String?> onSelected;
  final AppLanguage lang;

  const StaffFilter({
    super.key,
    required this.options,
    required this.selectedId,
    required this.onSelected,
    required this.lang,
  });

  @override
  Widget build(BuildContext context) {
    Widget chip(String? id, String label) => Padding(
          padding: const EdgeInsets.only(right: 8),
          child: ChoiceChip(
            label: Text(label),
            selected: selectedId == id,
            onSelected: (_) => onSelected(id),
          ),
        );

    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      padding: const EdgeInsets.only(bottom: 8),
      child: Row(
        children: [
          chip(null, Strings.of('allStaff', lang)),
          for (final option in options)
            chip(
              option.id,
              option.former
                  ? '${option.name} (${Strings.of('formerStaff', lang)})'
                  : option.name,
            ),
        ],
      ),
    );
  }
}
