import 'package:flutter/material.dart';

import '../../core/app_data.dart';
import '../../core/app_language.dart';
import '../../core/strings.dart';
import '../../core/theme.dart';

/// The signed-in user's own profile in Settings: their name and the
/// languages they speak, plus, for maids, the areas they'd like to work in
/// and, for owners, the area the house is in.
/// Every field is optional, and changes stay on screen until Save.
class ProfileSection extends StatefulWidget {
  final Profile profile;
  final AppLanguage lang;

  /// Shows the preferred work areas field (maids only).
  final bool showAreas;

  /// The owner's household, to edit its area. Null for maids.
  final Household? household;

  /// Called after a successful save, so Settings can show the new name.
  final VoidCallback onSaved;

  const ProfileSection({
    super.key,
    required this.profile,
    required this.lang,
    required this.showAreas,
    this.household,
    required this.onSaved,
  });

  @override
  State<ProfileSection> createState() => _ProfileSectionState();
}

class _ProfileSectionState extends State<ProfileSection> {
  late final _nameController = TextEditingController(text: widget.profile.name);
  final _areaController = TextEditingController();
  late final _houseAreaController = TextEditingController(
    text: widget.household?.area,
  );
  late final List<String> _areas = [...?widget.profile.preferredAreas];
  late final Set<String> _spoken = {
    for (final l in widget.profile.spokenLanguages ?? const []) l.stringValue,
  };
  bool _busy = false;
  String? _error;

  @override
  void dispose() {
    _nameController.dispose();
    _areaController.dispose();
    _houseAreaController.dispose();
    super.dispose();
  }

  void _addArea() {
    final area = _areaController.text.trim();
    if (area.isEmpty) return;
    final exists = _areas.any((a) => a.toLowerCase() == area.toLowerCase());
    setState(() {
      if (!exists) _areas.add(area);
      _areaController.clear();
    });
  }

  Future<void> _save() async {
    final lang = widget.lang;
    // Every field is optional. Every account still needs a name, though,
    // so a cleared name keeps the one already saved.
    final typedName = _nameController.text.trim();
    final name = typedName.isEmpty ? widget.profile.name : typedName;
    // Keep an area typed but not yet added with the + button.
    _addArea();
    setState(() {
      _busy = true;
      _error = null;
    });
    try {
      final household = widget.household;
      if (household != null) {
        await AppData.setHouseholdArea(
          householdId: household.id,
          area: _houseAreaController.text,
        );
      }
      await AppData.saveProfile(
        name: name,
        preferredAreas: _areas,
        // Saved in a fixed order so the list doesn't depend on tap order.
        spokenLanguages: [
          for (final l in AppLanguage.values)
            if (_spoken.contains(l.name)) l.name,
        ],
      );
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(Strings.of('profileSaved', lang))),
      );
      widget.onSaved();
    } catch (e) {
      if (mounted) setState(() => _error = e.toString());
    } finally {
      if (mounted) setState(() => _busy = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final lang = widget.lang;
    final textTheme = Theme.of(context).textTheme;
    return Card(
      margin: EdgeInsets.zero,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(Strings.of('myProfile', lang), style: textTheme.titleMedium),
            const SizedBox(height: 16),
            TextField(
              controller: _nameController,
              textCapitalization: TextCapitalization.words,
              decoration: InputDecoration(
                labelText: Strings.of('name', lang),
                helperText: Strings.of('optional', lang),
              ),
            ),
            const SizedBox(height: 20),
            if (widget.household != null) ...[
              _OptionalHeading(Strings.of('houseLocation', lang), lang: lang),
              const SizedBox(height: 8),
              TextField(
                controller: _houseAreaController,
                textCapitalization: TextCapitalization.words,
                decoration: InputDecoration(
                  labelText: Strings.of('houseArea', lang),
                  hintText: Strings.of('houseAreaHint', lang),
                ),
              ),
              const SizedBox(height: 20),
            ],
            if (widget.showAreas) ...[
              _OptionalHeading(Strings.of('preferredAreas', lang), lang: lang),
              const SizedBox(height: 8),
              if (_areas.isNotEmpty) ...[
                Wrap(
                  spacing: 8,
                  runSpacing: 4,
                  children: [
                    for (final area in _areas)
                      InputChip(
                        label: Text(area),
                        onDeleted: _busy
                            ? null
                            : () => setState(() => _areas.remove(area)),
                      ),
                  ],
                ),
                const SizedBox(height: 8),
              ],
              TextField(
                controller: _areaController,
                textCapitalization: TextCapitalization.words,
                textInputAction: TextInputAction.done,
                decoration: InputDecoration(
                  hintText: Strings.of('addArea', lang),
                  suffixIcon: IconButton(
                    tooltip: Strings.of('add', lang),
                    onPressed: _busy ? null : _addArea,
                    icon: const Icon(Icons.add),
                  ),
                ),
                onSubmitted: (_) => _addArea(),
              ),
            ],
            const SizedBox(height: 20),
            _OptionalHeading(Strings.of('languagesISpeak', lang), lang: lang),
            const SizedBox(height: 8),
            Wrap(
              spacing: 8,
              children: [
                for (final l in AppLanguage.values)
                  FilterChip(
                    label: Text(l.label),
                    selected: _spoken.contains(l.name),
                    onSelected: _busy
                        ? null
                        : (on) => setState(
                              () => on
                                  ? _spoken.add(l.name)
                                  : _spoken.remove(l.name),
                            ),
                  ),
              ],
            ),
            if (_error != null) ...[
              const SizedBox(height: 12),
              Text(_error!, style: const TextStyle(color: Colors.red)),
            ],
            const SizedBox(height: 20),
            FilledButton(
              onPressed: _busy ? null : _save,
              child: Text(Strings.of('save', lang)),
            ),
          ],
        ),
      ),
    );
  }
}

/// A section heading followed by a muted "Optional".
class _OptionalHeading extends StatelessWidget {
  final String text;
  final AppLanguage lang;

  const _OptionalHeading(this.text, {required this.lang});

  @override
  Widget build(BuildContext context) {
    return Text.rich(
      TextSpan(
        text: text,
        children: [
          TextSpan(
            text: '  ·  ${Strings.of('optional', lang)}',
            style: const TextStyle(
              color: mutedText,
              fontWeight: FontWeight.normal,
            ),
          ),
        ],
      ),
      style: Theme.of(context).textTheme.titleSmall,
    );
  }
}
