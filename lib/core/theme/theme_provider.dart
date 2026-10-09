import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

const _themeModeKey = 'theme_mode';

/// Holds the active [ThemeMode] and persists the user's choice so it
/// survives an app restart.
class ThemeProvider extends ChangeNotifier {
  final SharedPreferences _prefs;
  ThemeMode _mode;

  ThemeProvider(this._prefs) : _mode = _readInitialMode(_prefs);

  static ThemeMode _readInitialMode(SharedPreferences prefs) {
    final stored = prefs.getString(_themeModeKey);
    switch (stored) {
      case 'light':
        return ThemeMode.light;
      case 'dark':
        return ThemeMode.dark;
      default:
        return ThemeMode.system;
    }
  }

  ThemeMode get mode => _mode;

  bool get isDark => _mode == ThemeMode.dark;

  Future<void> setMode(ThemeMode mode) async {
    _mode = mode;
    notifyListeners();
    await _prefs.setString(_themeModeKey, mode.name);
  }

  Future<void> toggleDark(bool enableDark) =>
      setMode(enableDark ? ThemeMode.dark : ThemeMode.light);
}
