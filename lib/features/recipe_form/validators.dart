/// Validation error codes. The UI maps each code to a localized message,
/// so the validation logic itself stays pure and language-independent.
enum FormError {
  titleRequired,
  titleTooShort,
  durationRequired,
  durationInvalid,
  durationNotPositive,
  descriptionRequired,
  descriptionTooShort,
}

class RecipeFormValidators {
  const RecipeFormValidators._();

  static FormError? title(String? value) {
    if (value == null || value.trim().isEmpty) {
      return FormError.titleRequired;
    }
    if (value.trim().length < 3) {
      return FormError.titleTooShort;
    }
    return null;
  }

  static FormError? duration(String? value) {
    if (value == null || value.trim().isEmpty) {
      return FormError.durationRequired;
    }
    final parsed = int.tryParse(value.trim());
    if (parsed == null) {
      return FormError.durationInvalid;
    }
    if (parsed <= 0) {
      return FormError.durationNotPositive;
    }
    return null;
  }

  static FormError? description(String? value) {
    if (value == null || value.trim().isEmpty) {
      return FormError.descriptionRequired;
    }
    if (value.trim().length < 10) {
      return FormError.descriptionTooShort;
    }
    return null;
  }

  /// Splits the free-text ingredients field ("Tomates, Basilic") into a
  /// clean list, falling back to [placeholder] when nothing was entered.
  static List<String> parseIngredients(String raw,
      {String placeholder = 'Non renseigne'}) {
    final items =
        raw.split(',').map((e) => e.trim()).where((e) => e.isNotEmpty).toList();
    return items.isEmpty ? [placeholder] : items;
  }
}
