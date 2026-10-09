import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

const _localeKey = 'app_locale';

/// Holds the active app [Locale] and persists the user's choice.
/// `null` means "follow the system locale".
class LocaleProvider extends ChangeNotifier {
  final SharedPreferences _prefs;
  Locale? _locale;

  LocaleProvider(this._prefs) : _locale = _readInitialLocale(_prefs);

  static Locale? _readInitialLocale(SharedPreferences prefs) {
    final stored = prefs.getString(_localeKey);
    if (stored == null) return null;
    return Locale(stored);
  }

  Locale? get locale => _locale;

  Future<void> setLocale(Locale? locale) async {
    _locale = locale;
    notifyListeners();
    if (locale == null) {
      await _prefs.remove(_localeKey);
    } else {
      await _prefs.setString(_localeKey, locale.languageCode);
    }
  }
}
