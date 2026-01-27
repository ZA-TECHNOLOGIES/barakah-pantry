import 'package:equatable/equatable.dart';
import 'ingredient_entity.dart';

/// Daily Tip Entity
/// Domain layer entity for daily tips
class DailyTipEntity extends Equatable {
  final String id;
  final String title;
  final String content;
  final String? ingredientId;
  final String? hadithReference;
  final String? quranReference;
  final String? imageUrl;
  final DateTime? displayDate;
  final bool isActive;
  final IngredientEntity? ingredient;
  final DateTime createdAt;

  const DailyTipEntity({
    required this.id,
    required this.title,
    required this.content,
    this.ingredientId,
    this.hadithReference,
    this.quranReference,
    this.imageUrl,
    this.displayDate,
    this.isActive = true,
    this.ingredient,
    required this.createdAt,
  });

  /// Check if has ingredient linked
  bool get hasIngredient => ingredient != null || ingredientId != null;

  /// Check if has hadith reference
  bool get hasHadithReference =>
      hadithReference != null && hadithReference!.isNotEmpty;

  /// Check if has Quran reference
  bool get hasQuranReference =>
      quranReference != null && quranReference!.isNotEmpty;

  /// Check if has any Islamic reference
  bool get hasIslamicReference => hasHadithReference || hasQuranReference;

  /// Check if has image
  bool get hasImage => imageUrl != null && imageUrl!.isNotEmpty;

  /// Get image URL (fallback to ingredient image)
  String? get displayImageUrl => imageUrl ?? ingredient?.imageUrl;

  /// Get formatted date
  String get formattedDate {
    if (displayDate == null) return '';
    return '${displayDate!.day}/${displayDate!.month}/${displayDate!.year}';
  }

  /// Check if tip is for today
  bool get isForToday {
    if (displayDate == null) return false;
    final now = DateTime.now();
    return displayDate!.year == now.year &&
        displayDate!.month == now.month &&
        displayDate!.day == now.day;
  }

  @override
  List<Object?> get props => [
        id,
        title,
        content,
        ingredientId,
        hadithReference,
        quranReference,
        imageUrl,
        displayDate,
        isActive,
        ingredient,
        createdAt,
      ];
}
