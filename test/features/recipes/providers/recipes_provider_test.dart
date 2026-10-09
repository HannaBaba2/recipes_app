import 'package:flutter_test/flutter_test.dart';
import 'package:recipes_app/data/models/recipe.dart';
import 'package:recipes_app/data/repositories/recipe_repository.dart';
import 'package:recipes_app/features/recipes/providers/recipes_provider.dart';

/// Simple fake repository (no mocking framework needed): returns a fixed,
/// known list so the provider's own filtering/sorting logic can be tested
/// in isolation.
class _FakeRecipeRepository implements RecipeRepository {
  @override
  void addRecipe(Recipe recipe) {}

  @override
  Future<List<Recipe>> fetchRecipes() async => const [
        Recipe(
          id: 'a',
          title: 'Salade grecque',
          description: 'desc',
          imageUrl: 'https://example.com/a.png',
          category: RecipeCategory.entree,
          difficulty: Difficulty.facile,
          durationMinutes: 10,
          rating: 4.0,
          ingredients: ['Feta', 'Tomates'],
        ),
        Recipe(
          id: 'b',
          title: 'Boeuf bourguignon',
          description: 'desc',
          imageUrl: 'https://example.com/b.png',
          category: RecipeCategory.plat,
          difficulty: Difficulty.difficile,
          durationMinutes: 180,
          rating: 4.9,
          ingredients: ['Boeuf', 'Vin rouge'],
        ),
      ];
}

void main() {
  late RecipesProvider provider;

  setUp(() {
    provider = RecipesProvider(_FakeRecipeRepository());
  });

  test('load() peuple la liste des recettes et met a jour isLoading', () async {
    expect(provider.isLoading, true);

    await provider.load();

    expect(provider.isLoading, false);
    expect(provider.allRecipes.length, 2);
    expect(provider.filteredRecipes.length, 2);
  });

  test('setSearchQuery filtre par titre (insensible a la casse)', () async {
    await provider.load();

    provider.setSearchQuery('boeuf');

    expect(provider.filteredRecipes.length, 1);
    expect(provider.filteredRecipes.first.id, 'b');
  });

  test('setCategoryFilter ne garde que la categorie selectionnee', () async {
    await provider.load();

    provider.setCategoryFilter(RecipeCategory.entree);

    expect(provider.filteredRecipes.map((r) => r.id).toList(), ['a']);
  });

  test('toggleFavorite ajoute puis retire une recette des favoris', () async {
    await provider.load();

    expect(provider.isFavorite('a'), false);

    provider.toggleFavorite('a');
    expect(provider.isFavorite('a'), true);
    expect(provider.favoriteRecipes.map((r) => r.id).toList(), ['a']);

    provider.toggleFavorite('a');
    expect(provider.isFavorite('a'), false);
    expect(provider.favoriteRecipes, isEmpty);
  });

  test('addRecipe ajoute la nouvelle recette en tete de liste', () async {
    await provider.load();

    const newRecipe = Recipe(
      id: 'c',
      title: 'Nouvelle recette',
      description: 'desc',
      imageUrl: 'https://example.com/c.png',
      category: RecipeCategory.dessert,
      difficulty: Difficulty.facile,
      durationMinutes: 20,
      rating: 0,
      ingredients: ['Sucre'],
    );

    provider.addRecipe(newRecipe);

    expect(provider.allRecipes.length, 3);
    expect(provider.allRecipes.first.id, 'c');
  });

  test('recipeById retourne la recette correspondante ou null', () async {
    await provider.load();

    expect(provider.recipeById('a')?.title, 'Salade grecque');
    expect(provider.recipeById('inconnu'), isNull);
  });

  test('recherche et filtre categorie se combinent (ET logique)', () async {
    await provider.load();

    provider.setCategoryFilter(RecipeCategory.plat);
    provider.setSearchQuery('salade');

    // "Salade grecque" ne correspond pas a la categorie "plat" : aucun resultat.
    expect(provider.filteredRecipes, isEmpty);
  });
}
