# Changelog

Toutes les modifications notables de ce projet sont documentees dans ce fichier.
Format inspire de [Keep a Changelog](https://keepachangelog.com/fr/1.0.0/).

## [2.0.1] - Fiabilisation (tests, i18n, CI)

### Ajoute
- Internationalisation complete : categories, difficultes, messages de
  validation du formulaire et libelles d'accessibilite sont desormais traduits
  FR/EN (les validateurs retournent des codes `FormError`, traduits par l'UI).
- Tests : repository (`RecipeRepositoryMock`), localisation FR/EN, smoke test
  de l'application (`test/widget_test.dart`), changement de langue, validation
  en anglais, troisieme test d'integration (favoris).
- Job CI de build d'un APK de demonstration (artefact telechargeable).

### Corrige
- `GoRouter` n'est plus un singleton global : une instance par `App`, ce qui
  isole l'etat de navigation entre les tests.
- Formulaire d'ajout : `SingleChildScrollView` + `Column` (au lieu d'une
  `ListView` paresseuse) pour que tous les champs soient valides a la soumission ;
  selecteurs sans `DropdownButtonFormField.value` (API depreciee).
- `addRecipe` fait partie de l'interface `RecipeRepository` (plus de cast).
- Tests de widgets : cibles de recherche robustes (plus de `byType(InkWell)` ni
  de `FilledButton` ambigus), locale forcee pour des resultats deterministes.
- Fichier `test/widget_test.dart` fourni, pour que `flutter create .` ne genere
  pas le test de compteur par defaut (qui ne compile pas avec cette app).

## [2.0.0] - Production-ready

### Ajoute
- Internationalisation FR/EN (`lib/l10n/`), avec selecteur de langue persiste
  dans l'ecran Parametres.
- Accessibilite : labels semantiques (`Semantics`) sur tous les elements
  interactifs (boutons, champs de recherche, filtres, favoris).
- Suite de tests complete : tests unitaires etendus (providers, modele,
  validateurs du formulaire), tests de widgets (composants reutilisables +
  ecran de formulaire), tests d'integration (`integration_test/`) couvrant
  deux parcours utilisateur complets.
- CI/CD : workflow GitHub Actions (`flutter analyze` + `flutter test` sur
  chaque push/PR).
- Optimisations de performance : `cacheWidth` sur les images de la grille
  (decodage a une resolution adaptee a la miniature plutot que l'image
  complete), `RepaintBoundary` par carte de la grille,
  widgets `const` generalises pour limiter les rebuilds.
- `lib/bootstrap.dart` : point d'assemblage unique des providers, partage
  entre `main.dart` et les tests d'integration (evite toute divergence entre
  l'app reelle et celle testee).
- `lib/features/recipe_form/validators.dart` : validateurs de formulaire
  extraits en fonctions pures, testables independamment du widget.

### Corrige
- **Bug de navigation critique** : les ecrans Detail / Favoris / Parametres /
  Ajout etaient ouverts avec `context.goNamed(...)` (qui remplace la pile de
  navigation) au lieu de `context.pushNamed(...)`. Consequence : le bouton
  retour et `context.pop()` (utilise par le formulaire d'ajout) ne
  fonctionnaient pas de maniere fiable. Corrige en utilisant `pushNamed` pour
  toute navigation qui doit pouvoir revenir en arriere.
- Remplacement de `RadioListTile` (selection du theme) par `SegmentedButton`
  pour rester sur des widgets Material 3 non depreciees.

### Modifie
- Version du package portee a `2.0.0` pour marquer le passage au niveau
  production-ready.

## [1.0.1] - Correctifs post-revue

### Corrige
- Import manquant de `data/models/recipe.dart` dans `recipe_detail_screen.dart`
  provoquant une erreur de compilation sur les extensions `.label`
  (`RecipeCategoryLabel`, `DifficultyLabel`) : en Dart, une extension method
  doit etre importee explicitement dans chaque fichier qui l'utilise, meme si
  le type qu'elle etend est deja visible via un autre import transitif.
- Nom de parametre incorrect sur `DropdownButtonFormField`
  (`initialValue` au lieu de `value`).

## [1.0.0] - Version initiale (navigation multi-ecrans)

### Ajoute
- 5 ecrans : liste (recherche + filtres), detail, favoris, ajout de recette
  (formulaire valide), parametres.
- Navigation via GoRouter avec routes nommees et parametre de chemin
  (`/recipe/:id`).
- Theme clair / sombre / systeme, persiste via `shared_preferences`.
- Grille responsive (2 colonnes mobile, 3-4 colonnes tablette/desktop).
- 5 widgets reutilisables (`RecipeCard`, `SearchField`,
  `CategoryFilterChips`, `EmptyState`, `SectionHeader`).
- Premiers tests unitaires sur `RecipesProvider` (recherche, filtre,
  favoris, ajout).
