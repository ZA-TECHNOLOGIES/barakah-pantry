import '../../domain/entities/quran_reference_entity.dart';

/// Quran Reference Model
/// Data layer model for quran references
class QuranReferenceModel extends QuranReferenceEntity {
  const QuranReferenceModel({
    required super.id,
    required super.ingredientId,
    required super.surahName,
    required super.surahNumber,
    required super.ayahNumber,
    super.arabicText,
    required super.translation,
    super.translator = 'Sahih International',
    super.context,
    required super.createdAt,
  });

  /// Create from JSON
  factory QuranReferenceModel.fromJson(Map<String, dynamic> json) {
    return QuranReferenceModel(
      id: json['id'] as String? ?? '',
      ingredientId: json['ingredient_id'] as String? ?? '',
      surahName: json['surah_name'] as String? ?? '',
      surahNumber: json['surah_number'] as int? ?? 0,
      ayahNumber: json['ayah_number'] as int? ?? 0,
      arabicText: json['arabic_text'] as String?,
      translation: json['translation'] as String? ?? '',
      translator: json['translator'] as String? ?? 'Sahih International',
      context: json['context'] as String?,
      createdAt: _parseDateTime(json['created_at']),
    );
  }

  /// Convert to JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'ingredient_id': ingredientId,
      'surah_name': surahName,
      'surah_number': surahNumber,
      'ayah_number': ayahNumber,
      'arabic_text': arabicText,
      'translation': translation,
      'translator': translator,
      'context': context,
    };
  }

  /// Create from entity
  factory QuranReferenceModel.fromEntity(QuranReferenceEntity entity) {
    return QuranReferenceModel(
      id: entity.id,
      ingredientId: entity.ingredientId,
      surahName: entity.surahName,
      surahNumber: entity.surahNumber,
      ayahNumber: entity.ayahNumber,
      arabicText: entity.arabicText,
      translation: entity.translation,
      translator: entity.translator,
      context: entity.context,
      createdAt: entity.createdAt,
    );
  }

  /// Copy with
  QuranReferenceModel copyWith({
    String? id,
    String? ingredientId,
    String? surahName,
    int? surahNumber,
    int? ayahNumber,
    String? arabicText,
    String? translation,
    String? translator,
    String? context,
    DateTime? createdAt,
  }) {
    return QuranReferenceModel(
      id: id ?? this.id,
      ingredientId: ingredientId ?? this.ingredientId,
      surahName: surahName ?? this.surahName,
      surahNumber: surahNumber ?? this.surahNumber,
      ayahNumber: ayahNumber ?? this.ayahNumber,
      arabicText: arabicText ?? this.arabicText,
      translation: translation ?? this.translation,
      translator: translator ?? this.translator,
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
