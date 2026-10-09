import 'package:go_router/go_router.dart';
import 'package:recipes_app/features/recipes/presentation/screens/recipe_list_screen.dart';
import 'package:recipes_app/features/recipes/presentation/screens/recipe_detail_screen.dart';
import 'package:recipes_app/features/recipes/presentation/screens/favorites_screen.dart';
import 'package:recipes_app/features/recipe_form/presentation/screens/add_recipe_screen.dart';
import 'package:recipes_app/features/settings/presentation/screens/settings_screen.dart';

/// Route names, centralised so screens never rely on hardcoded path
/// strings when navigating (`context.pushNamed(RouteNames.detail, ...)`).
abstract class RouteNames {
  static const home = 'home';
  static const detail = 'recipe-detail';
  static const favorites = 'favorites';
  static const addRecipe = 'add-recipe';
  static const settings = 'settings';
}

/// Builds a fresh router. Creating it per [App] instance (instead of using a
/// global singleton) keeps navigation state isolated between tests.
GoRouter createAppRouter() {
  return GoRouter(
    initialLocation: '/',
    routes: [
      GoRoute(
        path: '/',
        name: RouteNames.home,
        builder: (context, state) => const RecipeListScreen(),
      ),
      GoRoute(
        path: '/recipe/:id',
        name: RouteNames.detail,
        builder: (context, state) {
          final id = state.pathParameters['id']!;
          return RecipeDetailScreen(recipeId: id);
        },
      ),
      GoRoute(
        path: '/favorites',
        name: RouteNames.favorites,
        builder: (context, state) => const FavoritesScreen(),
      ),
      GoRoute(
        path: '/add',
        name: RouteNames.addRecipe,
        builder: (context, state) => const AddRecipeScreen(),
      ),
      GoRoute(
        path: '/settings',
        name: RouteNames.settings,
        builder: (context, state) => const SettingsScreen(),
      ),
    ],
  );
}
