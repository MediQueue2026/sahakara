import 'package:flutter/material.dart';

import '../../core/app_data.dart';
import '../../core/app_language.dart';
import '../../core/firebase_client.dart';
import '../../core/strings.dart';
import '../../core/theme.dart';

/// Shown to a maid account with no household membership yet. An owner adds
/// her by the email she signed up with, which sends her a request with the
/// contract on offer: she accepts it here (and [onRefresh] then takes her
/// into the household) or declines it. With no requests, there's nothing to
/// do but wait and check again.
class WaitingForHouseholdScreen extends StatefulWidget {
  final LanguageController lang;
  final String email;
  final ValueChanged<String> onHouseholdAccepted;
  final bool inHomeShell;

  const WaitingForHouseholdScreen({
    super.key,
    required this.lang,
    required this.email,
    required this.onHouseholdAccepted,
    this.inHomeShell = false,
  });

  @override
  State<WaitingForHouseholdScreen> createState() =>
      _WaitingForHouseholdScreenState();
}

class _WaitingForHouseholdScreenState extends State<WaitingForHouseholdScreen> {
  late Future<List<HouseholdInvite>> _invites;
  bool _busy = false;

  @override
  void initState() {
    super.initState();
    _invites = AppData.fetchMyHouseholdInvites();
  }

  void _checkAgain() => setState(() {
        _invites = AppData.fetchMyHouseholdInvites();
      });

  Future<void> _respond(HouseholdInvite invite, bool accept) async {
    setState(() => _busy = true);
    try {
      await AppData.respondToHouseholdInvite(
        memberId: invite.id,
        accept: accept,
      );
      if (accept) {
        widget.onHouseholdAccepted(invite.id);
      } else {
        _checkAgain();
      }
    } catch (e) {
      if (!mounted) return;
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(e.toString())));
    } finally {
      if (mounted) setState(() => _busy = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<AppLanguage>(
      valueListenable: widget.lang,
      builder: (context, lang, _) {
        return Scaffold(
          appBar: widget.inHomeShell
              ? AppBar(title: Text(Strings.of('joinRequests', lang)))
              : null,
          body: SafeArea(
            child: Center(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(24),
                child: ConstrainedBox(
                  constraints: const BoxConstraints(maxWidth: 400),
                  child: FutureBuilder<List<HouseholdInvite>>(
                    future: _invites,
                    builder: (context, snapshot) {
                      if (snapshot.connectionState != ConnectionState.done) {
                        return const Center(child: CircularProgressIndicator());
                      }
                      final invites = snapshot.data ?? [];
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          if (snapshot.hasError)
                            Text(
                              '${snapshot.error}',
                              style: const TextStyle(color: Colors.red),
                            ),
                          if (invites.isEmpty && !widget.inHomeShell)
                            ..._waiting(lang)
                          else if (invites.isEmpty)
                            Text(
                              Strings.of('noJoinRequests', lang),
                              textAlign: TextAlign.center,
                            )
                          else ...[
                            Text(
                              Strings.of('joinRequests', lang),
                              textAlign: TextAlign.center,
                              style: Theme.of(context).textTheme.titleLarge,
                            ),
                            const SizedBox(height: 16),
                            for (final i in invites) _inviteCard(i, lang),
                          ],
                          const SizedBox(height: 24),
                          FilledButton.tonal(
                            onPressed: _busy ? null : _checkAgain,
                            child: Text(Strings.of('checkAgain', lang)),
                          ),
                          if (!widget.inHomeShell) ...[
                            const SizedBox(height: 8),
                            TextButton(
                              onPressed: () => auth.signOut(),
                              child: Text(Strings.of('signOut', lang)),
                            ),
                          ],
                        ],
                      );
                    },
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  /// No requests yet: ask the owner to add this email address.
  List<Widget> _waiting(AppLanguage lang) => [
        const Icon(Icons.hourglass_empty, size: 48),
        const SizedBox(height: 16),
        Text(
          Strings.of('waitingForHousehold', lang),
          textAlign: TextAlign.center,
          style: Theme.of(context).textTheme.titleLarge,
        ),
        const SizedBox(height: 12),
        Text(
          Strings.of('waitingForHouseholdBody', lang),
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 8),
        Text(
          widget.email,
          textAlign: TextAlign.center,
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
      ];

  /// One request: who it's from, the contract offered, and accept/decline.
  Widget _inviteCard(HouseholdInvite invite, AppLanguage lang) {
    final household = invite.household;
    final contract = invite.contracts_on_member.firstOrNull;
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(household.name,
                style: Theme.of(context).textTheme.titleMedium),
            Text(
              [
                household.owner.name,
                if (household.address?.isNotEmpty == true) household.address!,
              ].join(' · '),
              style: const TextStyle(color: mutedText),
            ),
            const Divider(height: 24),
            if (contract == null)
              Text(Strings.of('noContract', lang))
            else ...[
              _row(
                Strings.of('payType', lang),
                Strings.of('payType_${contract.payType.stringValue}', lang),
              ),
              _row(
                Strings.of('rate_${contract.payType.stringValue}', lang),
                '${contract.rate}',
              ),
              if (contract.allowance != null)
                _row(Strings.of('allowance', lang), '${contract.allowance}'),
              _row(Strings.of('offDays', lang), contract.offDays ?? '—'),
              _row(
                Strings.of('workingHours', lang),
                contract.workingHours ?? '—',
              ),
            ],
            const SizedBox(height: 16),
            Row(
              children: [
                Expanded(
                  child: OutlinedButton(
                    onPressed: _busy ? null : () => _respond(invite, false),
                    child: Text(Strings.of('decline', lang)),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: FilledButton(
                    onPressed: _busy ? null : () => _respond(invite, true),
                    child: Text(Strings.of('accept', lang)),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _row(String label, String value) => Padding(
        padding: const EdgeInsets.symmetric(vertical: 4),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(label, style: const TextStyle(color: mutedText)),
            const SizedBox(width: 12),
            Flexible(child: Text(value, textAlign: TextAlign.end)),
          ],
        ),
      );
}
