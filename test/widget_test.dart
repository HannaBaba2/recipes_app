import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:recipes_app/bootstrap.dart';
import 'package:recipes_app/data/models/recipe.dart';
import 'package:recipes_app/data/repositories/recipe_repository.dart';

class _FakeRepository implements RecipeRepository {
  final List<Recipe> _items = [
    const Recipe(
      id: 't1',
      title: 'Tarte test',
      description: 'Une tarte pour les tests.',
      imageUrl: 'https://example.com/t1.png',
      category: RecipeCategory.dessert,
      difficulty: Difficulty.facile,
      durationMinutes: 30,
      rating: 4.0,
      ingredients: ['Farine', 'Beurre'],
    ),
  ];

  @override
  Future<List<Recipe>> fetchRecipes() async => List.of(_items);

  @override
  void addRecipe(Recipe recipe) => _items.insert(0, recipe);
}

Future<Widget> _app() async {
  SharedPreferences.setMockInitialValues({'app_locale': 'fr'});
  final prefs = await SharedPreferences.getInstance();
  return buildApp(prefs, repositoryOverride: _FakeRepository());
}

void main() {
  testWidgets("l'application demarre et affiche le catalogue", (tester) async {
    await tester.pumpWidget(await _app());
    await tester.pumpAndSettle();

    expect(find.text('Recettes'), findsOneWidget);
    expect(find.text('Tarte test'), findsOneWidget);
  });

  testWidgets(
      'changer la langue dans les parametres traduit immediatement les ecrans',
      (tester) async {
    await tester.pumpWidget(await _app());
    await tester.pumpAndSettle();

    await tester.tap(find.byTooltip('Parametres'));
    await tester.pumpAndSettle();
    expect(find.text('Parametres'), findsOneWidget);

    await tester.tap(find.text('English'));
    await tester.pumpAndSettle();

    expect(find.text('Settings'), findsOneWidget);
    expect(find.text('Appearance'), findsOneWidget);
  });
}
