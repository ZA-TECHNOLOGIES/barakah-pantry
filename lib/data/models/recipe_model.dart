import 'package:barakah_pantry/domain/entities/recipe_ingredient_entity.dart';
import 'package:barakah_pantry/domain/entities/recipe_instruction_entity.dart';

import '../../domain/entities/recipe_entity.dart';
import 'recipe_ingredient_model.dart';
import 'recipe_instruction_model.dart';

/// Recipe Model
/// Data layer model for recipe
class RecipeModel extends RecipeEntity {
  const RecipeModel({
    required super.id,
    super.userId,
    required super.title,
    super.description,
    required super.slug,
    super.imageUrl,
    super.prepTimeMinutes = 0,
    super.cookTimeMinutes = 0,
    super.servings = 2,
    super.difficulty = 'easy',
    required super.category,
    super.tags = const [],
    required super.ingredients,
    required super.instructions,
    super.sunnahBenefits = const [],
    super.hadithReference,
    super.tips,
    super.nutritionalInfo,
    super.isAiGenerated = false,
    super.isApproved = false,
    super.isFeatured = false,
    super.status = 'pending',
    super.viewCount = 0,
    required super.createdAt,
    required super.updatedAt,
    super.averageRating,
    super.totalRatings,
    super.isFavorite = false,
  });

  /// Create from JSON
  factory RecipeModel.fromJson(Map<String, dynamic> json) {
    return RecipeModel(
      id: json['id'] as String? ?? '',
      userId: json['user_id'] as String?,
      title: json['title'] as String? ?? '',
      description: json['description'] as String?,
      slug: json['slug'] as String? ?? '',
      imageUrl: json['image_url'] as String?,
      prepTimeMinutes: _parseInt(json['prep_time_minutes']) ?? 0,
      cookTimeMinutes: _parseInt(json['cook_time_minutes']) ?? 0,
      servings: _parseInt(json['servings']) ?? 2,
      difficulty: json['difficulty'] as String? ?? 'easy',
      category: json['category'] as String? ?? 'dinner',
      tags: _parseStringList(json['tags']),
      ingredients: _parseIngredients(json['ingredients']),
      instructions: _parseInstructions(json['instructions']),
      sunnahBenefits: _parseStringList(json['sunnah_benefits']),
      hadithReference: json['hadith_reference'] as String?,
      tips: json['tips'] as String?,
      nutritionalInfo: json['nutritional_info'] as Map<String, dynamic>?,
      isAiGenerated: json['is_ai_generated'] as bool? ?? false,
      isApproved: json['is_approved'] as bool? ?? false,
      isFeatured: json['is_featured'] as bool? ?? false,
      status: json['status'] as String? ?? 'pending',
      viewCount: _parseInt(json['view_count']) ?? 0,
      createdAt: _parseDateTime(json['created_at']),
      updatedAt: _parseDateTime(json['updated_at']),
      averageRating: _toDouble(json['average_rating']),
      totalRatings: _parseInt(json['total_ratings']),
    );
  }

  /// Convert to JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'user_id': userId,
      'title': title,
      'description': description,
      'slug': slug,
      'image_url': imageUrl,
      'prep_time_minutes': prepTimeMinutes,
      'cook_time_minutes': cookTimeMinutes,
      'servings': servings,
      'difficulty': difficulty,
      'category': category,
      'tags': tags,
      'ingredients': ingredients
          .map((i) => (i as RecipeIngredientModel).toJson())
          .toList(),
      'instructions': instructions
          .map((i) => (i as RecipeInstructionModel).toJson())
          .toList(),
      'sunnah_benefits': sunnahBenefits,
      'hadith_reference': hadithReference,
      'tips': tips,
      'nutritional_info': nutritionalInfo,
      'is_ai_generated': isAiGenerated,
      'is_approved': isApproved,
      'is_featured': isFeatured,
      'status': status,
    };
  }

  /// Create from entity
  factory RecipeModel.fromEntity(RecipeEntity entity) {
    return RecipeModel(
      id: entity.id,
      userId: entity.userId,
      title: entity.title,
      description: entity.description,
      slug: entity.slug,
      imageUrl: entity.imageUrl,
      prepTimeMinutes: entity.prepTimeMinutes,
      cookTimeMinutes: entity.cookTimeMinutes,
      servings: entity.servings,
      difficulty: entity.difficulty,
      category: entity.category,
      tags: entity.tags,
      ingredients: entity.ingredients,
      instructions: entity.instructions,
      sunnahBenefits: entity.sunnahBenefits,
      hadithReference: entity.hadithReference,
      tips: entity.tips,
      nutritionalInfo: entity.nutritionalInfo,
      isAiGenerated: entity.isAiGenerated,
      isApproved: entity.isApproved,
      isFeatured: entity.isFeatured,
      status: entity.status,
      viewCount: entity.viewCount,
      createdAt: entity.createdAt,
      updatedAt: entity.updatedAt,
      averageRating: entity.averageRating,
      totalRatings: entity.totalRatings,
      isFavorite: entity.isFavorite,
    );
  }

  /// Copy with
  RecipeModel copyWith({
    String? id,
    String? userId,
    String? title,
    String? description,
    String? slug,
    String? imageUrl,
    int? prepTimeMinutes,
    int? cookTimeMinutes,
    int? servings,
    String? difficulty,
    String? category,
    List<String>? tags,
    List<RecipeIngredientEntity>? ingredients,
    List<RecipeInstructionEntity>? instructions,
    List<String>? sunnahBenefits,
    String? hadithReference,
    String? tips,
    Map<String, dynamic>? nutritionalInfo,
    bool? isAiGenerated,
    bool? isApproved,
    bool? isFeatured,
    String? status,
    int? viewCount,
    DateTime? createdAt,
    DateTime? updatedAt,
    double? averageRating,
    int? totalRatings,
    bool? isFavorite,
  }) {
    return RecipeModel(
      id: id ?? this.id,
      userId: userId ?? this.userId,
      title: title ?? this.title,
      description: description ?? this.description,
      slug: slug ?? this.slug,
      imageUrl: imageUrl ?? this.imageUrl,
      prepTimeMinutes: prepTimeMinutes ?? this.prepTimeMinutes,
      cookTimeMinutes: cookTimeMinutes ?? this.cookTimeMinutes,
      servings: servings ?? this.servings,
      difficulty: difficulty ?? this.difficulty,
      category: category ?? this.category,
      tags: tags ?? this.tags,
      ingredients: ingredients ?? this.ingredients,
      instructions: instructions ?? this.instructions,
      sunnahBenefits: sunnahBenefits ?? this.sunnahBenefits,
      hadithReference: hadithReference ?? this.hadithReference,
      tips: tips ?? this.tips,
      nutritionalInfo: nutritionalInfo ?? this.nutritionalInfo,
      isAiGenerated: isAiGenerated ?? this.isAiGenerated,
      isApproved: isApproved ?? this.isApproved,
      isFeatured: isFeatured ?? this.isFeatured,
      status: status ?? this.status,
      viewCount: viewCount ?? this.viewCount,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      averageRating: averageRating ?? this.averageRating,
      totalRatings: totalRatings ?? this.totalRatings,
      isFavorite: isFavorite ?? this.isFavorite,
    );
  }

  // Helper methods
  static List<String> _parseStringList(dynamic value) {
    if (value == null) return [];
    if (value is List) {
      return value.map((e) => e.toString()).toList();
    }
    return [];
  }

  static List<RecipeIngredientEntity> _parseIngredients(dynamic value) {
    if (value == null) return [];
    if (value is List) {
      return value.map((e) {
        if (e is Map) {
          return RecipeIngredientModel.fromJson(Map<String, dynamic>.from(e));
        } else {
          return RecipeIngredientModel(
            name: e.toString(),
            quantity: '',
            unit: '',
            isSunnah: false,
          );
        }
      }).toList();
    }
    return [];
  }

  static List<RecipeInstructionEntity> _parseInstructions(dynamic value) {
    if (value == null) return [];
    if (value is List) {
      return value.asMap().entries.map((entry) {
        final index = entry.key;
        final e = entry.value;
        if (e is Map) {
          return RecipeInstructionModel.fromJson(Map<String, dynamic>.from(e));
        } else {
          return RecipeInstructionModel(
            step: index + 1,
            description: e.toString(),
          );
        }
      }).toList();
    }
    return [];
  }

  static int? _parseInt(dynamic value) {
    if (value == null) return null;
    if (value is int) return value;
    if (value is String) return int.tryParse(value);
    if (value is double) return value.toInt();
    return null;
  }

  static double? _toDouble(dynamic value) {
    if (value == null) return null;
    if (value is double) return value;
    if (value is int) return value.toDouble();
    if (value is String) return double.tryParse(value);
    return null;
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
