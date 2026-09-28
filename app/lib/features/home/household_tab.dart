import 'package:flutter/material.dart';

import '../../core/app_data.dart';
import '../../core/app_language.dart';
import '../../core/strings.dart';

class HouseholdTab extends StatefulWidget {
  final LanguageController lang;
  final Profile profile;
  final Membership membership;

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
  late Future<List<Member>> _members;
  final _emailController = TextEditingController();
  bool _busy = false;
  String? _error;

  String get _householdId => widget.membership.household.id;
  bool get _isOwner => widget.membership.role.stringValue == 'owner';

  @override
  void initState() {
    super.initState();
    _members = AppData.fetchHouseholdMembers(_householdId);
  }

  Future<void> _addMaid() async {
    if (_emailController.text.trim().isEmpty) return;
    setState(() {
      _busy = true;
      _error = null;
    });
    try {
      await AppData.addMaidByEmail(
        householdId: _householdId,
        email: _emailController.text,
      );
      _emailController.clear();
      setState(() => _members = AppData.fetchHouseholdMembers(_householdId));
    } catch (e) {
      setState(() => _error = e.toString());
    } finally {
      setState(() => _busy = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final household = widget.membership.household;
    return ValueListenableBuilder<AppLanguage>(
      valueListenable: widget.lang,
      builder: (context, lang, _) {
        return ListView(
          padding: const EdgeInsets.all(16),
          children: [
            Text(
              household.name,
              style: Theme.of(context).textTheme.headlineSmall,
            ),
            if (household.address?.isNotEmpty == true)
              Text(
                household.address!,
                style: Theme.of(context).textTheme.bodyMedium,
              ),
            const SizedBox(height: 20),
            FutureBuilder<List<Member>>(
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
                            title: Text(m.user.name),
                            subtitle: Text(m.role.stringValue),
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
                controller: _emailController,
                keyboardType: TextInputType.emailAddress,
                autocorrect: false,
                decoration: InputDecoration(
                  labelText: Strings.of('email', lang),
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
