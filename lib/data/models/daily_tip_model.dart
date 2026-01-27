import 'package:barakah_pantry/domain/entities/ingredient_entity.dart';

import '../../domain/entities/daily_tip_entity.dart';
import 'ingredient_model.dart';

/// Daily Tip Model
/// Data layer model for daily tips
class DailyTipModel extends DailyTipEntity {
  const DailyTipModel({
    required super.id,
    required super.title,
    required super.content,
    super.ingredientId,
    super.hadithReference,
    super.quranReference,
    super.imageUrl,
    super.displayDate,
    super.isActive = true,
    super.ingredient,
    required super.createdAt,
  });

  /// Create from JSON
  factory DailyTipModel.fromJson(Map<String, dynamic> json) {
    return DailyTipModel(
      id: json['id'] as String? ?? '',
      title: json['title'] as String? ?? '',
      content: json['content'] as String? ?? '',
      ingredientId: json['ingredient_id'] as String?,
      hadithReference: json['hadith_reference'] as String?,
      quranReference: json['quran_reference'] as String?,
      imageUrl: json['image_url'] as String?,
      displayDate: _parseDate(json['display_date']),
      isActive: json['is_active'] as bool? ?? true,
      ingredient: json['ingredients'] != null
          ? IngredientModel.fromJson(
              json['ingredients'] as Map<String, dynamic>)
          : null,
      createdAt: _parseDateTime(json['created_at']),
    );
  }

  /// Convert to JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'content': content,
      'ingredient_id': ingredientId,
      'hadith_reference': hadithReference,
      'quran_reference': quranReference,
      'image_url': imageUrl,
      'display_date': displayDate?.toIso8601String().split('T')[0],
      'is_active': isActive,
    };
  }

  /// Create from entity
  factory DailyTipModel.fromEntity(DailyTipEntity entity) {
    return DailyTipModel(
      id: entity.id,
      title: entity.title,
      content: entity.content,
      ingredientId: entity.ingredientId,
      hadithReference: entity.hadithReference,
      quranReference: entity.quranReference,
      imageUrl: entity.imageUrl,
      displayDate: entity.displayDate,
      isActive: entity.isActive,
      ingredient: entity.ingredient,
      createdAt: entity.createdAt,
    );
  }

  /// Copy with
  DailyTipModel copyWith({
    String? id,
    String? title,
    String? content,
    String? ingredientId,
    String? hadithReference,
    String? quranReference,
    String? imageUrl,
    DateTime? displayDate,
    bool? isActive,
    IngredientEntity? ingredient,
    DateTime? createdAt,
  }) {
    return DailyTipModel(
      id: id ?? this.id,
      title: title ?? this.title,
      content: content ?? this.content,
      ingredientId: ingredientId ?? this.ingredientId,
      hadithReference: hadithReference ?? this.hadithReference,
      quranReference: quranReference ?? this.quranReference,
      imageUrl: imageUrl ?? this.imageUrl,
      displayDate: displayDate ?? this.displayDate,
      isActive: isActive ?? this.isActive,
      ingredient: ingredient ?? this.ingredient,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  // Helper methods
  static DateTime? _parseDate(dynamic value) {
    if (value == null) return null;
    if (value is DateTime) return value;
    if (value is String) {
      return DateTime.tryParse(value);
    }
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
