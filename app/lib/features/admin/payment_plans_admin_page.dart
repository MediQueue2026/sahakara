import 'package:flutter/material.dart';

import '../../core/firebase_client.dart';
import '../../dataconnect_generated/sahakara.dart';
import '../../core/theme.dart';

class PaymentPlansAdminPage extends StatefulWidget {
  const PaymentPlansAdminPage({super.key});

  @override
  State<PaymentPlansAdminPage> createState() => _PaymentPlansAdminPageState();
}

class _PaymentPlansAdminPageState extends State<PaymentPlansAdminPage> {
  List<AdminPaymentPlansPaymentPlans> _plans = [];
  bool _loading = true;
  String? _error;

  BillingPeriod _period = BillingPeriod.monthly;
  final _name = TextEditingController();
  final _price = TextEditingController();
  final _description = TextEditingController();
  bool _saving = false;

  @override
  void initState() {
    super.initState();
    _load();
  }

  Future<void> _load() async {
    setState(() => _loading = true);
    try {
      final result = await db.adminPaymentPlans().execute();
      setState(() {
        _plans = result.data.paymentPlans;
        _error = null;
      });
    } catch (e) {
      setState(() => _error = e.toString());
    } finally {
      setState(() => _loading = false);
    }
  }

  Future<void> _add() async {
    final price = double.tryParse(_price.text.trim());
    if (_name.text.trim().isEmpty || price == null || price < 0) {
      setState(() => _error = 'Enter a plan name and a valid price.');
      return;
    }
    setState(() => _saving = true);
    try {
      await db
          .addPaymentPlan(
            name: _name.text.trim(),
            price: price,
            billingPeriod: _period,
          )
          .description(_description.text.trim())
          .execute();
      _name.clear();
      _price.clear();
      _description.clear();
      await _load();
    } catch (e) {
      setState(() => _error = e.toString());
    } finally {
      setState(() => _saving = false);
    }
  }

  Future<void> _remove(String id) async {
    try {
      await db.deletePaymentPlan(id: id).execute();
      await _load();
    } catch (e) {
      setState(() => _error = e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        Text('Payment plans', style: Theme.of(context).textTheme.titleLarge),
        const Text(
          'Plans households can be put on, with what they cost.',
          style: TextStyle(color: mutedText),
        ),
        const SizedBox(height: 16),
        Card(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Wrap(
              spacing: 12,
              runSpacing: 12,
              crossAxisAlignment: WrapCrossAlignment.end,
              children: [
                SizedBox(
                  width: 220,
                  child: TextField(
                    controller: _name,
                    decoration: const InputDecoration(labelText: 'Plan name'),
                  ),
                ),
                SizedBox(
                  width: 160,
                  child: TextField(
                    controller: _price,
                    keyboardType: const TextInputType.numberWithOptions(
                      decimal: true,
                    ),
                    decoration: const InputDecoration(
                      labelText: 'Price (LKR)',
                    ),
                  ),
                ),
                DropdownButton<BillingPeriod>(
                  value: _period,
                  items: BillingPeriod.values
                      .map(
                        (p) => DropdownMenuItem(value: p, child: Text(p.name)),
                      )
                      .toList(),
                  onChanged: (v) => setState(() => _period = v!),
                ),
                SizedBox(
                  width: 300,
                  child: TextField(
                    controller: _description,
                    decoration: const InputDecoration(
                      labelText: 'Description (optional)',
                    ),
                  ),
                ),
                FilledButton.icon(
                  onPressed: _saving ? null : _add,
                  icon: const Icon(Icons.add),
                  label: const Text('Add plan'),
                ),
              ],
            ),
          ),
        ),
        if (_error != null)
          Padding(
            padding: const EdgeInsets.only(top: 8),
            child: Text(_error!, style: const TextStyle(color: Colors.red)),
          ),
        const SizedBox(height: 16),
        if (_loading) const Center(child: CircularProgressIndicator()),
        if (!_loading && _plans.isEmpty) const Text('No payment plans yet.'),
        if (!_loading && _plans.isNotEmpty)
          Card(
            child: Column(
              children: _plans.map((p) {
                final inUse = p.householdSubscriptions_on_plan.length;
                return ListTile(
                  title: Text(p.name),
                  subtitle: Text(
                    [
                      'LKR ${p.price.toStringAsFixed(2)} / '
                          '${p.billingPeriod.stringValue}',
                      '$inUse household(s)',
                      if (p.description?.isNotEmpty == true) p.description!,
                    ].join(' · '),
                  ),
                  trailing: IconButton(
                    icon: const Icon(Icons.delete_outline),
                    tooltip: inUse > 0
                        ? 'Move its households to another plan first'
                        : 'Delete plan',
                    onPressed: inUse > 0 ? null : () => _remove(p.id),
                  ),
                );
              }).toList(),
            ),
          ),
      ],
    );
  }
}
