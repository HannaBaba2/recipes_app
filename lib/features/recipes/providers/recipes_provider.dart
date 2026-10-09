import 'package:flutter/foundation.dart';
import 'package:recipes_app/data/models/recipe.dart';
import 'package:recipes_app/data/repositories/recipe_repository.dart';

class RecipesProvider extends ChangeNotifier {
  final RecipeRepository _repository;

  RecipesProvider(this._repository);

  List<Recipe> _allRecipes = [];
  bool isLoading = true;
  String? errorMessage;

  String searchQuery = '';
  RecipeCategory? categoryFilter;
  final Set<String> _favoriteIds = {};

  List<Recipe> get allRecipes => _allRecipes;

  bool get hasError => errorMessage != null;

  List<Recipe> get filteredRecipes {
    final query = searchQuery.trim().toLowerCase();
    return _allRecipes.where((recipe) {
      final matchesQuery =
          query.isEmpty || recipe.title.toLowerCase().contains(query);
      final matchesCategory =
          categoryFilter == null || recipe.category == categoryFilter;
      return matchesQuery && matchesCategory;
    }).toList();
  }

  List<Recipe> get favoriteRecipes =>
      _allRecipes.where((recipe) => _favoriteIds.contains(recipe.id)).toList();

  bool isFavorite(String recipeId) => _favoriteIds.contains(recipeId);

  Recipe? recipeById(String id) {
    for (final recipe in _allRecipes) {
      if (recipe.id == id) return recipe;
    }
    return null;
  }

  Future<void> load() async {
    isLoading = true;
    errorMessage = null;
    notifyListeners();

    try {
      _allRecipes = await _repository.fetchRecipes();
    } catch (e) {
      errorMessage = 'load_error';
    }

    isLoading = false;
    notifyListeners();
  }

  void setSearchQuery(String query) {
    searchQuery = query;
    notifyListeners();
  }

  void setCategoryFilter(RecipeCategory? category) {
    categoryFilter = category;
    notifyListeners();
  }

  void toggleFavorite(String recipeId) {
    if (_favoriteIds.contains(recipeId)) {
      _favoriteIds.remove(recipeId);
    } else {
      _favoriteIds.add(recipeId);
    }
    notifyListeners();
  }

  /// Called by the "add recipe" form once validated.
  void addRecipe(Recipe recipe) {
    _repository.addRecipe(recipe);
    _allRecipes = [recipe, ..._allRecipes];
    notifyListeners();
  }
}
