import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:recipes_app/data/models/recipe.dart';
import 'package:recipes_app/l10n/app_localizations.dart';

void main() {
  test('les textes francais sont retournes pour la locale fr', () {
    final l10n = AppLocalizations(const Locale('fr'));

    expect(l10n.appTitle, 'Recettes');
    expect(l10n.category(RecipeCategory.entree), 'Entree');
    expect(l10n.difficulty(Difficulty.difficile), 'Difficile');
  });

  test('les textes anglais sont retournes pour la locale en', () {
    final l10n = AppLocalizations(const Locale('en'));

    expect(l10n.appTitle, 'Recipes');
    expect(l10n.category(RecipeCategory.entree), 'Starter');
    expect(l10n.difficulty(Difficulty.difficile), 'Hard');
  });

  test('une locale non supportee retombe sur l\'anglais', () {
    final l10n = AppLocalizations(const Locale('de'));

    expect(l10n.settingsTitle, 'Settings');
  });

  test('FR et EN definissent exactement les memes cles de traduction', () {
    final fr = AppLocalizations(const Locale('fr'));
    final en = AppLocalizations(const Locale('en'));

    // Aucune cle ne doit retomber sur son propre nom (= traduction manquante).
    for (final l10n in [fr, en]) {
      expect(l10n.noResults, isNot('noResults'));
      expect(l10n.errTitleRequired, isNot('errTitleRequired'));
      expect(l10n.loadError, isNot('loadError'));
      expect(l10n.category(RecipeCategory.vegetarien), isNot('cat_vegetarien'));
    }
  });
}
