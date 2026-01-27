import '../../domain/entities/user_entity.dart';

/// User Model
/// Data layer model for user
class UserModel extends UserEntity {
  const UserModel({
    required super.id,
    required super.email,
    super.fullName,
    super.avatarUrl,
    super.phone,
    super.goals = const [],
    super.dietaryPreferences = const [],
    super.onboardingCompleted = false,
    super.dailyReminderEnabled = true,
    super.reminderTime,
    required super.createdAt,
    required super.updatedAt,
  });

  /// Create from JSON
  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'] as String? ?? '',
      email: json['email'] as String? ?? '',
      fullName: json['full_name'] as String?,
      avatarUrl: json['avatar_url'] as String?,
      phone: json['phone'] as String?,
      goals: _parseStringList(json['goals']),
      dietaryPreferences: _parseStringList(json['dietary_preferences']),
      onboardingCompleted: json['onboarding_completed'] as bool? ?? false,
      dailyReminderEnabled: json['daily_reminder_enabled'] as bool? ?? true,
      reminderTime: json['reminder_time'] as String?,
      createdAt: _parseDateTime(json['created_at']),
      updatedAt: _parseDateTime(json['updated_at']),
    );
  }

  /// Convert to JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'email': email,
      'full_name': fullName,
      'avatar_url': avatarUrl,
      'phone': phone,
      'goals': goals,
      'dietary_preferences': dietaryPreferences,
      'onboarding_completed': onboardingCompleted,
      'daily_reminder_enabled': dailyReminderEnabled,
      'reminder_time': reminderTime,
    };
  }

  /// Create from Supabase auth user
  factory UserModel.fromAuthUser(dynamic authUser,
      {Map<String, dynamic>? profile}) {
    return UserModel(
      id: authUser.id as String,
      email: authUser.email as String? ?? '',
      fullName: profile?['full_name'] as String? ??
          authUser.userMetadata?['full_name'] as String?,
      avatarUrl: profile?['avatar_url'] as String?,
      phone: profile?['phone'] as String?,
      goals: _parseStringList(profile?['goals']),
      dietaryPreferences: _parseStringList(profile?['dietary_preferences']),
      onboardingCompleted: profile?['onboarding_completed'] as bool? ?? false,
      dailyReminderEnabled: profile?['daily_reminder_enabled'] as bool? ?? true,
      reminderTime: profile?['reminder_time'] as String?,
      createdAt: _parseDateTime(profile?['created_at']),
      updatedAt: _parseDateTime(profile?['updated_at']),
    );
  }

  /// Create from entity
  factory UserModel.fromEntity(UserEntity entity) {
    return UserModel(
      id: entity.id,
      email: entity.email,
      fullName: entity.fullName,
      avatarUrl: entity.avatarUrl,
      phone: entity.phone,
      goals: entity.goals,
      dietaryPreferences: entity.dietaryPreferences,
      onboardingCompleted: entity.onboardingCompleted,
      dailyReminderEnabled: entity.dailyReminderEnabled,
      reminderTime: entity.reminderTime,
      createdAt: entity.createdAt,
      updatedAt: entity.updatedAt,
    );
  }

  /// Copy with
  UserModel copyWith({
    String? id,
    String? email,
    String? fullName,
    String? avatarUrl,
    String? phone,
    List<String>? goals,
    List<String>? dietaryPreferences,
    bool? onboardingCompleted,
    bool? dailyReminderEnabled,
    String? reminderTime,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return UserModel(
      id: id ?? this.id,
      email: email ?? this.email,
      fullName: fullName ?? this.fullName,
      avatarUrl: avatarUrl ?? this.avatarUrl,
      phone: phone ?? this.phone,
      goals: goals ?? this.goals,
      dietaryPreferences: dietaryPreferences ?? this.dietaryPreferences,
      onboardingCompleted: onboardingCompleted ?? this.onboardingCompleted,
      dailyReminderEnabled: dailyReminderEnabled ?? this.dailyReminderEnabled,
      reminderTime: reminderTime ?? this.reminderTime,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  // Helper methods
  static List<String> _parseStringList(dynamic value) {
    if (value == null) return [];
    if (value is List) {
      return value.map((e) => e.toString()).toList();
    }
    return [];
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
