import '../../domain/entities/recipe_ingredient_entity.dart';

/// Recipe Ingredient Model
/// Data layer model for recipe ingredients
class RecipeIngredientModel extends RecipeIngredientEntity {
  const RecipeIngredientModel({
    super.ingredientId,
    required super.name,
    required super.quantity,
    required super.unit,
    super.isSunnah = false,
    super.notes,
  });

  /// Create from JSON
  factory RecipeIngredientModel.fromJson(Map<String, dynamic> json) {
    return RecipeIngredientModel(
      ingredientId: json['ingredient_id'] as String?,
      name: json['name'] as String? ?? '',
      quantity: json['quantity']?.toString() ?? '',
      unit: json['unit'] as String? ?? '',
      isSunnah: json['is_sunnah'] as bool? ?? false,
      notes: json['notes'] as String?,
    );
  }

  /// Convert to JSON
  Map<String, dynamic> toJson() {
    return {
      'ingredient_id': ingredientId,
      'name': name,
      'quantity': quantity,
      'unit': unit,
      'is_sunnah': isSunnah,
      'notes': notes,
    };
  }

  /// Create from entity
  factory RecipeIngredientModel.fromEntity(RecipeIngredientEntity entity) {
    return RecipeIngredientModel(
      ingredientId: entity.ingredientId,
      name: entity.name,
      quantity: entity.quantity,
      unit: entity.unit,
      isSunnah: entity.isSunnah,
      notes: entity.notes,
    );
  }

  /// Copy with
  RecipeIngredientModel copyWith({
    String? ingredientId,
    String? name,
    String? quantity,
    String? unit,
    bool? isSunnah,
    String? notes,
  }) {
    return RecipeIngredientModel(
      ingredientId: ingredientId ?? this.ingredientId,
      name: name ?? this.name,
      quantity: quantity ?? this.quantity,
      unit: unit ?? this.unit,
      isSunnah: isSunnah ?? this.isSunnah,
      notes: notes ?? this.notes,
    );
  }

  /// Get formatted display string
  String get displayString {
    final buffer = StringBuffer();
    buffer.write(quantity);
    if (unit.isNotEmpty) {
      buffer.write(' $unit');
    }
    buffer.write(' $name');
    if (notes != null && notes!.isNotEmpty) {
      buffer.write(' ($notes)');
    }
    return buffer.toString();
  }

  @override
  String toString() => displayString;
}
