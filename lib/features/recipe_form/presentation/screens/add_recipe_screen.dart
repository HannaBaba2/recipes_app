import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:recipes_app/data/models/recipe.dart';
import 'package:recipes_app/features/recipes/providers/recipes_provider.dart';
import 'package:recipes_app/features/recipe_form/validators.dart';
import 'package:recipes_app/l10n/app_localizations.dart';

class AddRecipeScreen extends StatefulWidget {
  const AddRecipeScreen({super.key});

  @override
  State<AddRecipeScreen> createState() => _AddRecipeScreenState();
}

class _AddRecipeScreenState extends State<AddRecipeScreen> {
  final _formKey = GlobalKey<FormState>();

  final _titleController = TextEditingController();
  final _durationController = TextEditingController();
  final _descriptionController = TextEditingController();
  final _ingredientsController = TextEditingController();

  RecipeCategory _category = RecipeCategory.plat;
  Difficulty _difficulty = Difficulty.facile;

  @override
  void dispose() {
    _titleController.dispose();
    _durationController.dispose();
    _descriptionController.dispose();
    _ingredientsController.dispose();
    super.dispose();
  }

  String? _message(AppLocalizations l10n, FormError? error) {
    switch (error) {
      case null:
        return null;
      case FormError.titleRequired:
        return l10n.errTitleRequired;
      case FormError.titleTooShort:
        return l10n.errTitleTooShort;
      case FormError.durationRequired:
        return l10n.errDurationRequired;
      case FormError.durationInvalid:
        return l10n.errDurationInvalid;
      case FormError.durationNotPositive:
        return l10n.errDurationNotPositive;
      case FormError.descriptionRequired:
        return l10n.errDescriptionRequired;
      case FormError.descriptionTooShort:
        return l10n.errDescriptionTooShort;
    }
  }

  void _submit() {
    if (!_formKey.currentState!.validate()) return;

    final l10n = AppLocalizations.of(context);
    final title = _titleController.text.trim();

    final recipe = Recipe(
      id: 'custom-${DateTime.now().millisecondsSinceEpoch}',
      title: title,
      description: _descriptionController.text.trim(),
      imageUrl:
          'https://picsum.photos/seed/${Uri.encodeComponent(title)}/600/400',
      category: _category,
      difficulty: _difficulty,
      durationMinutes: int.parse(_durationController.text.trim()),
      rating: 0,
      ingredients: RecipeFormValidators.parseIngredients(
        _ingredientsController.text,
        placeholder: l10n.ingredientsPlaceholder,
      ),
    );

    context.read<RecipesProvider>().addRecipe(recipe);

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('"${recipe.title}" ${l10n.recipeAdded}')),
    );
    context.pop();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);

    return Scaffold(
      appBar: AppBar(title: Text(l10n.addRecipeTitle)),
      // SingleChildScrollView + Column (instead of a lazy ListView) so every
      // field is always built and therefore always validated on submit.
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Semantics(
                textField: true,
                label: l10n.fieldTitle,
                child: TextFormField(
                  controller: _titleController,
                  decoration: InputDecoration(
                    labelText: l10n.fieldTitle,
                    border: const OutlineInputBorder(),
                  ),
                  validator: (value) =>
                      _message(l10n, RecipeFormValidators.title(value)),
                ),
              ),
              const SizedBox(height: 16),
              Semantics(
                textField: true,
                label: l10n.fieldDuration,
                child: TextFormField(
                  controller: _durationController,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    labelText: l10n.fieldDuration,
                    border: const OutlineInputBorder(),
                  ),
                  validator: (value) =>
                      _message(l10n, RecipeFormValidators.duration(value)),
                ),
              ),
              const SizedBox(height: 16),
              Semantics(
                label: l10n.fieldCategory,
                child: InputDecorator(
                  decoration: InputDecoration(
                    labelText: l10n.fieldCategory,
                    border: const OutlineInputBorder(),
                  ),
                  child: DropdownButtonHideUnderline(
                    child: DropdownButton<RecipeCategory>(
                      value: _category,
                      isExpanded: true,
                      isDense: true,
                      items: RecipeCategory.values
                          .map((c) => DropdownMenuItem(
                              value: c, child: Text(l10n.category(c))))
                          .toList(),
                      onChanged: (value) =>
                          setState(() => _category = value ?? _category),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 16),
              Semantics(
                label: l10n.fieldDifficulty,
                child: InputDecorator(
                  decoration: InputDecoration(
                    labelText: l10n.fieldDifficulty,
                    border: const OutlineInputBorder(),
                  ),
                  child: DropdownButtonHideUnderline(
                    child: DropdownButton<Difficulty>(
                      value: _difficulty,
                      isExpanded: true,
                      isDense: true,
                      items: Difficulty.values
                          .map((d) => DropdownMenuItem(
                              value: d, child: Text(l10n.difficulty(d))))
                          .toList(),
                      onChanged: (value) =>
                          setState(() => _difficulty = value ?? _difficulty),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 16),
              Semantics(
                textField: true,
                label: l10n.fieldDescription,
                child: TextFormField(
                  controller: _descriptionController,
                  maxLines: 3,
                  decoration: InputDecoration(
                    labelText: l10n.fieldDescription,
                    border: const OutlineInputBorder(),
                  ),
                  validator: (value) =>
                      _message(l10n, RecipeFormValidators.description(value)),
                ),
              ),
              const SizedBox(height: 16),
              Semantics(
                textField: true,
                label: l10n.fieldIngredients,
                child: TextFormField(
                  controller: _ingredientsController,
                  decoration: InputDecoration(
                    labelText: l10n.fieldIngredients,
                    border: const OutlineInputBorder(),
                    hintText: l10n.hintIngredients,
                  ),
                ),
              ),
              const SizedBox(height: 24),
              Semantics(
                button: true,
                label: l10n.saveRecipe,
                child: FilledButton.icon(
                  onPressed: _submit,
                  icon: const Icon(Icons.check),
                  label: Text(l10n.saveRecipe),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
