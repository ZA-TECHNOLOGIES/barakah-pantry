import 'package:equatable/equatable.dart';

/// Quran Reference Entity
/// Domain layer entity for Quran references
class QuranReferenceEntity extends Equatable {
  final String id;
  final String ingredientId;
  final String surahName;
  final int surahNumber;
  final int ayahNumber;
  final String? arabicText;
  final String translation;
  final String translator;
  final String? context;
  final DateTime createdAt;

  const QuranReferenceEntity({
    required this.id,
    required this.ingredientId,
    required this.surahName,
    required this.surahNumber,
    required this.ayahNumber,
    this.arabicText,
    required this.translation,
    this.translator = 'Sahih International',
    this.context,
    required this.createdAt,
  });

  /// Get reference string (e.g., "An-Nahl 16:69")
  String get reference => '$surahName $surahNumber:$ayahNumber';

  /// Get short reference (e.g., "16:69")
  String get shortReference => '$surahNumber:$ayahNumber';

  /// Get formatted citation
  String get citation {
    return '"$translation" ($reference)';
  }

  /// Get Quran.com link
  String get quranComLink => 'https://quran.com/$surahNumber:$ayahNumber';

  /// Get formatted display with Arabic
  String get displayWithArabic {
    final buffer = StringBuffer();
    if (arabicText != null && arabicText!.isNotEmpty) {
      buffer.writeln(arabicText);
      buffer.writeln();
    }
    buffer.writeln('"$translation"');
    buffer.write('— $reference');
    return buffer.toString();
  }

  @override
  List<Object?> get props => [
        id,
        ingredientId,
        surahName,
        surahNumber,
        ayahNumber,
        arabicText,
        translation,
        translator,
        context,
        createdAt,
      ];
}
