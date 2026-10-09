import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:recipes_app/l10n/locale_provider.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  test('la locale est nulle (systeme) par defaut quand rien n\'est stocke',
      () async {
    SharedPreferences.setMockInitialValues({});
    final prefs = await SharedPreferences.getInstance();
    final provider = LocaleProvider(prefs);

    expect(provider.locale, isNull);
  });

  test('setLocale persiste le code de langue choisi', () async {
    SharedPreferences.setMockInitialValues({});
    final prefs = await SharedPreferences.getInstance();
    final provider = LocaleProvider(prefs);

    await provider.setLocale(const Locale('en'));

    expect(provider.locale?.languageCode, 'en');
    expect(prefs.getString('app_locale'), 'en');
  });

  test('setLocale(null) revient a la locale systeme et efface le stockage',
      () async {
    SharedPreferences.setMockInitialValues({'app_locale': 'fr'});
    final prefs = await SharedPreferences.getInstance();
    final provider = LocaleProvider(prefs);

    expect(provider.locale?.languageCode, 'fr');

    await provider.setLocale(null);

    expect(provider.locale, isNull);
    expect(prefs.getString('app_locale'), isNull);
  });
}
