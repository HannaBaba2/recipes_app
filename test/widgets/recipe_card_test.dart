import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:recipes_app/data/models/recipe.dart';
import 'package:recipes_app/widgets/recipe_card.dart';

const _recipe = Recipe(
  id: 'r1',
  title: 'Salade Cesar',
  description: 'desc',
  imageUrl: 'https://example.com/img.png',
  category: RecipeCategory.entree,
  difficulty: Difficulty.facile,
  durationMinutes: 15,
  rating: 4.5,
  ingredients: ['Laitue'],
);

Widget _wrap(Widget child) =>
    MaterialApp(home: Scaffold(body: SizedBox(height: 300, child: child)));

RecipeCard _card({
  bool isFavorite = false,
  VoidCallback? onTap,
  VoidCallback? onToggleFavorite,
}) {
  return RecipeCard(
    recipe: _recipe,
    isFavorite: isFavorite,
    categoryLabel: 'Entree',
    favoriteLabel: 'Ajouter aux favoris',
    onTap: onTap ?? () {},
    onToggleFavorite: onToggleFavorite ?? () {},
  );
}

void main() {
  testWidgets('affiche le titre, la duree et la categorie de la recette',
      (tester) async {
    await tester.pumpWidget(_wrap(_card()));

    expect(find.text('Salade Cesar'), findsOneWidget);
    expect(find.text('15 min'), findsOneWidget);
    expect(find.text('Entree'), findsOneWidget);
  });

  testWidgets(
      'taper sur le coeur declenche onToggleFavorite sans declencher onTap',
      (tester) async {
    var tapped = false;
    var toggled = false;

    await tester.pumpWidget(
      _wrap(_card(
          onTap: () => tapped = true, onToggleFavorite: () => toggled = true)),
    );

    await tester.tap(find.byIcon(Icons.favorite_border));
    await tester.pump();

    expect(toggled, true);
    expect(tapped, false);
  });

  testWidgets('taper sur le titre de la carte declenche onTap', (tester) async {
    var tapped = false;

    await tester.pumpWidget(_wrap(_card(onTap: () => tapped = true)));

    await tester.tap(find.text('Salade Cesar'));
    await tester.pump();

    expect(tapped, true);
  });

  testWidgets('affiche un coeur plein quand la recette est en favori',
      (tester) async {
    await tester.pumpWidget(_wrap(_card(isFavorite: true)));

    expect(find.byIcon(Icons.favorite), findsOneWidget);
    expect(find.byIcon(Icons.favorite_border), findsNothing);
  });
}
