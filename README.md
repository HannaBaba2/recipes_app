# Recipes App — Projet de certification Flutter (production-ready)

![CI](https://github.com/HannaBaba2/recipes_app/actions/workflows/ci.yml/badge.svg)
![Flutter](https://img.shields.io/badge/Flutter-%3E%3D3.19-02569B?logo=flutter&logoColor=white)
![Tests](https://img.shields.io/badge/tests-unit%20%2B%20widget%20%2B%20integration-success)
![License](https://img.shields.io/badge/license-MIT-informational)

Application Flutter de recettes de cuisine portee au niveau **production-ready** :
tests (unitaires, widgets, integration), internationalisation FR/EN, accessibilite,
optimisations de performance, CI/CD et documentation. Voir `CHANGELOG.md` pour l'historique.

## Fonctionnalites

- **5 ecrans** : Liste (recherche + filtres), Detail (parametre d'URL), Favoris,
  Ajout de recette (formulaire valide), Parametres (theme + langue)
- **Navigation GoRouter**, routes nommees, `pushNamed` pour les ecrans avec retour
- **Theme clair / sombre / systeme**, persiste (`shared_preferences`)
- **FR / EN**, persiste, bascule immediate depuis les Parametres
- **Accessibilite** : `Semantics` sur les elements interactifs
- Donnees separees de l'UI (`lib/data/`), aucune donnee en dur dans les widgets

## Captures d'ecran

Depose tes captures dans `assets/screenshots/` puis garde/adapte ce tableau :

| Liste | Detail | Formulaire | Parametres |
|---|---|---|---|
| ![liste](assets/screenshots/liste.png) | ![detail](assets/screenshots/detail.png) | ![formulaire](assets/screenshots/formulaire.png) | ![parametres](assets/screenshots/parametres.png) |

## Architecture

```
lib/
  data/            models/, mock/, repositories/ (interface + implementation mock)
  core/            theme/ (ThemeData + ThemeProvider), router/ (GoRouter, routes nommees)
  l10n/            app_localizations.dart (FR/EN + delegate), locale_provider.dart
  features/
    recipes/       providers/recipes_provider.dart, presentation/screens/ (liste, detail, favoris)
    recipe_form/   validators.dart (fonctions pures), presentation/screens/add_recipe_screen.dart
    settings/      presentation/screens/settings_screen.dart
  widgets/         RecipeCard, SearchField, CategoryFilterChips, EmptyState, SectionHeader
  bootstrap.dart   assemblage des providers (partage entre main() et les tests d'integration)
  app.dart, main.dart
```

## Internationalisation

Systeme manuel (sans `flutter gen-l10n`) : table de chaines FR/EN (textes, categories, difficultes, messages de validation, libelles d'accessibilite) + `LocalizationsDelegate`,
plus les delegates Material/Cupertino standards. Langue modifiable et persistee depuis les Parametres.

## Accessibilite

Boutons favoris, filtres, recherche, FAB, champs de formulaire et selecteurs de theme/langue
portent un `Semantics` avec label explicite. Les etats vides sont des `liveRegion`.

## Performance

- Listes/grilles en constructeurs `.builder` (lazy : seuls les elements visibles sont construits)
- `Image.network(cacheWidth: 300)` + `loadingBuilder` dans `RecipeCard` (decodage a taille de miniature)
- `RepaintBoundary` par carte de grille
- Widgets `const` systematiques, `context.watch` au plus pres de la consommation

## Installation

Prerequis : Flutter >= 3.19.

```bash
git clone <url-de-ton-repo>
cd recipes_app
flutter create .        # genere android/, web/, linux/... (absents du depot)
flutter pub get
flutter run
```

## Tests

```bash
flutter test                                   # unitaires + widgets
flutter test --coverage                        # comme en CI
flutter test integration_test/app_test.dart    # integration (appareil/emulateur connecte, ou -d chrome)
```

| Type | Emplacement | Nombre |
|---|---|---|
| Unitaires | `test/data`, `test/core`, `test/features/**` | 34 |
| Widgets | `test/widgets/`, `test/widget_test.dart` | 11 |
| Integration | `integration_test/app_test.dart` | 3 |

Faux objets ecrits a la main (pas de framework de mock). Les tests d'integration utilisent
`lib/bootstrap.dart`, donc le meme assemblage de providers que l'app reelle.

## CI/CD

`.github/workflows/ci.yml` (push/PR sur `main`) : `flutter pub get` → format (informatif) →
`flutter analyze --no-fatal-infos` → `flutter test --coverage` → upload de la couverture → build d'un APK de demonstration (artefact `recipes-app-apk`, job non bloquant).
Les tests d'integration ne tournent pas en CI (emulateur requis) ; a lancer localement.

## APK de demonstration

```bash
flutter build apk --release
# build/app/outputs/flutter-apk/app-release.apk -> a deposer dans GitHub > Releases
```
