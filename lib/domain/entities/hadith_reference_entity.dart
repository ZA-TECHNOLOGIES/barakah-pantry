import 'package:equatable/equatable.dart';

/// Hadith Reference Entity
/// Domain layer entity for hadith references
class HadithReferenceEntity extends Equatable {
  final String id;
  final String ingredientId;
  final String source;
  final String? bookName;
  final String? hadithNumber;
  final String? arabicText;
  final String englishText;
  final String grade;
  final String? narrator;
  final String? context;
  final DateTime createdAt;

  const HadithReferenceEntity({
    required this.id,
    required this.ingredientId,
    required this.source,
    this.bookName,
    this.hadithNumber,
    this.arabicText,
    required this.englishText,
    this.grade = 'Sahih',
    this.narrator,
    this.context,
    required this.createdAt,
  });

  /// Get full reference string (e.g., "Sahih al-Bukhari 5445")
  String get fullReference {
    final buffer = StringBuffer(source);
    if (hadithNumber != null && hadithNumber!.isNotEmpty) {
      buffer.write(' $hadithNumber');
    }
    return buffer.toString();
  }

  /// Get formatted citation
  String get citation {
    final buffer = StringBuffer();
    buffer.write('"$englishText"');
    buffer.write(' ($fullReference');
    if (grade.isNotEmpty && grade.toLowerCase() != 'unknown') {
      buffer.write(' - $grade');
    }
    buffer.write(')');
    return buffer.toString();
  }

  /// Get grade color indicator
  String get gradeIndicator {
    switch (grade.toLowerCase()) {
      case 'sahih':
        return '🟢';
      case 'hasan':
        return '🟡';
      case 'daif':
      case 'weak':
        return '🟠';
      default:
        return '⚪';
    }
  }

  /// Check if grade is authentic
  bool get isAuthentic {
    final lowerGrade = grade.toLowerCase();
    return lowerGrade == 'sahih' || lowerGrade == 'hasan';
  }

  @override
  List<Object?> get props => [
        id,
        ingredientId,
        source,
        bookName,
        hadithNumber,
        arabicText,
        englishText,
        grade,
        narrator,
        context,
        createdAt,
      ];
}
