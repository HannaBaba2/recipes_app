import 'package:flutter/material.dart';
import 'package:recipes_app/data/models/recipe.dart';

/// Minimal, dependency-free localization system: a static string table per
/// locale plus a [LocalizationsDelegate]. Avoids `flutter gen-l10n`
/// code generation so the project builds deterministically everywhere.
class AppLocalizations {
  final Locale locale;
  AppLocalizations(this.locale);

  static AppLocalizations of(BuildContext context) {
    final localizations =
        Localizations.of<AppLocalizations>(context, AppLocalizations);
    assert(localizations != null, 'No AppLocalizations found in context');
    return localizations!;
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

  static const supportedLocales = [Locale('fr'), Locale('en')];

  static final Map<String, Map<String, String>> _strings = {
    'fr': {
      'appTitle': 'Recettes',
      'favoritesTitle': 'Mes favoris',
      'settingsTitle': 'Parametres',
      'addRecipeTitle': 'Ajouter une recette',
      'searchHint': 'Rechercher une recette...',
      'categoryAll': 'Toutes',
      'noResults': 'Aucune recette ne correspond a votre recherche.',
      'noFavorites': 'Aucun favori pour le moment.',
      'addButton': 'Ajouter',
      'saveRecipe': 'Enregistrer la recette',
      'fieldTitle': 'Titre',
      'fieldDuration': 'Duree (minutes)',
      'fieldCategory': 'Categorie',
      'fieldDifficulty': 'Difficulte',
      'fieldDescription': 'Description',
      'fieldIngredients': 'Ingredients (separes par des virgules)',
      'hintIngredients': 'Ex: Tomates, Basilic, Mozzarella',
      'ingredientsPlaceholder': 'Non renseigne',
      'descriptionSection': 'Description',
      'ingredientsSection': 'Ingredients',
      'themeSectionTitle': 'Apparence',
      'themeLight': 'Clair',
      'themeDark': 'Sombre',
      'themeSystem': 'Systeme',
      'languageSectionTitle': 'Langue',
      'recipeNotFound': 'Recette introuvable.',
      'addToFavorites': 'Ajouter aux favoris',
      'removeFromFavorites': 'Retirer des favoris',
      'recipeAdded': 'a ete ajoutee au catalogue.',
      'loadError': 'Impossible de charger les recettes.',
      'aboutText': 'App de recettes - projet de certification Flutter.',
      'cat_entree': 'Entree',
      'cat_plat': 'Plat',
      'cat_dessert': 'Dessert',
      'cat_vegetarien': 'Vegetarien',
      'diff_facile': 'Facile',
      'diff_moyen': 'Moyen',
      'diff_difficile': 'Difficile',
      'errTitleRequired': 'Le titre est requis.',
      'errTitleTooShort': 'Le titre doit contenir au moins 3 caracteres.',
      'errDurationRequired': 'La duree est requise.',
      'errDurationInvalid': 'Entrez un nombre entier valide.',
      'errDurationNotPositive': 'La duree doit etre superieure a 0.',
      'errDescriptionRequired': 'La description est requise.',
      'errDescriptionTooShort':
          'Decrivez la recette en au moins 10 caracteres.',
    },
    'en': {
      'appTitle': 'Recipes',
      'favoritesTitle': 'My favorites',
      'settingsTitle': 'Settings',
      'addRecipeTitle': 'Add a recipe',
      'searchHint': 'Search a recipe...',
      'categoryAll': 'All',
      'noResults': 'No recipe matches your search.',
      'noFavorites': 'No favorites yet.',
      'addButton': 'Add',
      'saveRecipe': 'Save recipe',
      'fieldTitle': 'Title',
      'fieldDuration': 'Duration (minutes)',
      'fieldCategory': 'Category',
      'fieldDifficulty': 'Difficulty',
      'fieldDescription': 'Description',
      'fieldIngredients': 'Ingredients (comma separated)',
      'hintIngredients': 'E.g. Tomatoes, Basil, Mozzarella',
      'ingredientsPlaceholder': 'Not provided',
      'descriptionSection': 'Description',
      'ingredientsSection': 'Ingredients',
      'themeSectionTitle': 'Appearance',
      'themeLight': 'Light',
      'themeDark': 'Dark',
      'themeSystem': 'System',
      'languageSectionTitle': 'Language',
      'recipeNotFound': 'Recipe not found.',
      'addToFavorites': 'Add to favorites',
      'removeFromFavorites': 'Remove from favorites',
      'recipeAdded': 'has been added to the catalog.',
      'loadError': 'Unable to load recipes.',
      'aboutText': 'Recipes app - Flutter certification project.',
      'cat_entree': 'Starter',
      'cat_plat': 'Main course',
      'cat_dessert': 'Dessert',
      'cat_vegetarien': 'Vegetarian',
      'diff_facile': 'Easy',
      'diff_moyen': 'Medium',
      'diff_difficile': 'Hard',
      'errTitleRequired': 'Title is required.',
      'errTitleTooShort': 'Title must be at least 3 characters long.',
      'errDurationRequired': 'Duration is required.',
      'errDurationInvalid': 'Enter a valid whole number.',
      'errDurationNotPositive': 'Duration must be greater than 0.',
      'errDescriptionRequired': 'Description is required.',
      'errDescriptionTooShort':
          'Describe the recipe in at least 10 characters.',
    },
  };

  String _t(String key) {
    final languageCode =
        _strings.containsKey(locale.languageCode) ? locale.languageCode : 'en';
    return _strings[languageCode]?[key] ?? key;
  }

  String get appTitle => _t('appTitle');
  String get favoritesTitle => _t('favoritesTitle');
  String get settingsTitle => _t('settingsTitle');
  String get addRecipeTitle => _t('addRecipeTitle');
  String get searchHint => _t('searchHint');
  String get categoryAll => _t('categoryAll');
  String get noResults => _t('noResults');
  String get noFavorites => _t('noFavorites');
  String get addButton => _t('addButton');
  String get saveRecipe => _t('saveRecipe');
  String get fieldTitle => _t('fieldTitle');
  String get fieldDuration => _t('fieldDuration');
  String get fieldCategory => _t('fieldCategory');
  String get fieldDifficulty => _t('fieldDifficulty');
  String get fieldDescription => _t('fieldDescription');
  String get fieldIngredients => _t('fieldIngredients');
  String get hintIngredients => _t('hintIngredients');
  String get ingredientsPlaceholder => _t('ingredientsPlaceholder');
  String get descriptionSection => _t('descriptionSection');
  String get ingredientsSection => _t('ingredientsSection');
  String get themeSectionTitle => _t('themeSectionTitle');
  String get themeLight => _t('themeLight');
  String get themeDark => _t('themeDark');
  String get themeSystem => _t('themeSystem');
  String get languageSectionTitle => _t('languageSectionTitle');
  String get recipeNotFound => _t('recipeNotFound');
  String get addToFavorites => _t('addToFavorites');
  String get removeFromFavorites => _t('removeFromFavorites');
  String get recipeAdded => _t('recipeAdded');
  String get loadError => _t('loadError');
  String get aboutText => _t('aboutText');
  String get errTitleRequired => _t('errTitleRequired');
  String get errTitleTooShort => _t('errTitleTooShort');
  String get errDurationRequired => _t('errDurationRequired');
  String get errDurationInvalid => _t('errDurationInvalid');
  String get errDurationNotPositive => _t('errDurationNotPositive');
  String get errDescriptionRequired => _t('errDescriptionRequired');
  String get errDescriptionTooShort => _t('errDescriptionTooShort');

  String category(RecipeCategory category) => _t('cat_${category.name}');

  String difficulty(Difficulty difficulty) => _t('diff_${difficulty.name}');
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  bool isSupported(Locale locale) => AppLocalizations.supportedLocales
      .map((l) => l.languageCode)
      .contains(locale.languageCode);

  @override
  Future<AppLocalizations> load(Locale locale) async =>
      AppLocalizations(locale);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}
