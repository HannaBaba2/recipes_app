import 'package:recipes_app/data/models/recipe.dart';

/// Local mock catalog, kept entirely out of the widget layer: widgets only
/// ever see `Recipe` objects handed to them by the provider/repository.
final List<Recipe> mockRecipes = [
  const Recipe(
    id: 'r1',
    title: 'Salade Cesar',
    description:
        'Une salade Cesar classique avec croutons maison, parmesan et sauce cremeuse.',
    imageUrl: 'https://picsum.photos/seed/caesar1/600/400',
    category: RecipeCategory.entree,
    difficulty: Difficulty.facile,
    durationMinutes: 15,
    rating: 4.3,
    ingredients: [
      'Laitue romaine',
      'Parmesan',
      'Croutons',
      'Sauce Cesar',
      'Poulet grille'
    ],
  ),
  const Recipe(
    id: 'r2',
    title: 'Soupe a l\'oignon',
    description:
        'Une soupe a l\'oignon gratinee, parfaite pour les soirees fraiches.',
    imageUrl: 'https://picsum.photos/seed/onionsoup2/600/400',
    category: RecipeCategory.entree,
    difficulty: Difficulty.moyen,
    durationMinutes: 50,
    rating: 4.6,
    ingredients: ['Oignons', 'Bouillon de boeuf', 'Pain', 'Gruyere'],
  ),
  const Recipe(
    id: 'r3',
    title: 'Poulet roti aux herbes',
    description:
        'Poulet entier roti avec un melange d\'herbes fraiches et de citron.',
    imageUrl: 'https://picsum.photos/seed/chicken3/600/400',
    category: RecipeCategory.plat,
    difficulty: Difficulty.moyen,
    durationMinutes: 90,
    rating: 4.8,
    ingredients: ['Poulet entier', 'Thym', 'Romarin', 'Citron', 'Ail'],
  ),
  const Recipe(
    id: 'r4',
    title: 'Risotto aux champignons',
    description: 'Un risotto cremeux aux champignons de Paris et parmesan.',
    imageUrl: 'https://picsum.photos/seed/risotto4/600/400',
    category: RecipeCategory.plat,
    difficulty: Difficulty.difficile,
    durationMinutes: 45,
    rating: 4.5,
    ingredients: [
      'Riz arborio',
      'Champignons',
      'Bouillon de legumes',
      'Parmesan',
      'Vin blanc'
    ],
  ),
  const Recipe(
    id: 'r5',
    title: 'Curry de legumes',
    description:
        'Un curry de legumes riche en epices, servi avec du riz basmati.',
    imageUrl: 'https://picsum.photos/seed/curry5/600/400',
    category: RecipeCategory.vegetarien,
    difficulty: Difficulty.facile,
    durationMinutes: 35,
    rating: 4.4,
    ingredients: [
      'Pois chiches',
      'Lait de coco',
      'Curry',
      'Poivrons',
      'Riz basmati'
    ],
  ),
  const Recipe(
    id: 'r6',
    title: 'Buddha bowl',
    description:
        'Un bol complet et colore avec quinoa, avocat et legumes rotis.',
    imageUrl: 'https://picsum.photos/seed/buddha6/600/400',
    category: RecipeCategory.vegetarien,
    difficulty: Difficulty.facile,
    durationMinutes: 25,
    rating: 4.2,
    ingredients: [
      'Quinoa',
      'Avocat',
      'Pois chiches rotis',
      'Epinards',
      'Graines de sesame'
    ],
  ),
  const Recipe(
    id: 'r7',
    title: 'Tarte au citron meringuee',
    description:
        'Une tarte au citron acidulee avec une meringue legere et doree.',
    imageUrl: 'https://picsum.photos/seed/lemontart7/600/400',
    category: RecipeCategory.dessert,
    difficulty: Difficulty.difficile,
    durationMinutes: 70,
    rating: 4.9,
    ingredients: ['Citrons', 'Pate sablee', 'Oeufs', 'Sucre', 'Beurre'],
  ),
  const Recipe(
    id: 'r8',
    title: 'Fondant au chocolat',
    description:
        'Un fondant au chocolat coeur coulant, simple et rapide a preparer.',
    imageUrl: 'https://picsum.photos/seed/fondant8/600/400',
    category: RecipeCategory.dessert,
    difficulty: Difficulty.facile,
    durationMinutes: 25,
    rating: 4.7,
    ingredients: ['Chocolat noir', 'Beurre', 'Oeufs', 'Sucre', 'Farine'],
  ),
  const Recipe(
    id: 'r9',
    title: 'Tartare de saumon',
    description: 'Un tartare de saumon frais a l\'aneth et au citron vert.',
    imageUrl: 'https://picsum.photos/seed/salmon9/600/400',
    category: RecipeCategory.entree,
    difficulty: Difficulty.facile,
    durationMinutes: 20,
    rating: 4.5,
    ingredients: [
      'Saumon frais',
      'Aneth',
      'Citron vert',
      'Echalote',
      'Huile d\'olive'
    ],
  ),
  const Recipe(
    id: 'r10',
    title: 'Lasagnes vegetariennes',
    description:
        'Des lasagnes garnies de legumes rotis et d\'une bechamel maison.',
    imageUrl: 'https://picsum.photos/seed/lasagna10/600/400',
    category: RecipeCategory.vegetarien,
    difficulty: Difficulty.moyen,
    durationMinutes: 60,
    rating: 4.3,
    ingredients: [
      'Pates a lasagne',
      'Courgettes',
      'Aubergines',
      'Bechamel',
      'Mozzarella'
    ],
  ),
];
