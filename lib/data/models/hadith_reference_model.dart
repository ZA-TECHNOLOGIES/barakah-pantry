import '../../domain/entities/hadith_reference_entity.dart';

/// Hadith Reference Model
/// Data layer model for hadith references
class HadithReferenceModel extends HadithReferenceEntity {
  const HadithReferenceModel({
    required super.id,
    required super.ingredientId,
    required super.source,
    super.bookName,
    super.hadithNumber,
    super.arabicText,
    required super.englishText,
    super.grade = 'Sahih',
    super.narrator,
    super.context,
    required super.createdAt,
  });

  /// Create from JSON
  factory HadithReferenceModel.fromJson(Map<String, dynamic> json) {
    return HadithReferenceModel(
      id: json['id'] as String? ?? '',
      ingredientId: json['ingredient_id'] as String? ?? '',
      source: json['source'] as String? ?? '',
      bookName: json['book_name'] as String?,
      hadithNumber: json['hadith_number'] as String?,
      arabicText: json['arabic_text'] as String?,
      englishText: json['english_text'] as String? ?? '',
      grade: json['grade'] as String? ?? 'Sahih',
      narrator: json['narrator'] as String?,
      context: json['context'] as String?,
      createdAt: _parseDateTime(json['created_at']),
    );
  }

  /// Convert to JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'ingredient_id': ingredientId,
      'source': source,
      'book_name': bookName,
      'hadith_number': hadithNumber,
      'arabic_text': arabicText,
      'english_text': englishText,
      'grade': grade,
      'narrator': narrator,
      'context': context,
    };
  }

  /// Create from entity
  factory HadithReferenceModel.fromEntity(HadithReferenceEntity entity) {
    return HadithReferenceModel(
      id: entity.id,
      ingredientId: entity.ingredientId,
      source: entity.source,
      bookName: entity.bookName,
      hadithNumber: entity.hadithNumber,
      arabicText: entity.arabicText,
      englishText: entity.englishText,
      grade: entity.grade,
      narrator: entity.narrator,
      context: entity.context,
      createdAt: entity.createdAt,
    );
  }

  /// Copy with
  HadithReferenceModel copyWith({
    String? id,
    String? ingredientId,
    String? source,
    String? bookName,
    String? hadithNumber,
    String? arabicText,
    String? englishText,
    String? grade,
    String? narrator,
    String? context,
    DateTime? createdAt,
  }) {
    return HadithReferenceModel(
      id: id ?? this.id,
      ingredientId: ingredientId ?? this.ingredientId,
      source: source ?? this.source,
      bookName: bookName ?? this.bookName,
      hadithNumber: hadithNumber ?? this.hadithNumber,
      arabicText: arabicText ?? this.arabicText,
      englishText: englishText ?? this.englishText,
      grade: grade ?? this.grade,
      narrator: narrator ?? this.narrator,
      context: context ?? this.context,
      createdAt: createdAt ?? this.createdAt,
    );
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
