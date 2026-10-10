import 'package:flutter/material.dart';
import 'package:translator/translator.dart';

import '../../core/app_data.dart';
import '../../core/app_language.dart';
import '../../core/theme.dart';
import '../../dataconnect_generated/sahakara.dart' hide AppLanguage;
import '../../core/strings.dart';

class GroceryListScreen extends StatefulWidget {
  final String householdId;
  final ValueNotifier<AppLanguage> lang;
  final bool readOnly;

  const GroceryListScreen({
    super.key,
    required this.householdId,
    required this.lang,
    this.readOnly = false,
  });

  @override
  State<GroceryListScreen> createState() => _GroceryListScreenState();
}

class _GroceryListScreenState extends State<GroceryListScreen> {
  late Future<List<GetGroceryItemsGroceryItems>> _itemsFuture;
  final _translator = GoogleTranslator();

  @override
  void initState() {
    super.initState();
    _loadItems();
  }

  void _loadItems() {
    _itemsFuture = AppData.fetchGroceryItems(widget.householdId);
  }

  Future<void> _addItem() async {
    final controller = TextEditingController();
    final lang = widget.lang.value;

    // Quick prompt for strings (since we don't have all translations in strings.dart yet, we'll hardcode basic ones for this modal)
    final addStr = lang == AppLanguage.si
        ? 'එකතු කරන්න'
        : lang == AppLanguage.ta
            ? 'சேர்'
            : 'Add Item';
    final cancelStr = lang == AppLanguage.si
        ? 'අවලංගු කරන්න'
        : lang == AppLanguage.ta
            ? 'ரத்துசெய்'
            : 'Cancel';
    final hintStr = lang == AppLanguage.si
        ? 'උදා: සීනි'
        : lang == AppLanguage.ta
            ? 'உதாரணம்: சர்க்கரை'
            : 'e.g., Sugar';

    final result = await showDialog<String>(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(addStr),
          content: TextField(
            controller: controller,
            decoration: InputDecoration(hintText: hintStr),
            autofocus: true,
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text(cancelStr),
            ),
            FilledButton(
              onPressed: () => Navigator.pop(context, controller.text.trim()),
              child: Text(addStr),
            ),
          ],
        );
      },
    );

    if (result != null && result.isNotEmpty) {
      // Show loading indicator
      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (_) => const Center(child: CircularProgressIndicator()),
      );

      try {
        String nameEn = result;
        String? nameSi;
        String? nameTa;

        if (lang == AppLanguage.si) {
          nameSi = result;
          final en = await _translator.translate(result, from: 'si', to: 'en');
          nameEn = en.text;
          final ta = await _translator.translate(result, from: 'si', to: 'ta');
          nameTa = ta.text;
        } else if (lang == AppLanguage.ta) {
          nameTa = result;
          final en = await _translator.translate(result, from: 'ta', to: 'en');
          nameEn = en.text;
          final si = await _translator.translate(result, from: 'ta', to: 'si');
          nameSi = si.text;
        } else {
          // English
          final si = await _translator.translate(result, from: 'en', to: 'si');
          nameSi = si.text;
          final ta = await _translator.translate(result, from: 'en', to: 'ta');
          nameTa = ta.text;
        }

        await AppData.addGroceryItem(
          householdId: widget.householdId,
          nameEn: nameEn,
          nameSi: nameSi,
          nameTa: nameTa,
        );

        if (mounted) Navigator.pop(context); // pop loading
        setState(() {
          _loadItems();
        });
      } catch (e) {
        if (mounted) Navigator.pop(context); // pop loading
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text('Error: $e')));
      }
    }
  }

  Future<void> _toggleBought(
      GetGroceryItemsGroceryItems item, bool isBought) async {
    try {
      await AppData.updateGroceryItemStatus(id: item.id, isBought: isBought);
      setState(() {
        _loadItems();
      });
    } catch (e) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text('Error: $e')));
    }
  }

  Future<void> _deleteItem(String id) async {
    try {
      await AppData.deleteGroceryItem(id: id);
      setState(() {
        _loadItems();
      });
    } catch (e) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text('Error: $e')));
    }
  }

  String _getItemName(GetGroceryItemsGroceryItems item, AppLanguage lang) {
    if (lang == AppLanguage.si &&
        item.nameSi != null &&
        item.nameSi!.isNotEmpty) return item.nameSi!;
    if (lang == AppLanguage.ta &&
        item.nameTa != null &&
        item.nameTa!.isNotEmpty) return item.nameTa!;
    return item.nameEn;
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<AppLanguage>(
      valueListenable: widget.lang,
      builder: (context, lang, _) {
        final title = lang == AppLanguage.si
            ? 'බඩු ලැයිස්තුව'
            : lang == AppLanguage.ta
                ? 'பொருட்கள் பட்டியல்'
                : 'Groceries';

        return Scaffold(
          appBar: AppBar(
            title: Text(title),
          ),
          body: FutureBuilder<List<GetGroceryItemsGroceryItems>>(
            future: _itemsFuture,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());
              }
              if (snapshot.hasError) {
                return Center(child: Text(snapshot.error.toString()));
              }
              final items = snapshot.data ?? [];
              if (items.isEmpty) {
                return RefreshIndicator(
                  onRefresh: () async {
                    setState(() {
                      _loadItems();
                    });
                    await _itemsFuture;
                  },
                  child: ListView(
                    children: const [
                      SizedBox(height: 100),
                      Center(child: Text('No items yet.')),
                    ],
                  ),
                );
              }
              return RefreshIndicator(
                onRefresh: () async {
                  setState(() {
                    _loadItems();
                  });
                  await _itemsFuture;
                },
                child: ListView.builder(
                  padding: const EdgeInsets.all(16),
                  itemCount: items.length,
                  itemBuilder: (context, index) {
                    final item = items[index];
                    return Card(
                      margin: const EdgeInsets.only(bottom: 8),
                      child: ListTile(
                        leading: Checkbox(
                          value: item.isBought,
                          onChanged: widget.readOnly ? null : (val) {
                            if (val != null) _toggleBought(item, val);
                          },
                        ),
                        title: Text(
                          _getItemName(item, lang),
                          style: TextStyle(
                            decoration:
                                item.isBought ? TextDecoration.lineThrough : null,
                            color: item.isBought ? Colors.grey : Colors.black87,
                          ),
                        ),
                        subtitle: Text(
                          'Added by ${item.addedBy.name}',
                          style: const TextStyle(fontSize: 12),
                        ),
                        trailing: IconButton(
                          icon:
                              const Icon(Icons.delete_outline, color: Colors.red),
                          onPressed:
                              widget.readOnly ? null : () => _deleteItem(item.id),
                        ),
                      ),
                    );
                  },
                ),
              );
            },
          ),
          floatingActionButton: widget.readOnly
              ? null
              : FloatingActionButton(
                  onPressed: _addItem,
                  child: const Icon(Icons.add),
                ),
        );
      },
    );
  }
}
