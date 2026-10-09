import 'package:flutter_test/flutter_test.dart';
import 'package:recipes_app/data/models/recipe.dart';

const _base = Recipe(
  id: 'x',
  title: 'Titre A',
  description: 'desc',
  imageUrl: 'https://example.com/x.png',
  category: RecipeCategory.plat,
  difficulty: Difficulty.moyen,
  durationMinutes: 30,
  rating: 4.0,
  ingredients: ['Ingredient'],
);

void main() {
  test(
      'deux Recipe avec le meme id sont egales, meme si les autres champs different',
      () {
    const other = Recipe(
      id: 'x',
      title: 'Titre B (different)',
      description: 'autre description',
      imageUrl: 'https://example.com/y.png',
      category: RecipeCategory.dessert,
      difficulty: Difficulty.facile,
      durationMinutes: 99,
      rating: 1.0,
      ingredients: ['Autre'],
    );

    expect(_base, equals(other));
    expect(_base.hashCode, other.hashCode);
  });

  test('deux Recipe avec un id different ne sont pas egales', () {
    const other = Recipe(
      id: 'y',
      title: 'Titre A',
      description: 'desc',
      imageUrl: 'https://example.com/x.png',
      category: RecipeCategory.plat,
      difficulty: Difficulty.moyen,
      durationMinutes: 30,
      rating: 4.0,
      ingredients: ['Ingredient'],
    );

    expect(_base, isNot(equals(other)));
  });

  test('les extensions de libelle retournent le texte francais attendu', () {
    expect(RecipeCategory.vegetarien.label, 'Vegetarien');
    expect(Difficulty.difficile.label, 'Difficile');
  });
}
