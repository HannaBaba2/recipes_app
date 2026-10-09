import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:recipes_app/core/theme/theme_provider.dart';
import 'package:recipes_app/data/repositories/recipe_repository.dart';
import 'package:recipes_app/features/recipes/providers/recipes_provider.dart';
import 'package:recipes_app/l10n/locale_provider.dart';
import 'package:recipes_app/app.dart';

/// Builds the fully-wired app widget (providers + App). Factored out of
/// `main()` so integration tests exercise the exact same provider setup as
/// production, instead of duplicating (and risking drifting from) it.
Widget buildApp(SharedPreferences prefs,
    {RecipeRepository? repositoryOverride}) {
  return MultiProvider(
    providers: [
      ChangeNotifierProvider<ThemeProvider>(
          create: (_) => ThemeProvider(prefs)),
      ChangeNotifierProvider<LocaleProvider>(
          create: (_) => LocaleProvider(prefs)),
      ChangeNotifierProvider<RecipesProvider>(
        create: (_) =>
            RecipesProvider(repositoryOverride ?? RecipeRepositoryMock()),
      ),
    ],
    child: const App(),
  );
}
