import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:recipes_app/bootstrap.dart';

Future<Widget> _launchApp() async {
  // Locale forcee en francais : rend les assertions deterministes quel que
  // soit la langue de l'appareil/emulateur.
  SharedPreferences.setMockInitialValues({'app_locale': 'fr'});
  final prefs = await SharedPreferences.getInstance();
  return buildApp(prefs);
}

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  testWidgets(
    "l'utilisateur peut parcourir le catalogue, ouvrir un detail et revenir a la liste",
    (tester) async {
      await tester.pumpWidget(await _launchApp());
      await tester.pumpAndSettle(const Duration(seconds: 2));

      // La premiere recette du catalogue mock est "Salade Cesar".
      expect(find.text('Salade Cesar'), findsOneWidget);

      await tester.tap(find.text('Salade Cesar'));
      await tester.pumpAndSettle();

      // Ecran de detail : titre et section ingredients.
      expect(find.text('Salade Cesar'), findsOneWidget);
      expect(find.text('Ingredients'), findsOneWidget);

      // Retour a la liste via le bouton retour du Navigator.
      await tester.pageBack();
      await tester.pumpAndSettle();

      expect(find.text('Recettes'), findsOneWidget);
      expect(find.text('Salade Cesar'), findsOneWidget);
    },
  );

  testWidgets(
    'le formulaire valide les champs puis ajoute la recette visible dans la liste',
    (tester) async {
      await tester.pumpWidget(await _launchApp());
      await tester.pumpAndSettle(const Duration(seconds: 2));

      await tester.tap(find.text('Ajouter'));
      await tester.pumpAndSettle();

      // Soumission vide : les erreurs de validation apparaissent.
      final submit = find.text('Enregistrer la recette');
      await tester.ensureVisible(submit);
      await tester.tap(submit);
      await tester.pump();
      expect(find.text('Le titre est requis.'), findsOneWidget);

      // Saisie de valeurs valides.
      await tester.enterText(
          find.widgetWithText(TextFormField, 'Titre'), 'Recette E2E');
      await tester.enterText(
          find.widgetWithText(TextFormField, 'Duree (minutes)'), '20');
      await tester.enterText(
        find.widgetWithText(TextFormField, 'Description'),
        "Une recette ajoutee pendant le test d'integration.",
      );

      await tester.ensureVisible(submit);
      await tester.tap(submit);
      await tester.pumpAndSettle();

      // Retour automatique a la liste, avec la nouvelle recette en tete.
      expect(find.text('Recette E2E'), findsOneWidget);
    },
  );

  testWidgets(
    "ajouter une recette aux favoris la rend visible dans l'ecran Favoris",
    (tester) async {
      await tester.pumpWidget(await _launchApp());
      await tester.pumpAndSettle(const Duration(seconds: 2));

      await tester.tap(find.byTooltip('Ajouter aux favoris').first);
      await tester.pump();

      await tester.tap(find.byTooltip('Mes favoris'));
      await tester.pumpAndSettle();

      expect(find.text('Mes favoris'), findsWidgets);
      expect(find.text('Salade Cesar'), findsOneWidget);
    },
  );
}
