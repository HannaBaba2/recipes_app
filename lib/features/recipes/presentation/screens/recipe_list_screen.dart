import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:recipes_app/core/router/app_router.dart';
import 'package:recipes_app/features/recipes/providers/recipes_provider.dart';
import 'package:recipes_app/l10n/app_localizations.dart';
import 'package:recipes_app/widgets/recipe_card.dart';
import 'package:recipes_app/widgets/search_field.dart';
import 'package:recipes_app/widgets/category_filter_chips.dart';
import 'package:recipes_app/widgets/empty_state.dart';

class RecipeListScreen extends StatefulWidget {
  const RecipeListScreen({super.key});

  @override
  State<RecipeListScreen> createState() => _RecipeListScreenState();
}

class _RecipeListScreenState extends State<RecipeListScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<RecipesProvider>().load();
    });
  }

  /// Responsive breakpoint: 2 columns on mobile, more on wider (tablet) screens.
  int _crossAxisCount(double width) {
    if (width >= 1000) return 4;
    if (width >= 600) return 3;
    return 2;
  }

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<RecipesProvider>();
    final l10n = AppLocalizations.of(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(l10n.appTitle),
        actions: [
          Semantics(
            button: true,
            label: l10n.favoritesTitle,
            child: IconButton(
              icon: const Icon(Icons.favorite_border),
              tooltip: l10n.favoritesTitle,
              onPressed: () => context.pushNamed(RouteNames.favorites),
            ),
          ),
          Semantics(
            button: true,
            label: l10n.settingsTitle,
            child: IconButton(
              icon: const Icon(Icons.settings_outlined),
              tooltip: l10n.settingsTitle,
              onPressed: () => context.pushNamed(RouteNames.settings),
            ),
          ),
        ],
      ),
      floatingActionButton: Semantics(
        button: true,
        label: l10n.addButton,
        child: FloatingActionButton.extended(
          onPressed: () => context.pushNamed(RouteNames.addRecipe),
          icon: const Icon(Icons.add),
          label: Text(l10n.addButton),
        ),
      ),
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 12, 16, 8),
              child: Column(
                children: [
                  SearchField(
                      hintText: l10n.searchHint,
                      onChanged: provider.setSearchQuery),
                  const SizedBox(height: 10),
                  CategoryFilterChips(
                    selected: provider.categoryFilter,
                    allLabel: l10n.categoryAll,
                    labelOf: l10n.category,
                    onSelected: provider.setCategoryFilter,
                  ),
                ],
              ),
            ),
            Expanded(child: _buildBody(provider, l10n)),
          ],
        ),
      ),
    );
  }

  Widget _buildBody(RecipesProvider provider, AppLocalizations l10n) {
    if (provider.isLoading) {
      return const Center(child: CircularProgressIndicator());
    }
    if (provider.hasError) {
      return EmptyState(icon: Icons.error_outline, message: l10n.loadError);
    }

    final recipes = provider.filteredRecipes;
    if (recipes.isEmpty) {
      return EmptyState(icon: Icons.search_off, message: l10n.noResults);
    }

    return LayoutBuilder(
      builder: (context, constraints) {
        return GridView.builder(
          padding: const EdgeInsets.all(16),
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: _crossAxisCount(constraints.maxWidth),
            mainAxisSpacing: 14,
            crossAxisSpacing: 14,
            childAspectRatio: 0.72,
          ),
          itemCount: recipes.length,
          itemBuilder: (context, index) {
            final recipe = recipes[index];
            return RepaintBoundary(
              child: RecipeCard(
                key: ValueKey(recipe.id),
                recipe: recipe,
                isFavorite: provider.isFavorite(recipe.id),
                categoryLabel: l10n.category(recipe.category),
                favoriteLabel: provider.isFavorite(recipe.id)
                    ? l10n.removeFromFavorites
                    : l10n.addToFavorites,
                onTap: () => context.pushNamed(
                  RouteNames.detail,
                  pathParameters: {'id': recipe.id},
                ),
                onToggleFavorite: () => provider.toggleFavorite(recipe.id),
              ),
            );
          },
        );
      },
    );
  }
}
