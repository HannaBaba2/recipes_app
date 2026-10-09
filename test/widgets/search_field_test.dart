import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:recipes_app/widgets/search_field.dart';

void main() {
  testWidgets('SearchField appelle onChanged avec le texte saisi',
      (tester) async {
    String? received;

    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: SearchField(
              hintText: 'Rechercher...',
              onChanged: (value) => received = value),
        ),
      ),
    );

    expect(find.text('Rechercher...'), findsOneWidget);

    await tester.enterText(find.byType(TextField), 'tarte');

    expect(received, 'tarte');
  });
}
