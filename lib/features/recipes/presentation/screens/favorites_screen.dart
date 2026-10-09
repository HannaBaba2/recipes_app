import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:recipes_app/core/router/app_router.dart';
import 'package:recipes_app/features/recipes/providers/recipes_provider.dart';
import 'package:recipes_app/l10n/app_localizations.dart';
import 'package:recipes_app/widgets/recipe_card.dart';
import 'package:recipes_app/widgets/empty_state.dart';

class FavoritesScreen extends StatelessWidget {
  const FavoritesScreen({super.key});

  int _crossAxisCount(double width) {
    if (width >= 1000) return 4;
    if (width >= 600) return 3;
    return 2;
  }

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<RecipesProvider>();
    final l10n = AppLocalizations.of(context);
    final favorites = provider.favoriteRecipes;

    return Scaffold(
      appBar: AppBar(title: Text(l10n.favoritesTitle)),
      body: favorites.isEmpty
          ? EmptyState(icon: Icons.favorite_border, message: l10n.noFavorites)
          : LayoutBuilder(
              builder: (context, constraints) {
                return GridView.builder(
                  padding: const EdgeInsets.all(16),
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: _crossAxisCount(constraints.maxWidth),
                    mainAxisSpacing: 14,
                    crossAxisSpacing: 14,
                    childAspectRatio: 0.72,
                  ),
                  itemCount: favorites.length,
                  itemBuilder: (context, index) {
                    final recipe = favorites[index];
                    return RepaintBoundary(
                      key: ValueKey(recipe.id),
                      child: RecipeCard(
                        recipe: recipe,
                        isFavorite: true,
                        categoryLabel: l10n.category(recipe.category),
                        favoriteLabel: l10n.removeFromFavorites,
                        onTap: () => context.pushNamed(
                          RouteNames.detail,
                          pathParameters: {'id': recipe.id},
                        ),
                        onToggleFavorite: () =>
                            provider.toggleFavorite(recipe.id),
                      ),
                    );
                  },
                );
              },
            ),
    );
  }
}
