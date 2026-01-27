import 'package:barakah_pantry/domain/entities/hadith_reference_entity.dart';
import 'package:barakah_pantry/domain/entities/quran_reference_entity.dart';

import '../../domain/entities/ingredient_entity.dart';
import 'hadith_reference_model.dart';
import 'quran_reference_model.dart' hide HadithReferenceModel;

/// Ingredient Model
/// Data layer model for ingredient
class IngredientModel extends IngredientEntity {
  const IngredientModel({
    required super.id,
    required super.name,
    super.nameArabic,
    required super.slug,
    super.description,
    required super.category,
    super.isSunnah = true,
    super.sunnahLevel = 'explicit',
    super.benefits = const [],
    super.usageTips = const [],
    super.imageUrl,
    super.iconUrl,
    super.nutritionalInfo,
    super.hadithReferences = const [],
    super.quranReferences = const [],
    required super.createdAt,
    required super.updatedAt,
  });

  /// Create from JSON
  factory IngredientModel.fromJson(Map<String, dynamic> json) {
    return IngredientModel(
      id: json['id'] as String? ?? '',
      name: json['name'] as String? ?? '',
      nameArabic: json['name_arabic'] as String?,
      slug: json['slug'] as String? ?? '',
      description: json['description'] as String?,
      category: json['category'] as String? ?? 'other',
      isSunnah: json['is_sunnah'] as bool? ?? true,
      sunnahLevel: json['sunnah_level'] as String? ?? 'explicit',
      benefits: _parseStringList(json['benefits']),
      usageTips: _parseStringList(json['usage_tips']),
      imageUrl: json['image_url'] as String?,
      iconUrl: json['icon_url'] as String?,
      nutritionalInfo: json['nutritional_info'] as Map<String, dynamic>?,
      hadithReferences: _parseHadithReferences(json['hadith_references']),
      quranReferences: _parseQuranReferences(json['quran_references']),
      createdAt: _parseDateTime(json['created_at']),
      updatedAt: _parseDateTime(json['updated_at']),
    );
  }

  /// Convert to JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'name_arabic': nameArabic,
      'slug': slug,
      'description': description,
      'category': category,
      'is_sunnah': isSunnah,
      'sunnah_level': sunnahLevel,
      'benefits': benefits,
      'usage_tips': usageTips,
      'image_url': imageUrl,
      'icon_url': iconUrl,
      'nutritional_info': nutritionalInfo,
    };
  }

  /// Create from entity
  factory IngredientModel.fromEntity(IngredientEntity entity) {
    return IngredientModel(
      id: entity.id,
      name: entity.name,
      nameArabic: entity.nameArabic,
      slug: entity.slug,
      description: entity.description,
      category: entity.category,
      isSunnah: entity.isSunnah,
      sunnahLevel: entity.sunnahLevel,
      benefits: entity.benefits,
      usageTips: entity.usageTips,
      imageUrl: entity.imageUrl,
      iconUrl: entity.iconUrl,
      nutritionalInfo: entity.nutritionalInfo,
      hadithReferences: entity.hadithReferences,
      quranReferences: entity.quranReferences,
      createdAt: entity.createdAt,
      updatedAt: entity.updatedAt,
    );
  }

  /// Copy with
  IngredientModel copyWith({
    String? id,
    String? name,
    String? nameArabic,
    String? slug,
    String? description,
    String? category,
    bool? isSunnah,
    String? sunnahLevel,
    List<String>? benefits,
    List<String>? usageTips,
    String? imageUrl,
    String? iconUrl,
    Map<String, dynamic>? nutritionalInfo,
    List<HadithReferenceEntity>? hadithReferences,
    List<QuranReferenceEntity>? quranReferences,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return IngredientModel(
      id: id ?? this.id,
      name: name ?? this.name,
      nameArabic: nameArabic ?? this.nameArabic,
      slug: slug ?? this.slug,
      description: description ?? this.description,
      category: category ?? this.category,
      isSunnah: isSunnah ?? this.isSunnah,
      sunnahLevel: sunnahLevel ?? this.sunnahLevel,
      benefits: benefits ?? this.benefits,
      usageTips: usageTips ?? this.usageTips,
      imageUrl: imageUrl ?? this.imageUrl,
      iconUrl: iconUrl ?? this.iconUrl,
      nutritionalInfo: nutritionalInfo ?? this.nutritionalInfo,
      hadithReferences: hadithReferences ?? this.hadithReferences,
      quranReferences: quranReferences ?? this.quranReferences,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
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

  static List<HadithReferenceEntity> _parseHadithReferences(dynamic value) {
    if (value == null) return [];
    if (value is List) {
      return value
          .map((e) => HadithReferenceModel.fromJson(e as Map<String, dynamic>))
          .toList();
    }
    return [];
  }

  static List<QuranReferenceEntity> _parseQuranReferences(dynamic value) {
    if (value == null) return [];
    if (value is List) {
      return value
          .map((e) => QuranReferenceModel.fromJson(e as Map<String, dynamic>))
          .toList();
    }
    return [];
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
