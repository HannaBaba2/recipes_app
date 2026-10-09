import 'package:flutter/foundation.dart';

enum RecipeCategory { entree, plat, dessert, vegetarien }

extension RecipeCategoryLabel on RecipeCategory {
  String get label {
    switch (this) {
      case RecipeCategory.entree:
        return 'Entree';
      case RecipeCategory.plat:
        return 'Plat';
      case RecipeCategory.dessert:
        return 'Dessert';
      case RecipeCategory.vegetarien:
        return 'Vegetarien';
    }
  }
}

enum Difficulty { facile, moyen, difficile }

extension DifficultyLabel on Difficulty {
  String get label {
    switch (this) {
      case Difficulty.facile:
        return 'Facile';
      case Difficulty.moyen:
        return 'Moyen';
      case Difficulty.difficile:
        return 'Difficile';
    }
  }
}

@immutable
class Recipe {
  final String id;
  final String title;
  final String description;
  final String imageUrl;
  final RecipeCategory category;
  final Difficulty difficulty;
  final int durationMinutes;
  final double rating;
  final List<String> ingredients;

  const Recipe({
    required this.id,
    required this.title,
    required this.description,
    required this.imageUrl,
    required this.category,
    required this.difficulty,
    required this.durationMinutes,
    required this.rating,
    required this.ingredients,
  });

  @override
  bool operator ==(Object other) => other is Recipe && other.id == id;

  @override
  int get hashCode => id.hashCode;
}
