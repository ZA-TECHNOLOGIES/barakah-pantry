import 'package:equatable/equatable.dart';
import 'recipe_entity.dart';

/// Cooking History Entity
/// Domain layer entity for cooking history
class CookingHistoryEntity extends Equatable {
  final String id;
  final String odId;
  final String recipeId;
  final DateTime cookedAt;
  final String? notes;
  final int? rating;
  final RecipeEntity? recipe;

  const CookingHistoryEntity({
    required this.id,
    required this.odId,
    required this.recipeId,
    required this.cookedAt,
    this.notes,
    this.rating,
    this.recipe,
  });

  /// Check if has recipe loaded
  bool get hasRecipe => recipe != null;

  /// Check if has notes
  bool get hasNotes => notes != null && notes!.isNotEmpty;

  /// Check if has rating
  bool get hasRating => rating != null && rating! > 0;

  /// Get recipe title
  String get recipeTitle => recipe?.title ?? 'Unknown Recipe';

  /// Get recipe image
  String? get recipeImage => recipe?.imageUrl;

  /// Get formatted date
  String get formattedDate {
    return '${cookedAt.day}/${cookedAt.month}/${cookedAt.year}';
  }

  /// Get formatted time
  String get formattedTime {
    final hour = cookedAt.hour;
    final minute = cookedAt.minute.toString().padLeft(2, '0');
    final period = hour >= 12 ? 'PM' : 'AM';
    final displayHour = hour > 12 ? hour - 12 : (hour == 0 ? 12 : hour);
    return '$displayHour:$minute $period';
  }

  /// Get relative time
  String get relativeTime {
    final now = DateTime.now();
    final difference = now.difference(cookedAt);

    if (difference.inDays > 7) {
      return formattedDate;
    }
    if (difference.inDays > 0) {
      return '${difference.inDays}d ago';
    }
    if (difference.inHours > 0) {
      return '${difference.inHours}h ago';
    }
    if (difference.inMinutes > 0) {
      return '${difference.inMinutes}m ago';
    }
    return 'Just now';
  }

  /// Get rating stars
  String get ratingStars {
    if (rating == null || rating == 0) return '☆☆☆☆☆';
    return '★' * rating! + '☆' * (5 - rating!);
  }

  @override
  List<Object?> get props => [
        id,
        odId,
        recipeId,
        cookedAt,
        notes,
        rating,
        recipe,
      ];
}
