import '../../domain/entities/recipe_instruction_entity.dart';

/// Recipe Instruction Model
/// Data layer model for recipe instructions
class RecipeInstructionModel extends RecipeInstructionEntity {
  const RecipeInstructionModel({
    required super.step,
    required super.description,
    super.durationMinutes,
    super.imageUrl,
    super.tips,
  });

  /// Create from JSON
  factory RecipeInstructionModel.fromJson(Map<String, dynamic> json) {
    return RecipeInstructionModel(
      step: json['step'] as int? ?? 0,
      description: json['description'] as String? ?? '',
      durationMinutes: json['duration_minutes'] as int?,
      imageUrl: json['image_url'] as String?,
      tips: json['tips'] as String?,
    );
  }

  /// Convert to JSON
  Map<String, dynamic> toJson() {
    return {
      'step': step,
      'description': description,
      'duration_minutes': durationMinutes,
      'image_url': imageUrl,
      'tips': tips,
    };
  }

  /// Create from entity
  factory RecipeInstructionModel.fromEntity(RecipeInstructionEntity entity) {
    return RecipeInstructionModel(
      step: entity.step,
      description: entity.description,
      durationMinutes: entity.durationMinutes,
      imageUrl: entity.imageUrl,
      tips: entity.tips,
    );
  }

  /// Copy with
  RecipeInstructionModel copyWith({
    int? step,
    String? description,
    int? durationMinutes,
    String? imageUrl,
    String? tips,
  }) {
    return RecipeInstructionModel(
      step: step ?? this.step,
      description: description ?? this.description,
      durationMinutes: durationMinutes ?? this.durationMinutes,
      imageUrl: imageUrl ?? this.imageUrl,
      tips: tips ?? this.tips,
    );
  }

  /// Get formatted duration string
  String? get formattedDuration {
    if (durationMinutes == null) return null;
    if (durationMinutes! < 60) {
      return '$durationMinutes min';
    }
    final hours = durationMinutes! ~/ 60;
    final mins = durationMinutes! % 60;
    if (mins == 0) {
      return '${hours}h';
    }
    return '${hours}h ${mins}m';
  }

  @override
  String toString() => 'Step $step: $description';
}
