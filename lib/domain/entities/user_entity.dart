import 'package:equatable/equatable.dart';

/// User Entity
/// Domain layer entity for user
class UserEntity extends Equatable {
  final String id;
  final String email;
  final String? fullName;
  final String? avatarUrl;
  final String? phone;
  final List<String> goals;
  final List<String> dietaryPreferences;
  final bool onboardingCompleted;
  final bool dailyReminderEnabled;
  final String? reminderTime;
  final DateTime createdAt;
  final DateTime updatedAt;

  const UserEntity({
    required this.id,
    required this.email,
    this.fullName,
    this.avatarUrl,
    this.phone,
    this.goals = const [],
    this.dietaryPreferences = const [],
    this.onboardingCompleted = false,
    this.dailyReminderEnabled = true,
    this.reminderTime,
    required this.createdAt,
    required this.updatedAt,
  });

  /// Get first name
  String get firstName {
    if (fullName == null || fullName!.isEmpty) return '';
    return fullName!.split(' ').first;
  }

  /// Get last name
  String get lastName {
    if (fullName == null || fullName!.isEmpty) return '';
    final parts = fullName!.split(' ');
    if (parts.length < 2) return '';
    return parts.sublist(1).join(' ');
  }

  /// Get initials
  String get initials {
    if (fullName == null || fullName!.isEmpty) {
      return email.isNotEmpty ? email[0].toUpperCase() : '?';
    }
    final parts = fullName!.trim().split(' ');
    if (parts.isEmpty) return '?';
    if (parts.length == 1) {
      return parts[0].isNotEmpty ? parts[0][0].toUpperCase() : '?';
    }
    return '${parts.first[0]}${parts.last[0]}'.toUpperCase();
  }

  /// Get display name (full name or email)
  String get displayName {
    if (fullName != null && fullName!.isNotEmpty) {
      return fullName!;
    }
    return email.split('@').first;
  }

  /// Get greeting name (first name or display name)
  String get greetingName {
    final first = firstName;
    if (first.isNotEmpty) return first;
    return displayName;
  }

  /// Check if has avatar
  bool get hasAvatar => avatarUrl != null && avatarUrl!.isNotEmpty;

  /// Check if has phone
  bool get hasPhone => phone != null && phone!.isNotEmpty;

  /// Check if has goals set
  bool get hasGoals => goals.isNotEmpty;

  /// Check if has dietary preferences set
  bool get hasDietaryPreferences => dietaryPreferences.isNotEmpty;

  /// Check if profile is complete
  bool get isProfileComplete {
    return fullName != null &&
        fullName!.isNotEmpty &&
        onboardingCompleted &&
        hasGoals;
  }

  /// Get profile completion percentage
  int get profileCompletionPercentage {
    int score = 0;
    if (fullName != null && fullName!.isNotEmpty) score += 20;
    if (hasAvatar) score += 20;
    if (hasPhone) score += 10;
    if (onboardingCompleted) score += 20;
    if (hasGoals) score += 20;
    if (hasDietaryPreferences) score += 10;
    return score;
  }

  /// Get account age in days
  int get accountAgeDays {
    return DateTime.now().difference(createdAt).inDays;
  }

  @override
  List<Object?> get props => [
        id,
        email,
        fullName,
        avatarUrl,
        phone,
        goals,
        dietaryPreferences,
        onboardingCompleted,
        dailyReminderEnabled,
        reminderTime,
        createdAt,
        updatedAt,
      ];
}
