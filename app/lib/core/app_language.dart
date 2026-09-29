import 'package:flutter/foundation.dart';

enum AppLanguage { en, si, ta }

extension AppLanguageLabel on AppLanguage {
  String get short => switch (this) {
    AppLanguage.en => 'EN',
    AppLanguage.si => 'සි',
    AppLanguage.ta => 'த',
  };

  String get label => switch (this) {
    AppLanguage.en => 'English',
    AppLanguage.si => 'සිංහල',
    AppLanguage.ta => 'தமிழ்',
  };
}

/// Holds the user's chosen display language for the whole app.
/// Deliberately simple (no localization codegen) so it's easy to extend
/// alongside [Strings] as more screens are built.
class LanguageController extends ValueNotifier<AppLanguage> {
  LanguageController() : super(AppLanguage.en);
}

/// The [lang] version of a trilingual name, falling back to English when
/// that translation hasn't been added yet.
String pickName(
  AppLanguage lang, {
  required String en,
  String? si,
  String? ta,
}) {
  return switch (lang) {
    AppLanguage.si => si ?? en,
    AppLanguage.ta => ta ?? en,
    AppLanguage.en => en,
  };
}
