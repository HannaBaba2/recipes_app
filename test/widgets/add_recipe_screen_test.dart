import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:provider/provider.dart';
import 'package:recipes_app/data/models/recipe.dart';
import 'package:recipes_app/data/repositories/recipe_repository.dart';
import 'package:recipes_app/features/recipe_form/presentation/screens/add_recipe_screen.dart';
import 'package:recipes_app/features/recipes/providers/recipes_provider.dart';
import 'package:recipes_app/l10n/app_localizations.dart';

class _EmptyRepository implements RecipeRepository {
  @override
  Future<List<Recipe>> fetchRecipes() async => const [];

  @override
  void addRecipe(Recipe recipe) {}
}

Widget _buildScreen(Locale locale) {
  return ChangeNotifierProvider<RecipesProvider>(
    create: (_) => RecipesProvider(_EmptyRepository()),
    child: MaterialApp(
      // Locale forcee : la resolution systeme depend de l'environnement
      // (CI vs local) et rendrait ces tests non deterministes.
      locale: locale,
      supportedLocales: AppLocalizations.supportedLocales,
      localizationsDelegates: const [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      home: const AddRecipeScreen(),
    ),
  );
}

void main() {
  testWidgets('soumettre le formulaire vide affiche les erreurs en francais',
      (tester) async {
    await tester.pumpWidget(_buildScreen(const Locale('fr')));
    // Le delegate de traduction se charge de maniere asynchrone.
    await tester.pumpAndSettle();

    final submit = find.text('Enregistrer la recette');
    await tester.ensureVisible(submit);
    await tester.tap(submit);
    await tester.pump();

    expect(find.text('Le titre est requis.'), findsOneWidget);
    expect(find.text('La duree est requise.'), findsOneWidget);
    expect(find.text('La description est requise.'), findsOneWidget);
  });

  testWidgets('les erreurs de validation sont traduites en anglais',
      (tester) async {
    await tester.pumpWidget(_buildScreen(const Locale('en')));
    // Le delegate de traduction se charge de maniere asynchrone.
    await tester.pumpAndSettle();

    final submit = find.text('Save recipe');
    await tester.ensureVisible(submit);
    await tester.tap(submit);
    await tester.pump();

    expect(find.text('Title is required.'), findsOneWidget);
    expect(find.text('Duration is required.'), findsOneWidget);
    expect(find.text('Description is required.'), findsOneWidget);
  });
}
