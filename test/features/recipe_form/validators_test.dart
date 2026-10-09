import 'package:flutter_test/flutter_test.dart';
import 'package:recipes_app/features/recipe_form/validators.dart';

void main() {
  group('title', () {
    test('refuse un titre vide', () {
      expect(RecipeFormValidators.title(''), isNotNull);
      expect(RecipeFormValidators.title(null), isNotNull);
    });

    test('refuse un titre trop court', () {
      expect(RecipeFormValidators.title('ab'), isNotNull);
    });

    test('accepte un titre valide', () {
      expect(RecipeFormValidators.title('Tarte aux pommes'), isNull);
    });
  });

  group('duration', () {
    test('refuse une duree vide ou non numerique', () {
      expect(RecipeFormValidators.duration(''), isNotNull);
      expect(RecipeFormValidators.duration('abc'), isNotNull);
    });

    test('refuse une duree nulle ou negative', () {
      expect(RecipeFormValidators.duration('0'), isNotNull);
      expect(RecipeFormValidators.duration('-5'), isNotNull);
    });

    test('accepte une duree valide', () {
      expect(RecipeFormValidators.duration('45'), isNull);
    });
  });

  group('description', () {
    test('refuse une description vide ou trop courte', () {
      expect(RecipeFormValidators.description(''), isNotNull);
      expect(RecipeFormValidators.description('court'), isNotNull);
    });

    test('accepte une description suffisamment longue', () {
      expect(
        RecipeFormValidators.description(
            'Une description bien assez longue et detaillee.'),
        isNull,
      );
    });
  });

  group('parseIngredients', () {
    test('separe et nettoie une liste d\'ingredients separes par des virgules',
        () {
      expect(
        RecipeFormValidators.parseIngredients(
            ' Tomates ,Basilic,  Mozzarella '),
        ['Tomates', 'Basilic', 'Mozzarella'],
      );
    });

    test('retourne un placeholder quand le champ est vide', () {
      expect(RecipeFormValidators.parseIngredients('   '), ['Non renseigne']);
    });
  });
}
