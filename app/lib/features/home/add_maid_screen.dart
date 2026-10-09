import 'package:flutter/material.dart';

import '../../core/app_data.dart';
import '../../core/app_language.dart';
import '../../core/strings.dart';
import '../../core/theme.dart';
import '../contract/contract_detail_screen.dart';
import '../profile/profile_details.dart';

/// Owner: browse maids without a current contract, then send a contract
/// request. An email invite remains available for people not in the list.
class AddMaidScreen extends StatefulWidget {
  final LanguageController lang;
  final String householdId;

  const AddMaidScreen({
    super.key,
    required this.lang,
    required this.householdId,
  });

  @override
  State<AddMaidScreen> createState() => _AddMaidScreenState();
}

class _AddMaidScreenState extends State<AddMaidScreen> {
  final _emailController = TextEditingController();
  final _rateController = TextEditingController();
  final _allowanceController = TextEditingController();
  final _customDurationController = TextEditingController();
  final _offDaysController = TextEditingController();
  final _hoursController = TextEditingController();
  int? _durationMonths;
  bool _customDuration = false;
  bool _durationInYears = false;
  String _payType = payTypes.first;
  bool _busy = false;
  bool _emailMode = false;
  String? _error;
  late Future<List<AvailableMaid>> _availableMaids;
  AvailableMaid? _selectedMaid;

  /// The email whose profile is showing; the contract form only appears
  /// while the email field still matches it.
  String? _lookedUpEmail;
  MaidProfile? _maid;

  String get _email => _emailController.text.trim().toLowerCase();
  bool get _profileShown => _lookedUpEmail != null && _lookedUpEmail == _email;

  @override
  void initState() {
    super.initState();
    _availableMaids = AppData.fetchAvailableMaids();
    // Editing the email hides the profile and contract until it's looked
    // up again.
    _emailController.addListener(() => setState(() {}));
  }

  @override
  void dispose() {
    _emailController.dispose();
    _rateController.dispose();
    _allowanceController.dispose();
    _customDurationController.dispose();
    _offDaysController.dispose();
    _hoursController.dispose();
    super.dispose();
  }

  Future<void> _lookUp(AppLanguage lang) async {
    final email = _email;
    if (email.isEmpty) {
      setState(() => _error = Strings.of('enterMaidEmail', lang));
      return;
    }
    setState(() {
      _busy = true;
      _error = null;
    });
    try {
      final maid = await AppData.fetchMaidProfileByEmail(email);
      if (!mounted) return;
      setState(() {
        _maid = maid;
        _lookedUpEmail = email;
      });
    } catch (e) {
      if (mounted) setState(() => _error = e.toString());
    } finally {
      if (mounted) setState(() => _busy = false);
    }
  }

  Future<void> _send(AppLanguage lang) async {
    final email = _email;
    final selectedMaid = _selectedMaid;
    final rate = double.tryParse(_rateController.text.trim());
    if (selectedMaid == null && email.isEmpty) {
      setState(() => _error = Strings.of('enterMaidEmail', lang));
      return;
    }
    if (rate == null || rate <= 0) {
      setState(() => _error = Strings.of('enterValidAmount', lang));
      return;
    }
    final allowanceText = _allowanceController.text.trim();
    final allowance = double.tryParse(allowanceText);
    if (allowanceText.isNotEmpty && (allowance == null || allowance < 0)) {
      setState(() => _error = Strings.of('enterValidAllowance', lang));
      return;
    }
    final durationMonths = _customDuration
        ? parseCustomContractDuration(
            _customDurationController.text,
            _durationInYears,
          )
        : _durationMonths;
    if (_customDuration && durationMonths == null) {
      setState(() => _error = Strings.of('enterValidDuration', lang));
      return;
    }
    setState(() {
      _busy = true;
      _error = null;
    });
    try {
      if (selectedMaid != null) {
        await AppData.addMaidByUserId(
          householdId: widget.householdId,
          userId: selectedMaid.id,
          payType: _payType,
          rate: rate,
          allowance: allowance,
          durationMonths: durationMonths,
          offDays: emptyToNull(_offDaysController.text),
          workingHours: emptyToNull(_hoursController.text),
        );
      } else {
        await AppData.addMaidByEmail(
          householdId: widget.householdId,
          email: email,
          payType: _payType,
          rate: rate,
          allowance: allowance,
          durationMonths: durationMonths,
          offDays: emptyToNull(_offDaysController.text),
          workingHours: emptyToNull(_hoursController.text),
        );
      }
      if (!mounted) return;
      await showSuccessDialog(
        context,
        Strings.of('requestSent', lang),
        lang,
        message: Strings.of('requestSentBody', lang),
      );
      if (mounted) Navigator.of(context).pop(true);
    } catch (e) {
      setState(() => _error = e.toString());
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
          appBar: AppBar(title: Text(Strings.of('addMaid', lang))),
          body: SingleChildScrollView(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                if (_selectedMaid != null)
                  ..._selectedMaidStep(lang)
                else if (_emailMode)
                  ..._emailInviteStep(lang)
                else
                  ..._availableMaidList(lang),
              ],
            ),
          ),
        );
      },
    );
  }

  List<Widget> _availableMaidList(AppLanguage lang) => [
        Text(
          Strings.of('availableMaidsIntro', lang),
          style: Theme.of(context).textTheme.bodyMedium,
        ),
        const SizedBox(height: 12),
        FutureBuilder<List<AvailableMaid>>(
          future: _availableMaids,
          builder: (context, snapshot) {
            if (snapshot.connectionState != ConnectionState.done) {
              return const Center(child: CircularProgressIndicator());
            }
            if (snapshot.hasError) {
              return Column(
                children: [
                  Text(
                    snapshot.error.toString(),
                    style: const TextStyle(color: Colors.red),
                  ),
                  const SizedBox(height: 8),
                  OutlinedButton.icon(
                    onPressed: () => setState(
                      () => _availableMaids = AppData.fetchAvailableMaids(),
                    ),
                    icon: const Icon(Icons.refresh),
                    label: Text(Strings.of('retry', lang)),
                  ),
                ],
              );
            }
            final maids = snapshot.data ?? const <AvailableMaid>[];
            if (maids.isEmpty) {
              return Text(
                Strings.of('noAvailableMaids', lang),
                style: const TextStyle(color: mutedText),
              );
            }
            return Column(
              children:
                  maids.map((maid) => _availableMaidCard(maid, lang)).toList(),
            );
          },
        ),
        const SizedBox(height: 12),
        OutlinedButton.icon(
          onPressed: () => setState(() {
            _emailMode = true;
            _error = null;
          }),
          icon: const Icon(Icons.email_outlined),
          label: Text(Strings.of('inviteByEmail', lang)),
        ),
      ];

  Widget _availableMaidCard(
    AvailableMaid maid,
    AppLanguage lang, {
    bool selected = false,
  }) =>
      Card(
        margin: const EdgeInsets.only(bottom: 12),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              ProfileDetails(
                lang: lang,
                name: maid.name,
                preferredAreas: maid.preferredAreas,
                spokenLanguages: maid.spokenLanguages,
              ),
              if (!selected) ...[
                const SizedBox(height: 12),
                FilledButton(
                  onPressed: _busy ? null : () => _selectMaid(maid),
                  child: Text(Strings.of('selectMaid', lang)),
                ),
              ],
            ],
          ),
        ),
      );

  void _selectMaid(AvailableMaid maid) => setState(() {
        _selectedMaid = maid;
        _error = null;
      });

  List<Widget> _selectedMaidStep(AppLanguage lang) {
    final maid = _selectedMaid!;
    return [
      TextButton.icon(
        onPressed: _busy ? null : () => setState(() => _selectedMaid = null),
        icon: const Icon(Icons.arrow_back),
        label: Text(Strings.of('chooseDifferentMaid', lang)),
      ),
      _availableMaidCard(maid, lang, selected: true),
      const SizedBox(height: 12),
      ..._contractStep(lang),
    ];
  }

  List<Widget> _emailInviteStep(AppLanguage lang) => [
        TextButton.icon(
          onPressed: _busy
              ? null
              : () => setState(() {
                    _emailMode = false;
                    _error = null;
                  }),
          icon: const Icon(Icons.arrow_back),
          label: Text(Strings.of('browseAvailableMaids', lang)),
        ),
        TextField(
          controller: _emailController,
          keyboardType: TextInputType.emailAddress,
          autocorrect: false,
          textInputAction: TextInputAction.search,
          decoration: InputDecoration(
            labelText: Strings.of('email', lang),
          ),
          onSubmitted: _busy ? null : (_) => _lookUp(lang),
        ),
        const SizedBox(height: 12),
        if (!_profileShown) ...[
          FilledButton.icon(
            onPressed: _busy ? null : () => _lookUp(lang),
            icon: const Icon(Icons.person_search_outlined),
            label: Text(Strings.of('viewProfile', lang)),
          ),
          if (_error != null) ...[
            const SizedBox(height: 8),
            Text(_error!, style: const TextStyle(color: Colors.red)),
          ],
        ] else ...[
          _maidCard(lang),
          const SizedBox(height: 24),
          ..._contractStep(lang),
        ],
      ];

  Widget _maidCard(AppLanguage lang) {
    final maid = _maid;
    return Card(
      margin: EdgeInsets.zero,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              Strings.of('maidProfile', lang),
              style: Theme.of(context).textTheme.titleMedium,
            ),
            const SizedBox(height: 8),
            if (maid == null)
              Text(
                Strings.of('maidNotOnSahakara', lang),
                style: const TextStyle(color: mutedText),
              )
            else
              ProfileDetails(
                lang: lang,
                name: maid.name,
                preferredAreas: maid.preferredAreas,
                spokenLanguages: maid.spokenLanguages,
              ),
          ],
        ),
      ),
    );
  }

  List<Widget> _contractStep(AppLanguage lang) => [
        Text(
          Strings.of('contract', lang),
          style: Theme.of(context).textTheme.titleMedium,
        ),
        const SizedBox(height: 4),
        Text(
          Strings.of('contractSentAsRequest', lang),
          style: Theme.of(context).textTheme.bodySmall,
        ),
        const SizedBox(height: 8),
        ContractFields(
          lang: lang,
          payType: _payType,
          onPayTypeChanged: (v) => setState(() => _payType = v),
          rateController: _rateController,
          allowanceController: _allowanceController,
          durationMonths: _durationMonths,
          customDuration: _customDuration,
          customDurationController: _customDurationController,
          durationInYears: _durationInYears,
          onDurationOptionChanged: (value) => setState(() {
            _customDuration = value == -1;
            if (_customDuration && _customDurationController.text.isEmpty) {
              _customDurationController.text = '1';
            } else if (!_customDuration) {
              _durationMonths = value == 0 ? null : value;
            }
          }),
          onDurationInYearsChanged: (value) =>
              setState(() => _durationInYears = value),
          offDaysController: _offDaysController,
          hoursController: _hoursController,
        ),
        const SizedBox(height: 20),
        FilledButton.icon(
          onPressed: _busy ? null : () => _send(lang),
          icon: const Icon(Icons.send_outlined),
          label: Text(Strings.of('sendRequest', lang)),
        ),
        if (_error != null) ...[
          const SizedBox(height: 8),
          Text(_error!, style: const TextStyle(color: Colors.red)),
        ],
      ];
}
