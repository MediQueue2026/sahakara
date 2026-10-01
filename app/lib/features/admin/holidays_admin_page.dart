import 'package:flutter/material.dart';

import '../../core/firebase_client.dart';
import '../../dataconnect_generated/sahakara.dart';
import '../../core/theme.dart';

class HolidaysAdminPage extends StatefulWidget {
  const HolidaysAdminPage({super.key});

  @override
  State<HolidaysAdminPage> createState() => _HolidaysAdminPageState();
}

class _HolidaysAdminPageState extends State<HolidaysAdminPage> {
  List<HolidaysHolidays> _holidays = [];
  bool _loading = true;
  String? _error;

  DateTime? _date;
  HolidayType _type = HolidayType.values.first;
  final _nameEn = TextEditingController();
  final _nameSi = TextEditingController();
  final _nameTa = TextEditingController();
  bool _saving = false;

  @override
  void initState() {
    super.initState();
    _load();
  }

  Future<void> _load() async {
    setState(() => _loading = true);
    try {
      final result = await db.holidays().execute();
      setState(() {
        _holidays = result.data.holidays;
        _error = null;
      });
    } catch (e) {
      setState(() => _error = e.toString());
    } finally {
      setState(() => _loading = false);
    }
  }

  Future<void> _pickDate() async {
    final picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(DateTime.now().year - 1),
      lastDate: DateTime(DateTime.now().year + 3),
    );
    if (picked != null) setState(() => _date = picked);
  }

  Future<void> _add() async {
    if (_date == null || _nameEn.text.trim().isEmpty) return;
    setState(() => _saving = true);
    try {
      await db
          .addHoliday(date: _date!, type: _type, nameEn: _nameEn.text.trim())
          .nameSi(_nameSi.text.trim())
          .nameTa(_nameTa.text.trim())
          .execute();
      setState(() => _date = null);
      _nameEn.clear();
      _nameSi.clear();
      _nameTa.clear();
      await _load();
    } catch (e) {
      setState(() => _error = e.toString());
    } finally {
      setState(() => _saving = false);
    }
  }

  Future<void> _remove(String id) async {
    try {
      await db.deleteHoliday(id: id).execute();
      await _load();
    } catch (e) {
      setState(() => _error = e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        Text('Holidays', style: Theme.of(context).textTheme.titleLarge),
        const Text(
          'Poya and public holiday calendar, preloaded once a year.',
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
                OutlinedButton(
                  onPressed: _pickDate,
                  child: Text(
                    _date == null
                        ? 'Pick date'
                        : _date!.toIso8601String().substring(0, 10),
                  ),
                ),
                DropdownButton<HolidayType>(
                  value: _type,
                  items: HolidayType.values
                      .map(
                        (t) => DropdownMenuItem(value: t, child: Text(t.name)),
                      )
                      .toList(),
                  onChanged: (v) => setState(() => _type = v!),
                ),
                SizedBox(
                  width: 220,
                  child: TextField(
                    controller: _nameEn,
                    decoration: const InputDecoration(
                      labelText: 'Name (English)',
                    ),
                  ),
                ),
                SizedBox(
                  width: 220,
                  child: TextField(
                    controller: _nameSi,
                    decoration: const InputDecoration(
                      labelText: 'Name (Sinhala)',
                    ),
                  ),
                ),
                SizedBox(
                  width: 220,
                  child: TextField(
                    controller: _nameTa,
                    decoration: const InputDecoration(
                      labelText: 'Name (Tamil)',
                    ),
                  ),
                ),
                FilledButton.icon(
                  onPressed: _saving ? null : _add,
                  icon: const Icon(Icons.add),
                  label: const Text('Add holiday'),
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
        if (!_loading)
          Card(
            child: Column(
              children: _holidays
                  .map(
                    (h) => ListTile(
                      title: Text(h.nameEn),
                      subtitle: Text(
                        '${h.date.toIso8601String().substring(0, 10)} · ${h.type.stringValue}',
                      ),
                      trailing: IconButton(
                        icon: const Icon(Icons.delete_outline),
                        onPressed: () => _remove(h.id),
                      ),
                    ),
                  )
                  .toList(),
            ),
          ),
      ],
    );
  }
}
