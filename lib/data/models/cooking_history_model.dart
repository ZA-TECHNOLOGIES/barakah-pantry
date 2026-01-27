import 'package:barakah_pantry/domain/entities/recipe_entity.dart';

import '../../domain/entities/cooking_history_entity.dart';
import 'recipe_model.dart';

/// Cooking History Model
/// Data layer model for cooking history
class CookingHistoryModel extends CookingHistoryEntity {
  const CookingHistoryModel({
    required super.id,
    required super.odId,
    required super.recipeId,
    required super.cookedAt,
    super.notes,
    super.rating,
    super.recipe,
  });

  /// Create from JSON
  factory CookingHistoryModel.fromJson(Map<String, dynamic> json) {
    return CookingHistoryModel(
      id: json['id'] as String? ?? '',
      odId: json['user_id'] as String? ?? '',
      recipeId: json['recipe_id'] as String? ?? '',
      cookedAt: _parseDateTime(json['cooked_at']),
      notes: json['notes'] as String?,
      rating: json['rating'] as int?,
      recipe: json['recipes'] != null
          ? RecipeModel.fromJson(json['recipes'] as Map<String, dynamic>)
          : null,
    );
  }

  /// Convert to JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'user_id': odId,
      'recipe_id': recipeId,
      'cooked_at': cookedAt.toIso8601String(),
      'notes': notes,
      'rating': rating,
    };
  }

  /// Create for insertion (without ID)
  Map<String, dynamic> toInsertJson() {
    return {
      'user_id': odId,
      'recipe_id': recipeId,
      'notes': notes,
      'rating': rating,
    };
  }

  /// Create from entity
  factory CookingHistoryModel.fromEntity(CookingHistoryEntity entity) {
    return CookingHistoryModel(
      id: entity.id,
      odId: entity.odId,
      recipeId: entity.recipeId,
      cookedAt: entity.cookedAt,
      notes: entity.notes,
      rating: entity.rating,
      recipe: entity.recipe,
    );
  }

  /// Copy with
  CookingHistoryModel copyWith({
    String? id,
    String? odId,
    String? recipeId,
    DateTime? cookedAt,
    String? notes,
    int? rating,
    RecipeEntity? recipe,
  }) {
    return CookingHistoryModel(
      id: id ?? this.id,
      odId: odId ?? this.odId,
      recipeId: recipeId ?? this.recipeId,
      cookedAt: cookedAt ?? this.cookedAt,
      notes: notes ?? this.notes,
      rating: rating ?? this.rating,
      recipe: recipe ?? this.recipe,
    );
  }

  static DateTime _parseDateTime(dynamic value) {
    if (value == null) return DateTime.now();
    if (value is DateTime) return value;
    if (value is String) {
      return DateTime.tryParse(value) ?? DateTime.now();
    }
    return DateTime.now();
  }
}
