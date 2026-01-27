import 'dart:convert';
import '../../../core/constants/storage_keys.dart';
import '../../../core/errors/exceptions.dart';
import '../../../core/services/storage/local_storage_service.dart';
import '../../models/user_model.dart';

/// User Local Datasource Interface
abstract class UserLocalDatasource {
  /// Get cached user profile
  Future<UserModel?> getCachedUser();

  /// Cache user profile
  Future<void> cacheUser(UserModel user);

  /// Get user ID
  String? getUserId();

  /// Set user ID
  Future<void> setUserId(String odId);

  /// Check if onboarding is completed
  bool isOnboardingCompleted();

  /// Set onboarding completed
  Future<void> setOnboardingCompleted(bool completed);

  /// Get user goals
  List<String> getUserGoals();

  /// Set user goals
  Future<void> setUserGoals(List<String> goals);

  /// Get daily reminder settings
  bool isDailyReminderEnabled();

  /// Set daily reminder settings
  Future<void> setDailyReminderEnabled(bool enabled);

  /// Get reminder time
  String? getReminderTime();

  /// Set reminder time
  Future<void> setReminderTime(String time);

  /// Clear user data
  Future<void> clearUserData();

  /// Check if user is logged in
  bool isLoggedIn();

  /// Set logged in status
  Future<void> setLoggedIn(bool loggedIn);
}

/// User Local Datasource Implementation
class UserLocalDatasourceImpl implements UserLocalDatasource {
  final LocalStorageService storage;

  UserLocalDatasourceImpl({required this.storage});

  //═══════════════════════════════════════════════════════════════
  // USER PROFILE
  //═══════════════════════════════════════════════════════════════

  @override
  Future<UserModel?> getCachedUser() async {
    try {
      final jsonString = storage.getString(StorageKeys.userProfile);
      if (jsonString == null) return null;

      final json = jsonDecode(jsonString) as Map<String, dynamic>;
      return UserModel.fromJson(json);
    } catch (e) {
      return null;
    }
  }

  @override
  Future<void> cacheUser(UserModel user) async {
    try {
      final jsonString = jsonEncode(user.toJson());
      await storage.setString(StorageKeys.userProfile, jsonString);
    } catch (e) {
      throw CacheException.writeError(e.toString());
    }
  }

  //═══════════════════════════════════════════════════════════════
  // USER ID
  //═══════════════════════════════════════════════════════════════

  @override
  String? getUserId() {
    return storage.getString(StorageKeys.userId);
  }

  @override
  Future<void> setUserId(String odId) async {
    await storage.setString(StorageKeys.userId, odId);
  }

  //═══════════════════════════════════════════════════════════════
  // ONBOARDING
  //═══════════════════════════════════════════════════════════════

  @override
  bool isOnboardingCompleted() {
    return storage.getBool(StorageKeys.onboardingCompleted) ?? false;
  }

  @override
  Future<void> setOnboardingCompleted(bool completed) async {
    await storage.setBool(StorageKeys.onboardingCompleted, completed);
  }

  //═══════════════════════════════════════════════════════════════
  // USER GOALS
  //═══════════════════════════════════════════════════════════════

  @override
  List<String> getUserGoals() {
    return storage.getStringList(StorageKeys.userGoals) ?? [];
  }

  @override
  Future<void> setUserGoals(List<String> goals) async {
    await storage.setStringList(StorageKeys.userGoals, goals);
  }

  //═══════════════════════════════════════════════════════════════
  // REMINDER SETTINGS
  //═══════════════════════════════════════════════════════════════

  @override
  bool isDailyReminderEnabled() {
    return storage.getBool(StorageKeys.dailyReminderEnabled) ?? true;
  }

  @override
  Future<void> setDailyReminderEnabled(bool enabled) async {
    await storage.setBool(StorageKeys.dailyReminderEnabled, enabled);
  }

  @override
  String? getReminderTime() {
    return storage.getString(StorageKeys.reminderTime);
  }

  @override
  Future<void> setReminderTime(String time) async {
    await storage.setString(StorageKeys.reminderTime, time);
  }

  //═══════════════════════════════════════════════════════════════
  // LOGIN STATUS
  //═══════════════════════════════════════════════════════════════

  @override
  bool isLoggedIn() {
    return storage.getBool(StorageKeys.isLoggedIn) ?? false;
  }

  @override
  Future<void> setLoggedIn(bool loggedIn) async {
    await storage.setBool(StorageKeys.isLoggedIn, loggedIn);
  }

  //═══════════════════════════════════════════════════════════════
  // CLEAR DATA
  //═══════════════════════════════════════════════════════════════

  @override
  Future<void> clearUserData() async {
    await storage.remove(StorageKeys.userProfile);
    await storage.remove(StorageKeys.userId);
    await storage.remove(StorageKeys.isLoggedIn);
    await storage.remove(StorageKeys.userGoals);
    await storage.remove(StorageKeys.accessToken);
    await storage.remove(StorageKeys.refreshToken);
  }
}
