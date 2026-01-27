import 'package:barakah_pantry/domain/entities/recipe_entity.dart';

import '../../domain/entities/favorite_entity.dart';
import 'recipe_model.dart';

/// Favorite Model
/// Data layer model for favorites
class FavoriteModel extends FavoriteEntity {
  const FavoriteModel({
    required super.id,
    required super.odId,
    required super.recipeId,
    super.recipe,
    required super.createdAt,
  });

  /// Create from JSON
  factory FavoriteModel.fromJson(Map<String, dynamic> json) {
    return FavoriteModel(
      id: json['id'] as String? ?? '',
      odId: json['user_id'] as String? ?? '',
      recipeId: json['recipe_id'] as String? ?? '',
      recipe: json['recipes'] != null
          ? RecipeModel.fromJson(json['recipes'] as Map<String, dynamic>)
          : null,
      createdAt: _parseDateTime(json['created_at']),
    );
  }

  /// Convert to JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'user_id': odId,
      'recipe_id': recipeId,
    };
  }

  /// Create for insertion (without ID)
  Map<String, dynamic> toInsertJson() {
    return {
      'user_id': odId,
      'recipe_id': recipeId,
    };
  }

  /// Create from entity
  factory FavoriteModel.fromEntity(FavoriteEntity entity) {
    return FavoriteModel(
      id: entity.id,
      odId: entity.odId,
      recipeId: entity.recipeId,
      recipe: entity.recipe,
      createdAt: entity.createdAt,
    );
  }

  /// Copy with
  FavoriteModel copyWith({
    String? id,
    String? odId,
    String? recipeId,
    RecipeEntity? recipe,
    DateTime? createdAt,
  }) {
    return FavoriteModel(
      id: id ?? this.id,
      odId: odId ?? this.odId,
      recipeId: recipeId ?? this.recipeId,
      recipe: recipe ?? this.recipe,
      createdAt: createdAt ?? this.createdAt,
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
