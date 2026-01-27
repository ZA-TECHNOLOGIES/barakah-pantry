import 'package:equatable/equatable.dart';
import 'recipe_entity.dart';

/// Favorite Entity
/// Domain layer entity for favorites
class FavoriteEntity extends Equatable {
  final String id;
  final String odId;
  final String recipeId;
  final RecipeEntity? recipe;
  final DateTime createdAt;

  const FavoriteEntity({
    required this.id,
    required this.odId,
    required this.recipeId,
    this.recipe,
    required this.createdAt,
  });

  /// Check if has recipe loaded
  bool get hasRecipe => recipe != null;

  /// Get recipe title
  String get recipeTitle => recipe?.title ?? 'Unknown Recipe';

  /// Get recipe image
  String? get recipeImage => recipe?.imageUrl;

  /// Get formatted date
  String get formattedDate {
    return '${createdAt.day}/${createdAt.month}/${createdAt.year}';
  }

  /// Get relative time
  String get relativeTime {
    final now = DateTime.now();
    final difference = now.difference(createdAt);

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

  @override
  List<Object?> get props => [
        id,
        odId,
        recipeId,
        recipe,
        createdAt,
      ];
}
