import 'package:flutter/material.dart';
import 'package:translator/translator.dart';

import '../../core/app_data.dart';
import '../../core/auto_refresh.dart';
import '../../core/app_language.dart';
import '../../core/strings.dart';
import '../../core/theme.dart';
import '../../dataconnect_generated/sahakara.dart' hide AppLanguage;

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

/// The household's one shared list. The owner and every accepted maid see
/// the same items, and the screen stays subscribed so changes made on
/// someone else's phone show up here without a manual refresh.
class _GroceryListScreenState extends State<GroceryListScreen> {
  late Stream<List<GetGroceryItemsGroceryItems>> _items;
  final _translator = GoogleTranslator();

  @override
  void initState() {
    super.initState();
    _items = AppData.watchGroceryItems(widget.householdId);
  }

  /// Refetches the list. The result also lands on [_items], so this covers
  /// pull-to-refresh and gives instant feedback after our own changes.
  Future<void> _refresh() async {
    await AppData.fetchGroceryItems(widget.householdId);
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

    if (!mounted) return;
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

        if (!mounted) return;
        Navigator.pop(context);
        await _refresh();
      } catch (e) {
        if (!mounted) return;
        Navigator.pop(context);
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text('Error: $e')));
      }
    }
  }

  Future<void> _toggleBought(
      GetGroceryItemsGroceryItems item, bool isBought) async {
    try {
      await AppData.updateGroceryItemStatus(
          id: item.id, householdId: widget.householdId, isBought: isBought);
      await _refresh();
    } catch (e) {
      if (!mounted) return;
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text('Error: $e')));
    }
  }

  Future<void> _deleteItem(String id) async {
    try {
      await AppData.deleteGroceryItem(
          id: id, householdId: widget.householdId);
      await _refresh();
    } catch (e) {
      if (!mounted) return;
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text('Error: $e')));
    }
  }

  String _getItemName(GetGroceryItemsGroceryItems item, AppLanguage lang) {
    if (lang == AppLanguage.si &&
        item.nameSi != null &&
        item.nameSi!.isNotEmpty) {
      return item.nameSi!;
    }
    if (lang == AppLanguage.ta &&
        item.nameTa != null &&
        item.nameTa!.isNotEmpty) {
      return item.nameTa!;
    }
    return item.nameEn;
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<AppLanguage>(
      valueListenable: widget.lang,
      builder: (context, lang, _) {
        // No app bar of its own: HomeShell's top bar already shows the
        // tab's label.
        return Scaffold(
          // The subscription below usually pushes changes on its own; this
          // is the fallback for when it misses one.
          body: AutoRefresh(
            onRefresh: _refresh,
            child: StreamBuilder<List<GetGroceryItemsGroceryItems>>(
              stream: _items,
              builder: (context, snapshot) {
                if (!snapshot.hasData && !snapshot.hasError) {
                  return const Center(child: CircularProgressIndicator());
                }
                if (snapshot.hasError) {
                  return Center(child: Text(snapshot.error.toString()));
                }
                final items = snapshot.data ?? [];
                if (items.isEmpty) {
                  return RefreshIndicator(
                    onRefresh: _refresh,
                    child: ListView(
                      children: [
                        const SizedBox(height: 100),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 32),
                          child: Text(
                            Strings.of('groceryEmpty', lang),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ],
                    ),
                  );
                }
                return RefreshIndicator(
                  onRefresh: _refresh,
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
                              color: item.isBought ? Colors.black38 : Colors.black87,
                            ),
                          ),
                          subtitle: Text(
                            [
                              Strings.of('groceryAddedBy', lang)
                                  .replaceFirst('{name}', item.addedBy.name),
                              if (item.isBought && item.boughtBy != null)
                                Strings.of('groceryBoughtBy', lang)
                                    .replaceFirst('{name}', item.boughtBy!.name),
                            ].join(' · '),
                            style: const TextStyle(fontSize: 12),
                          ),
                          trailing: IconButton(
                            icon:
                                const Icon(Icons.delete_outline, color: brandMaroon),
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
