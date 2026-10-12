import 'package:flutter/material.dart';

import '../../core/app_data.dart';
import '../../core/app_language.dart';
import '../../core/strings.dart';
import '../../core/theme.dart';
import '../../dataconnect_generated/sahakara.dart' show TaskCategory;
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
  final _maidSearchController = TextEditingController();
  final _emailController = TextEditingController();
  final _rateController = TextEditingController();
  final _allowanceController = TextEditingController();
  final _customDurationController = TextEditingController();
  final _offDaysController = TextEditingController();
  final _hoursController = TextEditingController();
  int? _durationMonths;
  int? _durationDays;
  bool _customDuration = false;
  bool _durationInYears = false;
  bool _durationInDays = false;
  String _payType = payTypes.first;
  bool _busy = false;
  bool _emailMode = false;
  String? _error;
  TaskCategory? _categoryFilter;
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
    _maidSearchController.dispose();
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
    final durationMonths = _customDuration && !_durationInDays
        ? parseCustomContractDuration(
            _customDurationController.text,
            _durationInYears,
          )
        : _durationMonths;
    final durationDays = _customDuration && _durationInDays
        ? parseCustomContractDuration(_customDurationController.text, false)
        : null;
    if (_customDuration &&
        (_durationInDays ? durationDays == null : durationMonths == null)) {
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
          durationDays: durationDays,
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
          durationDays: durationDays,
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
                    style: const TextStyle(color: brandMaroon),
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
            final query = _maidSearchController.text.trim().toLowerCase();
            final filteredMaids = maids.where((maid) {
              final matchesName = maid.name.toLowerCase().contains(query);
              final matchesCategory = _categoryFilter == null ||
                  maid.workCategories?.any(
                        (category) =>
                            category.stringValue == _categoryFilter!.name,
                      ) ==
                      true;
              return matchesName && matchesCategory;
            }).toList();
            return Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                TextField(
                  controller: _maidSearchController,
                  textInputAction: TextInputAction.search,
                  decoration: InputDecoration(
                    hintText: Strings.of('searchMaidsByName', lang),
                    prefixIcon: const Icon(Icons.search),
                    suffixIcon: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        if (_maidSearchController.text.isNotEmpty)
                          IconButton(
                            tooltip: Strings.of('clearSearch', lang),
                            onPressed: () {
                              _maidSearchController.clear();
                              setState(() {});
                            },
                            icon: const Icon(Icons.clear),
                          ),
                        IconButton(
                          tooltip: Strings.of('filterByCategory', lang),
                          onPressed: () => _showCategoryFilter(lang),
                          icon: Stack(
                            clipBehavior: Clip.none,
                            children: [
                              const Icon(Icons.tune),
                              if (_categoryFilter != null)
                                Positioned(
                                  top: -1,
                                  right: -1,
                                  child: Container(
                                    width: 8,
                                    height: 8,
                                    decoration: const BoxDecoration(
                                      color: brandMaroon,
                                      shape: BoxShape.circle,
                                    ),
                                  ),
                                ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(14),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(14),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(14),
                      borderSide: const BorderSide(color: brandGold, width: 2),
                    ),
                  ),
                  onChanged: (_) => setState(() {}),
                ),
                if (_categoryFilter != null) ...[
                  const SizedBox(height: 8),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: InputChip(
                      avatar: const Icon(Icons.filter_alt_outlined, size: 18),
                      label: Text(
                        Strings.of(
                          'workCategory_${_categoryFilter!.name}',
                          lang,
                        ),
                      ),
                      onDeleted: () => setState(() => _categoryFilter = null),
                    ),
                  ),
                ],
                const SizedBox(height: 16),
                if (filteredMaids.isEmpty)
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    child: Text(
                      Strings.of('noMatchingMaids', lang),
                      style: const TextStyle(color: mutedText),
                    ),
                  )
                else
                  ...filteredMaids.map(
                    (maid) => _availableMaidCard(maid, lang),
                  ),
              ],
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

  Future<void> _showCategoryFilter(AppLanguage lang) =>
      showModalBottomSheet<void>(
        context: context,
        showDragHandle: true,
        isScrollControlled: true,
        builder: (sheetContext) => SafeArea(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
            child: ConstrainedBox(
              constraints: BoxConstraints(
                maxHeight: MediaQuery.sizeOf(sheetContext).height * 0.7,
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(bottom: 8),
                    child: Text(
                      Strings.of('filterByCategory', lang),
                      style: Theme.of(sheetContext).textTheme.titleLarge,
                    ),
                  ),
                  Flexible(
                    child: ListView(
                      shrinkWrap: true,
                      children: [
                        _categoryFilterOption(
                          sheetContext,
                          label: Strings.of('allCategories', lang),
                          selected: _categoryFilter == null,
                          onTap: () => setState(() => _categoryFilter = null),
                        ),
                        for (final category in AppData.maidWorkCategories)
                          _categoryFilterOption(
                            sheetContext,
                            label: Strings.of(
                              'workCategory_${category.name}',
                              lang,
                            ),
                            selected: _categoryFilter == category,
                            onTap: () =>
                                setState(() => _categoryFilter = category),
                          ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      );

  Widget _categoryFilterOption(
    BuildContext sheetContext, {
    required String label,
    required bool selected,
    required VoidCallback onTap,
  }) =>
      ListTile(
        contentPadding: EdgeInsets.zero,
        title: Text(label),
        trailing: selected ? const Icon(Icons.check, color: brandMaroon) : null,
        onTap: () {
          onTap();
          Navigator.of(sheetContext).pop();
        },
      );

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
                workCategories: maid.workCategories,
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
            Text(_error!, style: const TextStyle(color: brandMaroon)),
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
                workCategories: maid.workCategories,
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
          durationDays: _durationDays,
          customDuration: _customDuration,
          customDurationController: _customDurationController,
          durationInYears: _durationInYears,
          durationInDays: _durationInDays,
          onDurationOptionChanged: (value) => setState(() {
            _customDuration = value == -1;
            if (_customDuration && _customDurationController.text.isEmpty) {
              _customDurationController.text = '1';
            } else if (!_customDuration) {
              _durationMonths = value == 0 ? null : value;
            }
          }),
          onDurationUnitChanged: (value) => setState(() {
            _durationInDays = value == 'days';
            _durationInYears = value == 'years';
          }),
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
          Text(_error!, style: const TextStyle(color: brandMaroon)),
        ],
      ];
}
