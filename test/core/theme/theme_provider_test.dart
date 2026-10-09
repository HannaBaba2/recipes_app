import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:recipes_app/core/theme/theme_provider.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  test('le mode par defaut est "system" quand rien n\'est stocke', () async {
    SharedPreferences.setMockInitialValues({});
    final prefs = await SharedPreferences.getInstance();
    final provider = ThemeProvider(prefs);

    expect(provider.mode, ThemeMode.system);
    expect(provider.isDark, false);
  });

  test('setMode persiste le choix dans SharedPreferences', () async {
    SharedPreferences.setMockInitialValues({});
    final prefs = await SharedPreferences.getInstance();
    final provider = ThemeProvider(prefs);

    await provider.setMode(ThemeMode.dark);

    expect(provider.mode, ThemeMode.dark);
    expect(provider.isDark, true);
    expect(prefs.getString('theme_mode'), 'dark');
  });

  test('le mode stocke est relu au demarrage (persistance)', () async {
    SharedPreferences.setMockInitialValues({'theme_mode': 'light'});
    final prefs = await SharedPreferences.getInstance();
    final provider = ThemeProvider(prefs);

    expect(provider.mode, ThemeMode.light);
  });

  test('toggleDark bascule directement entre clair et sombre', () async {
    SharedPreferences.setMockInitialValues({});
    final prefs = await SharedPreferences.getInstance();
    final provider = ThemeProvider(prefs);

    await provider.toggleDark(true);
    expect(provider.mode, ThemeMode.dark);

    await provider.toggleDark(false);
    expect(provider.mode, ThemeMode.light);
  });
}
