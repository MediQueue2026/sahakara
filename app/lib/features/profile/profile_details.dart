import 'package:flutter/material.dart';

import '../../core/app_language.dart';
import '../../core/strings.dart';
import '../../core/theme.dart';
import '../../dataconnect_generated/sahakara.dart' as dc;

/// Read-only rows showing someone's profile to the other side of a join
/// request: the maid's to an owner, or the owner's and house's to a maid.
/// Rows with nothing to show are left out.
class ProfileDetails extends StatelessWidget {
  final AppLanguage lang;
  final String? name;
  final List<dc.EnumValue<dc.AppLanguage>>? spokenLanguages;
  final List<String>? preferredAreas;
  final String? area;

  const ProfileDetails({
    super.key,
    required this.lang,
    this.name,
    this.spokenLanguages,
    this.preferredAreas,
    this.area,
  });

  @override
  Widget build(BuildContext context) {
    final languages = [
      for (final l in AppLanguage.values)
        if (spokenLanguages?.any((s) => s.stringValue == l.name) == true)
          l.label,
    ];
    final rows = [
      if (name?.isNotEmpty == true)
        _row(Icons.person_outline, Strings.of('name', lang), name!),
      if (area?.isNotEmpty == true)
        _row(Icons.place_outlined, Strings.of('houseArea', lang), area!),
      if (preferredAreas?.isNotEmpty == true)
        _row(
          Icons.map_outlined,
          Strings.of('preferredAreas', lang),
          preferredAreas!.join(', '),
        ),
      if (languages.isNotEmpty)
        _row(
          Icons.translate,
          Strings.of('languagesSpoken', lang),
          languages.join(', '),
        ),
    ];
    if (rows.isEmpty) {
      return Text(
        Strings.of('profileEmpty', lang),
        style: const TextStyle(color: mutedText),
      );
    }
    return Column(
        crossAxisAlignment: CrossAxisAlignment.stretch, children: rows);
  }

  Widget _row(IconData icon, String label, String value) => Padding(
        padding: const EdgeInsets.symmetric(vertical: 4),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Icon(icon, size: 20, color: mutedText),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    label,
                    style: const TextStyle(color: mutedText, fontSize: 12),
                  ),
                  Text(value),
                ],
              ),
            ),
          ],
        ),
      );
}
