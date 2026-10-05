import 'package:flutter/material.dart';

import '../../core/firebase_client.dart';
import '../../dataconnect_generated/sahakara.dart';
import '../../core/theme.dart';

class HouseholdsAdminPage extends StatefulWidget {
  const HouseholdsAdminPage({super.key});

  @override
  State<HouseholdsAdminPage> createState() => _HouseholdsAdminPageState();
}

class _HouseholdsAdminPageState extends State<HouseholdsAdminPage> {
  List<AdminHouseholdsHouseholds> _households = [];
  List<AdminPaymentPlansPaymentPlans> _plans = [];
  bool _loading = true;
  String? _error;

  @override
  void initState() {
    super.initState();
    _load();
  }

  Future<void> _load() async {
    try {
      final results = await Future.wait([
        db.adminHouseholds().execute(),
        db.adminPaymentPlans().execute(),
      ]);
      setState(() {
        _households = (results[0].data as AdminHouseholdsData).households;
        _plans = (results[1].data as AdminPaymentPlansData).paymentPlans;
        _error = null;
      });
    } catch (e) {
      setState(() => _error = e.toString());
    } finally {
      setState(() => _loading = false);
    }
  }

  Future<void> _setPlan(AdminHouseholdsHouseholds household) async {
    if (_plans.isEmpty) {
      setState(() => _error = 'Add a payment plan first.');
      return;
    }
    final current = household.householdSubscription_on_household;
    final saved = await showDialog<bool>(
      context: context,
      builder: (_) => _SetPlanDialog(
        household: household,
        plans: _plans,
        currentPlanId: current?.plan.id,
        currentPrice: current?.price,
      ),
    );
    if (saved == true) await _load();
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        Text('Households', style: Theme.of(context).textTheme.titleLarge),
        const Text(
          'Every household registered through the mobile app.',
          style: TextStyle(color: mutedText),
        ),
        const SizedBox(height: 16),
        if (_loading) const Center(child: CircularProgressIndicator()),
        if (_error != null)
          Text(_error!, style: const TextStyle(color: Colors.red)),
        if (!_loading && _households.isEmpty && _error == null)
          const Text('No households yet.'),
        if (!_loading)
          Card(
            child: Column(
              children: _households.map(
                (h) {
                  final sub = h.householdSubscription_on_household;
                  return ListTile(
                    title: Text(h.name),
                    subtitle: Text(
                      [
                        h.address?.isNotEmpty == true
                            ? h.address!
                            : 'No address on file',
                        '${h.householdMembers_on_household.length} '
                            'member(s)',
                        sub == null
                            ? 'No plan'
                            : '${sub.plan.name} · LKR '
                                '${sub.price.toStringAsFixed(2)} / '
                                '${sub.plan.billingPeriod.stringValue}',
                      ].join(' · '),
                    ),
                    trailing: OutlinedButton(
                      onPressed: () => _setPlan(h),
                      child: Text(sub == null ? 'Set plan' : 'Change plan'),
                    ),
                  );
                },
              ).toList(),
            ),
          ),
      ],
    );
  }
}

class _SetPlanDialog extends StatefulWidget {
  const _SetPlanDialog({
    required this.household,
    required this.plans,
    this.currentPlanId,
    this.currentPrice,
  });

  final AdminHouseholdsHouseholds household;
  final List<AdminPaymentPlansPaymentPlans> plans;
  final String? currentPlanId;
  final double? currentPrice;

  @override
  State<_SetPlanDialog> createState() => _SetPlanDialogState();
}

class _SetPlanDialogState extends State<_SetPlanDialog> {
  late AdminPaymentPlansPaymentPlans _plan;
  late final TextEditingController _price;
  bool _saving = false;
  String? _error;

  @override
  void initState() {
    super.initState();
    _plan = widget.plans.firstWhere(
      (p) => p.id == widget.currentPlanId,
      orElse: () => widget.plans.first,
    );
    _price = TextEditingController(
      text: (widget.currentPrice ?? _plan.price).toStringAsFixed(2),
    );
  }

  @override
  void dispose() {
    _price.dispose();
    super.dispose();
  }

  Future<void> _save() async {
    final price = double.tryParse(_price.text.trim());
    if (price == null || price < 0) {
      setState(() => _error = 'Enter a valid price.');
      return;
    }
    setState(() => _saving = true);
    try {
      await db
          .setHouseholdPlan(
            householdId: widget.household.id,
            planId: _plan.id,
            price: price,
          )
          .execute();
      if (mounted) Navigator.pop(context, true);
    } catch (e) {
      setState(() {
        _error = e.toString();
        _saving = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('Payment plan for ${widget.household.name}'),
      content: SizedBox(
        width: 360,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            DropdownButtonFormField<AdminPaymentPlansPaymentPlans>(
              initialValue: _plan,
              decoration: const InputDecoration(labelText: 'Plan'),
              items: widget.plans
                  .map(
                    (p) => DropdownMenuItem(
                      value: p,
                      child: Text(
                        '${p.name} (LKR ${p.price.toStringAsFixed(2)} / '
                        '${p.billingPeriod.stringValue})',
                      ),
                    ),
                  )
                  .toList(),
              // Picking a plan resets the price to that plan's price; the
              // admin can then change it for this household.
              onChanged: (p) => setState(() {
                _plan = p!;
                _price.text = p.price.toStringAsFixed(2);
              }),
            ),
            const SizedBox(height: 12),
            TextField(
              controller: _price,
              keyboardType: const TextInputType.numberWithOptions(
                decimal: true,
              ),
              decoration: InputDecoration(
                labelText: 'Price (LKR)',
                helperText:
                    'Per ${_plan.billingPeriod.stringValue == 'yearly' ? 'year' : 'month'}',
              ),
            ),
            if (_error != null)
              Padding(
                padding: const EdgeInsets.only(top: 8),
                child: Text(_error!, style: const TextStyle(color: Colors.red)),
              ),
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: _saving ? null : () => Navigator.pop(context),
          child: const Text('Cancel'),
        ),
        FilledButton(
          onPressed: _saving ? null : _save,
          child: const Text('Save'),
        ),
      ],
    );
  }
}
