import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:recipes_app/widgets/empty_state.dart';

void main() {
  testWidgets('affiche l\'icone et le message fournis', (tester) async {
    await tester.pumpWidget(
      const MaterialApp(
        home: Scaffold(
          body: EmptyState(
              icon: Icons.favorite_border,
              message: 'Aucun favori pour le moment.'),
        ),
      ),
    );

    expect(find.byIcon(Icons.favorite_border), findsOneWidget);
    expect(find.text('Aucun favori pour le moment.'), findsOneWidget);
  });
}
