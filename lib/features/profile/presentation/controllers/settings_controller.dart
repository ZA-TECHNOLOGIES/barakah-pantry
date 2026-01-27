import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SettingsController extends GetxController {
  final notificationsEnabled = true.obs;
  final dailyRemindersEnabled = true.obs;
  final reminderTime = Rx<TimeOfDay>(const TimeOfDay(hour: 9, minute: 0));
  final darkModeEnabled = false.obs;

  @override
  void onInit() {
    super.onInit();
    // Load from SharedPreferences or User Profile
    // For MVP, just defaults or local storage
  }

  void toggleNotifications(bool value) {
    notificationsEnabled.value = value;
    // Save to prefs
  }

  void toggleDailyReminders(bool value) {
    dailyRemindersEnabled.value = value;
    // Save to prefs
  }

  void setReminderTime(TimeOfDay time) {
    reminderTime.value = time;
    // Save
  }

  void toggleDarkMode(bool value) {
    darkModeEnabled.value = value;
    Get.changeThemeMode(value ? ThemeMode.dark : ThemeMode.light);
    // Save
  }
}
