import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:recipes_app/features/recipes/providers/recipes_provider.dart';
import 'package:recipes_app/l10n/app_localizations.dart';
import 'package:recipes_app/widgets/section_header.dart';

class RecipeDetailScreen extends StatelessWidget {
  final String recipeId;
  const RecipeDetailScreen({super.key, required this.recipeId});

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<RecipesProvider>();
    final l10n = AppLocalizations.of(context);
    final recipe = provider.recipeById(recipeId);

    if (recipe == null) {
      return Scaffold(
        appBar: AppBar(title: Text(l10n.appTitle)),
        body: Center(child: Text(l10n.recipeNotFound)),
      );
    }

    final isFavorite = provider.isFavorite(recipe.id);
    final width = MediaQuery.sizeOf(context).width;
    final isTablet = width >= 600;

    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            expandedHeight: isTablet ? 320 : 240,
            pinned: true,
            flexibleSpace: FlexibleSpaceBar(
              background: Stack(
                fit: StackFit.expand,
                children: [
                  Hero(
                    tag: 'recipe-image-${recipe.id}',
                    child: Image.network(
                      recipe.imageUrl,
                      fit: BoxFit.cover,
                      errorBuilder: (_, __, ___) => const ColoredBox(
                        color: Color(0xFFEEEEEE),
                        child: Icon(Icons.image_not_supported, size: 48),
                      ),
                    ),
                  ),
                  const DecoratedBox(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [Colors.transparent, Colors.black54],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            actions: [
              Semantics(
                button: true,
                label:
                    isFavorite ? l10n.removeFromFavorites : l10n.addToFavorites,
                child: IconButton(
                  tooltip: isFavorite
                      ? l10n.removeFromFavorites
                      : l10n.addToFavorites,
                  icon: Icon(
                    isFavorite ? Icons.favorite : Icons.favorite_border,
                    color: isFavorite ? Colors.redAccent : Colors.white,
                  ),
                  onPressed: () => provider.toggleFavorite(recipe.id),
                ),
              ),
            ],
          ),
          SliverToBoxAdapter(
            child: Center(
              child: ConstrainedBox(
                constraints:
                    BoxConstraints(maxWidth: isTablet ? 700 : double.infinity),
                child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        recipe.title,
                        style: const TextStyle(
                            fontSize: 24, fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 8),
                      Wrap(
                        spacing: 8,
                        runSpacing: 8,
                        children: [
                          Chip(
                            avatar: const Icon(Icons.timer_outlined, size: 16),
                            label: Text('${recipe.durationMinutes} min'),
                          ),
                          Chip(
                            avatar: const Icon(Icons.bar_chart, size: 16),
                            label: Text(l10n.difficulty(recipe.difficulty)),
                          ),
                          Chip(
                            avatar: const Icon(Icons.star,
                                size: 16, color: Colors.amber),
                            label: Text('${recipe.rating}'),
                          ),
                          Chip(label: Text(l10n.category(recipe.category))),
                        ],
                      ),
                      const SizedBox(height: 20),
                      SectionHeader(
                          icon: Icons.description_outlined,
                          title: l10n.descriptionSection),
                      const SizedBox(height: 8),
                      Text(recipe.description,
                          style: const TextStyle(height: 1.4)),
                      const SizedBox(height: 20),
                      SectionHeader(
                        icon: Icons.shopping_basket_outlined,
                        title: l10n.ingredientsSection,
                      ),
                      const SizedBox(height: 8),
                      ListView.separated(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: recipe.ingredients.length,
                        separatorBuilder: (_, __) => const Divider(height: 1),
                        itemBuilder: (context, index) => ListTile(
                          dense: true,
                          contentPadding: EdgeInsets.zero,
                          leading:
                              const Icon(Icons.check_circle_outline, size: 20),
                          title: Text(recipe.ingredients[index]),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
