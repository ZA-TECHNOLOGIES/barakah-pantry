import 'package:equatable/equatable.dart';

/// Recipe Instruction Entity
/// Domain layer entity for recipe instructions
class RecipeInstructionEntity extends Equatable {
  final int step;
  final String description;
  final int? durationMinutes;
  final String? imageUrl;
  final String? tips;

  const RecipeInstructionEntity({
    required this.step,
    required this.description,
    this.durationMinutes,
    this.imageUrl,
    this.tips,
  });

  /// Get formatted duration
  String? get formattedDuration {
    if (durationMinutes == null || durationMinutes == 0) return null;
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

  /// Check if has duration
  bool get hasDuration => durationMinutes != null && durationMinutes! > 0;

  /// Check if has image
  bool get hasImage => imageUrl != null && imageUrl!.isNotEmpty;

  /// Check if has tips
  bool get hasTips => tips != null && tips!.isNotEmpty;

  /// Get step display (e.g., "Step 1")
  String get stepDisplay => 'Step $step';

  @override
  List<Object?> get props => [
        step,
        description,
        durationMinutes,
        imageUrl,
        tips,
      ];

  @override
  String toString() => '$stepDisplay: $description';
}
