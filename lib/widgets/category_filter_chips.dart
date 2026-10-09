import 'package:flutter/material.dart';
import 'package:recipes_app/data/models/recipe.dart';

/// Reusable horizontal row of category filter chips. Labels are provided by
/// the caller (already localized), so nothing is hardcoded in this widget.
class CategoryFilterChips extends StatelessWidget {
  final RecipeCategory? selected;
  final String allLabel;
  final String Function(RecipeCategory) labelOf;
  final ValueChanged<RecipeCategory?> onSelected;

  const CategoryFilterChips({
    super.key,
    required this.selected,
    required this.allLabel,
    required this.labelOf,
    required this.onSelected,
  });

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: [
          Padding(
            padding: const EdgeInsets.only(right: 6),
            child: Semantics(
              button: true,
              selected: selected == null,
              label: allLabel,
              child: ChoiceChip(
                label: Text(allLabel),
                selected: selected == null,
                onSelected: (_) => onSelected(null),
              ),
            ),
          ),
          ...RecipeCategory.values.map(
            (category) => Padding(
              padding: const EdgeInsets.only(right: 6),
              child: Semantics(
                button: true,
                selected: selected == category,
                label: labelOf(category),
                child: ChoiceChip(
                  label: Text(labelOf(category)),
                  selected: selected == category,
                  onSelected: (_) => onSelected(category),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
