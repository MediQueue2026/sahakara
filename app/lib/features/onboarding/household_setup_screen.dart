import 'package:flutter/material.dart';

import '../../core/app_data.dart';
import '../../core/app_language.dart';
import '../../core/strings.dart';
import '../../core/theme.dart';

/// Shown once, right after first login, to whoever has no household
/// membership yet. Creates the household and makes the current user its
/// owner — a maid invited by an owner never sees this screen, since their
/// membership already exists by the time they log in.
class HouseholdSetupScreen extends StatefulWidget {
  final LanguageController lang;
  final VoidCallback onDone;

  const HouseholdSetupScreen({
    super.key,
    required this.lang,
    required this.onDone,
  });

  @override
  State<HouseholdSetupScreen> createState() => _HouseholdSetupScreenState();
}

class _HouseholdSetupScreenState extends State<HouseholdSetupScreen> {
  final _nameController = TextEditingController();
  final _addressController = TextEditingController();
  bool _busy = false;
  String? _error;

  Future<void> _create() async {
    if (_nameController.text.trim().isEmpty) return;
    setState(() {
      _busy = true;
      _error = null;
    });
    try {
      await AppData.createHousehold(
        name: _nameController.text.trim(),
        address: _addressController.text.trim(),
      );
      widget.onDone();
    } catch (e) {
      setState(() => _error = e.toString());
    } finally {
      setState(() => _busy = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<AppLanguage>(
      valueListenable: widget.lang,
      builder: (context, lang, _) {
        return Scaffold(
          appBar: AppBar(title: Text(Strings.of('createHousehold', lang))),
          body: Center(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(24),
              child: ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 360),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    TextField(
                      controller: _nameController,
                      decoration: InputDecoration(
                        labelText: Strings.of('householdName', lang),
                      ),
                    ),
                    const SizedBox(height: 12),
                    TextField(
                      controller: _addressController,
                      decoration: InputDecoration(
                        labelText: Strings.of('address', lang),
                      ),
                    ),
                    const SizedBox(height: 20),
                    FilledButton(
                      onPressed: _busy ? null : _create,
                      child: Text(Strings.of('create', lang)),
                    ),
                    if (_error != null) ...[
                      const SizedBox(height: 16),
                      Text(_error!, style: const TextStyle(color: brandMaroon)),
                    ],
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
