import 'package:flutter_test/flutter_test.dart';
import 'package:recipes_app/data/mock/recipes_mock.dart';
import 'package:recipes_app/data/models/recipe.dart';
import 'package:recipes_app/data/repositories/recipe_repository.dart';

const _extra = Recipe(
  id: 'extra',
  title: 'Recette extra',
  description: 'desc',
  imageUrl: 'https://example.com/e.png',
  category: RecipeCategory.plat,
  difficulty: Difficulty.moyen,
  durationMinutes: 40,
  rating: 3.5,
  ingredients: ['Ingredient'],
);

void main() {
  test('fetchRecipes retourne tout le catalogue mock', () async {
    final repository = RecipeRepositoryMock();

    final recipes = await repository.fetchRecipes();

    expect(recipes.length, mockRecipes.length);
    expect(recipes.first.id, mockRecipes.first.id);
  });

  test('addRecipe ajoute la recette en tete du catalogue', () async {
    final repository = RecipeRepositoryMock();

    repository.addRecipe(_extra);
    final recipes = await repository.fetchRecipes();

    expect(recipes.length, mockRecipes.length + 1);
    expect(recipes.first.id, 'extra');
  });

  test('la liste retournee est non modifiable (protege l\'etat interne)',
      () async {
    final repository = RecipeRepositoryMock();

    final recipes = await repository.fetchRecipes();

    expect(() => recipes.add(_extra), throwsUnsupportedError);
  });
}
