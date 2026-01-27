import 'package:equatable/equatable.dart';
import 'hadith_reference_entity.dart';
import 'quran_reference_entity.dart';

/// Ingredient Entity
/// Domain layer entity for ingredients
class IngredientEntity extends Equatable {
  final String id;
  final String name;
  final String? nameArabic;
  final String slug;
  final String? description;
  final String category;
  final bool isSunnah;
  final String sunnahLevel;
  final List<String> benefits;
  final List<String> usageTips;
  final String? imageUrl;
  final String? iconUrl;
  final Map<String, dynamic>? nutritionalInfo;
  final List<HadithReferenceEntity> hadithReferences;
  final List<QuranReferenceEntity> quranReferences;
  final DateTime createdAt;
  final DateTime updatedAt;

  const IngredientEntity({
    required this.id,
    required this.name,
    this.nameArabic,
    required this.slug,
    this.description,
    required this.category,
    this.isSunnah = true,
    this.sunnahLevel = 'explicit',
    this.benefits = const [],
    this.usageTips = const [],
    this.imageUrl,
    this.iconUrl,
    this.nutritionalInfo,
    this.hadithReferences = const [],
    this.quranReferences = const [],
    required this.createdAt,
    required this.updatedAt,
  });

  /// Get display name with Arabic
  String get displayName {
    if (nameArabic != null && nameArabic!.isNotEmpty) {
      return '$name ($nameArabic)';
    }
    return name;
  }

  /// Get capitalized category
  String get categoryDisplay {
    if (category.isEmpty) return 'Other';
    return '${category[0].toUpperCase()}${category.substring(1)}';
  }

  /// Check if has Quran references
  bool get hasQuranReference => quranReferences.isNotEmpty;

  /// Check if has Hadith references
  bool get hasHadithReference => hadithReferences.isNotEmpty;

  /// Check if has any Islamic reference
  bool get hasIslamicReference => hasQuranReference || hasHadithReference;

  /// Get Sunnah level display
  String get sunnahLevelDisplay {
    switch (sunnahLevel.toLowerCase()) {
      case 'explicit':
        return 'Explicit Sunnah';
      case 'implied':
        return 'Implied Sunnah';
      default:
        return 'Halal';
    }
  }

  /// Get first Hadith reference
  HadithReferenceEntity? get primaryHadith =>
      hadithReferences.isNotEmpty ? hadithReferences.first : null;

  /// Get first Quran reference
  QuranReferenceEntity? get primaryQuran =>
      quranReferences.isNotEmpty ? quranReferences.first : null;

  @override
  List<Object?> get props => [
        id,
        name,
        nameArabic,
        slug,
        description,
        category,
        isSunnah,
        sunnahLevel,
        benefits,
        usageTips,
        imageUrl,
        iconUrl,
        nutritionalInfo,
        hadithReferences,
        quranReferences,
        createdAt,
        updatedAt,
      ];
}
