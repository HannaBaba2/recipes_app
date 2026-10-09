import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:recipes_app/data/models/recipe.dart';
import 'package:recipes_app/widgets/category_filter_chips.dart';

void main() {
  testWidgets(
      'taper sur une puce de categorie appelle onSelected avec la bonne valeur',
      (tester) async {
    RecipeCategory? selected;

    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: CategoryFilterChips(
            selected: null,
            allLabel: 'Toutes',
            labelOf: (category) => category.name,
            onSelected: (value) => selected = value,
          ),
        ),
      ),
    );

    expect(find.text('Toutes'), findsOneWidget);
    expect(find.text('dessert'), findsOneWidget);

    await tester.tap(find.text('dessert'));
    await tester.pump();

    expect(selected, RecipeCategory.dessert);
  });
}
