import 'package:flutter/material.dart';

import '../../core/app_data.dart';
import '../../core/app_language.dart';
import '../../core/strings.dart';

class HouseholdTab extends StatefulWidget {
  final LanguageController lang;
  final Map<String, dynamic> profile;
  final Map<String, dynamic> membership;

  const HouseholdTab({
    super.key,
    required this.lang,
    required this.profile,
    required this.membership,
  });

  @override
  State<HouseholdTab> createState() => _HouseholdTabState();
}

class _HouseholdTabState extends State<HouseholdTab> {
  late Future<List<Map<String, dynamic>>> _members;
  final _phoneController = TextEditingController(text: '+94');
  bool _busy = false;
  String? _error;

  String get _householdId => widget.membership['household_id'] as String;
  bool get _isOwner => widget.membership['role'] == 'owner';

  @override
  void initState() {
    super.initState();
    _members = AppData.fetchHouseholdMembers(_householdId);
  }

  Future<void> _addMaid() async {
    if (_phoneController.text.trim().isEmpty) return;
    setState(() {
      _busy = true;
      _error = null;
    });
    try {
      await AppData.addMaidByPhone(
        householdId: _householdId,
        phone: _phoneController.text.trim(),
      );
      _phoneController.text = '+94';
      setState(() => _members = AppData.fetchHouseholdMembers(_householdId));
    } catch (e) {
      setState(() => _error = e.toString());
    } finally {
      setState(() => _busy = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final household = widget.membership['households'] as Map<String, dynamic>?;
    return ValueListenableBuilder<AppLanguage>(
      valueListenable: widget.lang,
      builder: (context, lang, _) {
        return ListView(
          padding: const EdgeInsets.all(16),
          children: [
            Text(
              household?['name'] ?? '',
              style: Theme.of(context).textTheme.headlineSmall,
            ),
            if ((household?['address'] as String?)?.isNotEmpty == true)
              Text(
                household!['address'],
                style: Theme.of(context).textTheme.bodyMedium,
              ),
            const SizedBox(height: 20),
            FutureBuilder<List<Map<String, dynamic>>>(
              future: _members,
              builder: (context, snapshot) {
                if (!snapshot.hasData) {
                  return const Center(child: CircularProgressIndicator());
                }
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: snapshot.data!
                      .map(
                        (m) => Card(
                          child: ListTile(
                            title: Text(
                              (m['users']?['name'] as String?) ??
                                  m['users']?['phone'] ??
                                  '',
                            ),
                            subtitle: Text(m['role'] as String),
                          ),
                        ),
                      )
                      .toList(),
                );
              },
            ),
            if (_isOwner) ...[
              const SizedBox(height: 24),
              Text(
                Strings.of('addMaid', lang),
                style: Theme.of(context).textTheme.titleMedium,
              ),
              const SizedBox(height: 8),
              TextField(
                controller: _phoneController,
                keyboardType: TextInputType.phone,
                decoration: InputDecoration(
                  labelText: Strings.of('phoneNumber', lang),
                ),
              ),
              const SizedBox(height: 8),
              FilledButton(
                onPressed: _busy ? null : _addMaid,
                child: Text(Strings.of('add', lang)),
              ),
              if (_error != null) ...[
                const SizedBox(height: 8),
                Text(_error!, style: const TextStyle(color: Colors.red)),
              ],
            ],
          ],
        );
      },
    );
  }
}
