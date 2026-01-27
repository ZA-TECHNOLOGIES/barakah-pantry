import 'package:equatable/equatable.dart';
import 'recipe_ingredient_entity.dart';
import 'recipe_instruction_entity.dart';

class RecipeEntity extends Equatable {
  final String id;
  final String? userId;
  final String title;
  final String? description;
  final String slug;
  final String? imageUrl;
  final int prepTimeMinutes;
  final int cookTimeMinutes;
  final int servings;
  final String difficulty; // easy, medium, hard
  final String category; // breakfast, lunch, dinner, snack, dessert, drink
  final List<String> tags;
  final List<RecipeIngredientEntity> ingredients;
  final List<RecipeInstructionEntity> instructions;
  final List<String> sunnahBenefits;
  final String? hadithReference;
  final String? tips;
  final Map<String, dynamic>? nutritionalInfo;
  final bool isAiGenerated;
  final bool isApproved;
  final bool isFeatured;
  final String status; // draft, pending, published
  final int viewCount;
  final DateTime createdAt;
  final DateTime updatedAt;
  final double? averageRating;
  final int? totalRatings;
  final bool isFavorite;

  const RecipeEntity({
    required this.id,
    this.userId,
    required this.title,
    this.description,
    required this.slug,
    this.imageUrl,
    this.prepTimeMinutes = 0,
    this.cookTimeMinutes = 0,
    this.servings = 2,
    this.difficulty = 'easy',
    required this.category,
    this.tags = const [],
    required this.ingredients,
    required this.instructions,
    this.sunnahBenefits = const [],
    this.hadithReference,
    this.tips,
    this.nutritionalInfo,
    this.isAiGenerated = false,
    this.isApproved = false,
    this.isFeatured = false,
    this.status = 'pending',
    this.viewCount = 0,
    required this.createdAt,
    required this.updatedAt,
    this.averageRating,
    this.totalRatings,
    this.isFavorite = false,
  });

  @override
  List<Object?> get props => [
        id,
        userId,
        title,
        description,
        slug,
        imageUrl,
        prepTimeMinutes,
        cookTimeMinutes,
        servings,
        difficulty,
        category,
        tags,
        ingredients,
        instructions,
        sunnahBenefits,
        hadithReference,
        tips,
        nutritionalInfo,
        isAiGenerated,
        isApproved,
        isFeatured,
        status,
        viewCount,
        createdAt,
        updatedAt,
        averageRating,
        totalRatings,
        isFavorite,
      ];
}
