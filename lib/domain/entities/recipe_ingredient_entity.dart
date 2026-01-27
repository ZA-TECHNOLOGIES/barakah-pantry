import 'package:equatable/equatable.dart';

/// Recipe Ingredient Entity
/// Domain layer entity for recipe ingredients
class RecipeIngredientEntity extends Equatable {
  final String? ingredientId;
  final String name;
  final String quantity;
  final String unit;
  final bool isSunnah;
  final String? notes;

  const RecipeIngredientEntity({
    this.ingredientId,
    required this.name,
    required this.quantity,
    required this.unit,
    this.isSunnah = false,
    this.notes,
  });

  /// Get display string (e.g., "2 tbsp Honey")
  String get displayString {
    final buffer = StringBuffer();
    if (quantity.isNotEmpty) {
      buffer.write(quantity);
    }
    if (unit.isNotEmpty) {
      buffer.write(' $unit');
    }
    buffer.write(' $name');
    if (notes != null && notes!.isNotEmpty) {
      buffer.write(' ($notes)');
    }
    return buffer.toString().trim();
  }

  /// Get short display (e.g., "2 tbsp Honey")
  String get shortDisplay {
    final buffer = StringBuffer();
    if (quantity.isNotEmpty) {
      buffer.write(quantity);
    }
    if (unit.isNotEmpty) {
      buffer.write(' $unit');
    }
    buffer.write(' $name');
    return buffer.toString().trim();
  }

  /// Check if has notes
  bool get hasNotes => notes != null && notes!.isNotEmpty;

  /// Check if linked to ingredient database
  bool get isLinked => ingredientId != null && ingredientId!.isNotEmpty;

  @override
  List<Object?> get props => [
        ingredientId,
        name,
        quantity,
        unit,
        isSunnah,
        notes,
      ];

  @override
  String toString() => displayString;
}
