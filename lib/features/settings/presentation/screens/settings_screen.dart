import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:recipes_app/core/theme/theme_provider.dart';
import 'package:recipes_app/l10n/app_localizations.dart';
import 'package:recipes_app/l10n/locale_provider.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final themeProvider = context.watch<ThemeProvider>();
    final localeProvider = context.watch<LocaleProvider>();
    final l10n = AppLocalizations.of(context);
    final currentLanguageCode = localeProvider.locale?.languageCode ??
        Localizations.localeOf(context).languageCode;

    return Scaffold(
      appBar: AppBar(title: Text(l10n.settingsTitle)),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          Text(l10n.themeSectionTitle,
              style: const TextStyle(fontWeight: FontWeight.bold)),
          const SizedBox(height: 8),
          Semantics(
            label: l10n.themeSectionTitle,
            child: SegmentedButton<ThemeMode>(
              segments: [
                ButtonSegment(
                  value: ThemeMode.light,
                  label: Text(l10n.themeLight),
                  icon: const Icon(Icons.light_mode_outlined),
                ),
                ButtonSegment(
                  value: ThemeMode.dark,
                  label: Text(l10n.themeDark),
                  icon: const Icon(Icons.dark_mode_outlined),
                ),
                ButtonSegment(
                  value: ThemeMode.system,
                  label: Text(l10n.themeSystem),
                  icon: const Icon(Icons.settings_suggest_outlined),
                ),
              ],
              selected: {themeProvider.mode},
              onSelectionChanged: (selection) =>
                  themeProvider.setMode(selection.first),
            ),
          ),
          const SizedBox(height: 24),
          Text(l10n.languageSectionTitle,
              style: const TextStyle(fontWeight: FontWeight.bold)),
          const SizedBox(height: 8),
          Semantics(
            label: l10n.languageSectionTitle,
            child: SegmentedButton<String>(
              segments: const [
                ButtonSegment(value: 'fr', label: Text('Francais')),
                ButtonSegment(value: 'en', label: Text('English')),
              ],
              selected: {currentLanguageCode == 'en' ? 'en' : 'fr'},
              onSelectionChanged: (selection) =>
                  localeProvider.setLocale(Locale(selection.first)),
            ),
          ),
          const SizedBox(height: 24),
          const Divider(),
          const SizedBox(height: 8),
          Text(
            l10n.aboutText,
            style: const TextStyle(color: Colors.grey, fontSize: 12),
          ),
        ],
      ),
    );
  }
}
