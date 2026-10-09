import 'package:recipes_app/data/mock/recipes_mock.dart';
import 'package:recipes_app/data/models/recipe.dart';

/// Abstraction over the recipe data source, so the provider layer never
/// depends on how/where the data actually comes from.
abstract class RecipeRepository {
  Future<List<Recipe>> fetchRecipes();

  void addRecipe(Recipe recipe);
}

class RecipeRepositoryMock implements RecipeRepository {
  final List<Recipe> _recipes = List.of(mockRecipes);

  @override
  Future<List<Recipe>> fetchRecipes() async {
    await Future.delayed(const Duration(milliseconds: 500));
    return List.unmodifiable(_recipes);
  }

  @override
  void addRecipe(Recipe recipe) {
    _recipes.insert(0, recipe);
  }
}
