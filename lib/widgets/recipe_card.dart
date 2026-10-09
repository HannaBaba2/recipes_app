import 'package:flutter/material.dart';
import 'package:recipes_app/data/models/recipe.dart';

/// Reusable card used both on the list screen (grid) and the favorites
/// screen. Receives all of its data and (localized) labels through the
/// constructor - nothing is hardcoded here.
class RecipeCard extends StatelessWidget {
  final Recipe recipe;
  final bool isFavorite;
  final String categoryLabel;
  final String favoriteLabel;
  final VoidCallback onTap;
  final VoidCallback onToggleFavorite;

  const RecipeCard({
    super.key,
    required this.recipe,
    required this.isFavorite,
    required this.categoryLabel,
    required this.favoriteLabel,
    required this.onTap,
    required this.onToggleFavorite,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: onTap,
        child: Semantics(
          button: true,
          label:
              '${recipe.title}, $categoryLabel, ${recipe.durationMinutes} min',
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Stack(
                  fit: StackFit.expand,
                  children: [
                    Hero(
                      tag: 'recipe-image-${recipe.id}',
                      child: Image.network(
                        recipe.imageUrl,
                        fit: BoxFit.cover,
                        // Decodes at thumbnail resolution instead of the full
                        // source image: far less memory for a large grid.
                        cacheWidth: 300,
                        loadingBuilder: (context, child, progress) {
                          if (progress == null) return child;
                          return const ColoredBox(
                            color: Color(0xFFEEEEEE),
                            child: Center(
                              child: SizedBox(
                                width: 20,
                                height: 20,
                                child:
                                    CircularProgressIndicator(strokeWidth: 2),
                              ),
                            ),
                          );
                        },
                        errorBuilder: (_, __, ___) => const ColoredBox(
                          color: Color(0xFFEEEEEE),
                          child: Icon(Icons.image_not_supported),
                        ),
                      ),
                    ),
                    Positioned(
                      top: 4,
                      right: 4,
                      child: Semantics(
                        button: true,
                        label: favoriteLabel,
                        child: IconButton(
                          style: IconButton.styleFrom(
                              backgroundColor: Colors.white70),
                          tooltip: favoriteLabel,
                          icon: Icon(
                            isFavorite ? Icons.favorite : Icons.favorite_border,
                            color:
                                isFavorite ? Colors.redAccent : Colors.black54,
                          ),
                          onPressed: onToggleFavorite,
                        ),
                      ),
                    ),
                    Positioned(
                      left: 4,
                      bottom: 4,
                      child: Chip(
                        label: Text(categoryLabel,
                            style: const TextStyle(fontSize: 11)),
                        visualDensity: VisualDensity.compact,
                        materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(10, 8, 10, 4),
                child: Text(
                  recipe.title,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(fontWeight: FontWeight.w600),
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(10, 0, 10, 8),
                child: Row(
                  children: [
                    const Icon(Icons.timer_outlined, size: 14),
                    const SizedBox(width: 4),
                    Text('${recipe.durationMinutes} min',
                        style: const TextStyle(fontSize: 12)),
                    const Spacer(),
                    const Icon(Icons.star, size: 14, color: Colors.amber),
                    const SizedBox(width: 2),
                    Text('${recipe.rating}',
                        style: const TextStyle(fontSize: 12)),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
