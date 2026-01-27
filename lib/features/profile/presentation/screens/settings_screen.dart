import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:barakah_pantry/core/constants/route_constants.dart';
import 'package:barakah_pantry/core/theme/app_colors.dart';
import 'package:barakah_pantry/core/theme/app_spacing.dart';
import 'package:barakah_pantry/core/theme/app_typography.dart';
import 'package:barakah_pantry/core/utils/helpers/ui_helper.dart';

/// Settings Screen
/// App settings and preferences
class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  bool _notificationsEnabled = true;
  bool _dailyRemindersEnabled = true;
  String _reminderTime = '09:00 AM';
  bool _darkModeEnabled = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: AppColors.textPrimary),
          onPressed: () => Get.back(),
        ),
        title: Text(
          'Settings',
          style: AppTypography.h3.copyWith(
            color: AppColors.textPrimary,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Notifications Section
            Padding(
              padding: EdgeInsets.all(AppSpacing.md),
              child: Text(
                'Notifications',
                style: AppTypography.h3.copyWith(
                  color: AppColors.textPrimary,
                ),
              ),
            ),
            Container(
              color: Colors.white,
              child: Column(
                children: [
                  SwitchListTile(
                    title: Text(
                      'Push Notifications',
                      style: AppTypography.body1.copyWith(
                        color: AppColors.textPrimary,
                      ),
                    ),
                    subtitle: Text(
                      'Receive notifications about new recipes and tips',
                      style: AppTypography.caption.copyWith(
                        color: AppColors.textSecondary,
                      ),
                    ),
                    value: _notificationsEnabled,
                    activeColor: AppColors.primary,
                    onChanged: (value) {
                      setState(() => _notificationsEnabled = value);
                    },
                  ),
                  const Divider(height: 1),
                  SwitchListTile(
                    title: Text(
                      'Daily Reminders',
                      style: AppTypography.body1.copyWith(
                        color: AppColors.textPrimary,
                      ),
                    ),
                    subtitle: Text(
                      'Get daily Barakah tips',
                      style: AppTypography.caption.copyWith(
                        color: AppColors.textSecondary,
                      ),
                    ),
                    value: _dailyRemindersEnabled,
                    activeColor: AppColors.primary,
                    onChanged: (value) {
                      setState(() => _dailyRemindersEnabled = value);
                    },
                  ),
                  if (_dailyRemindersEnabled) ...[
                    const Divider(height: 1),
                    ListTile(
                      leading: const Icon(Icons.access_time,
                          color: AppColors.primary),
                      title: Text(
                        'Reminder Time',
                        style: AppTypography.body1.copyWith(
                          color: AppColors.textPrimary,
                        ),
                      ),
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            _reminderTime,
                            style: AppTypography.body2.copyWith(
                              color: AppColors.primary,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(width: AppSpacing.xs),
                          const Icon(Icons.arrow_forward_ios, size: 16),
                        ],
                      ),
                      onTap: () async {
                        final TimeOfDay? picked = await showTimePicker(
                          context: context,
                          initialTime: TimeOfDay.now(),
                        );
                        if (picked != null) {
                          setState(() {
                            _reminderTime = picked.format(context);
                          });
                        }
                      },
                    ),
                  ],
                ],
              ),
            ),

            SizedBox(height: AppSpacing.lg),

            // Appearance Section
            Padding(
              padding: EdgeInsets.all(AppSpacing.md),
              child: Text(
                'Appearance',
                style: AppTypography.h3.copyWith(
                  color: AppColors.textPrimary,
                ),
              ),
            ),
            Container(
              color: Colors.white,
              child: Column(
                children: [
                  SwitchListTile(
                    title: Text(
                      'Dark Mode',
                      style: AppTypography.body1.copyWith(
                        color: AppColors.textPrimary,
                      ),
                    ),
                    subtitle: Text(
                      'Use dark theme',
                      style: AppTypography.caption.copyWith(
                        color: AppColors.textSecondary,
                      ),
                    ),
                    value: _darkModeEnabled,
                    activeColor: AppColors.primary,
                    onChanged: (value) {
                      setState(() => _darkModeEnabled = value);
                      UIHelper.showSnackbar(
                        title: 'Coming Soon',
                        message:
                            'Dark mode will be available in the next update',
                        backgroundColor: AppColors.info,
                      );
                    },
                  ),
                ],
              ),
            ),

            SizedBox(height: AppSpacing.lg),

            // Account Section
            Padding(
              padding: EdgeInsets.all(AppSpacing.md),
              child: Text(
                'Account',
                style: AppTypography.h3.copyWith(
                  color: AppColors.textPrimary,
                ),
              ),
            ),
            Container(
              color: Colors.white,
              child: Column(
                children: [
                  ListTile(
                    leading: const Icon(Icons.lock_outline,
                        color: AppColors.primary),
                    title: Text(
                      'Change Password',
                      style: AppTypography.body1.copyWith(
                        color: AppColors.textPrimary,
                      ),
                    ),
                    trailing: const Icon(Icons.arrow_forward_ios, size: 16),
                    onTap: () {
                      // TODO: Navigate to change password screen
                      UIHelper.showSnackbar(
                        title: 'Coming Soon',
                        message: 'Change password feature coming soon',
                        backgroundColor: AppColors.info,
                      );
                    },
                  ),
                  const Divider(height: 1),
                  ListTile(
                    leading: const Icon(Icons.privacy_tip_outlined,
                        color: AppColors.primary),
                    title: Text(
                      'Privacy Policy',
                      style: AppTypography.body1.copyWith(
                        color: AppColors.textPrimary,
                      ),
                    ),
                    trailing: const Icon(Icons.arrow_forward_ios, size: 16),
                    onTap: () {
                      // TODO: Show privacy policy
                    },
                  ),
                  const Divider(height: 1),
                  ListTile(
                    leading: const Icon(Icons.description_outlined,
                        color: AppColors.primary),
                    title: Text(
                      'Terms of Service',
                      style: AppTypography.body1.copyWith(
                        color: AppColors.textPrimary,
                      ),
                    ),
                    trailing: const Icon(Icons.arrow_forward_ios, size: 16),
                    onTap: () {
                      // TODO: Show terms of service
                    },
                  ),
                ],
              ),
            ),

            SizedBox(height: AppSpacing.lg),

            // Data Section
            Padding(
              padding: EdgeInsets.all(AppSpacing.md),
              child: Text(
                'Data',
                style: AppTypography.h3.copyWith(
                  color: AppColors.textPrimary,
                ),
              ),
            ),
            Container(
              color: Colors.white,
              child: Column(
                children: [
                  ListTile(
                    leading: const Icon(Icons.cloud_download_outlined,
                        color: AppColors.primary),
                    title: Text(
                      'Export Data',
                      style: AppTypography.body1.copyWith(
                        color: AppColors.textPrimary,
                      ),
                    ),
                    subtitle: Text(
                      'Download your data',
                      style: AppTypography.caption.copyWith(
                        color: AppColors.textSecondary,
                      ),
                    ),
                    trailing: const Icon(Icons.arrow_forward_ios, size: 16),
                    onTap: () {
                      // TODO: Export data
                      UIHelper.showSnackbar(
                        title: 'Coming Soon',
                        message: 'Data export feature coming soon',
                        backgroundColor: AppColors.info,
                      );
                    },
                  ),
                  const Divider(height: 1),
                  ListTile(
                    leading: const Icon(Icons.delete_outline,
                        color: AppColors.error),
                    title: Text(
                      'Delete Account',
                      style: AppTypography.body1.copyWith(
                        color: AppColors.error,
                      ),
                    ),
                    subtitle: Text(
                      'Permanently delete your account',
                      style: AppTypography.caption.copyWith(
                        color: AppColors.textSecondary,
                      ),
                    ),
                    trailing: const Icon(Icons.arrow_forward_ios,
                        size: 16, color: AppColors.error),
                    onTap: () {
                      _showDeleteAccountDialog();
                    },
                  ),
                ],
              ),
            ),

            SizedBox(height: AppSpacing.lg),

            // About Section
            Padding(
              padding: EdgeInsets.all(AppSpacing.md),
              child: Text(
                'About',
                style: AppTypography.h3.copyWith(
                  color: AppColors.textPrimary,
                ),
              ),
            ),
            Container(
              color: Colors.white,
              child: Column(
                children: [
                  ListTile(
                    leading: const Icon(Icons.info_outline,
                        color: AppColors.primary),
                    title: Text(
                      'App Version',
                      style: AppTypography.body1.copyWith(
                        color: AppColors.textPrimary,
                      ),
                    ),
                    trailing: Text(
                      '1.0.0',
                      style: AppTypography.body2.copyWith(
                        color: AppColors.textSecondary,
                      ),
                    ),
                  ),
                  const Divider(height: 1),
                  ListTile(
                    leading: const Icon(Icons.star_outline,
                        color: AppColors.primary),
                    title: Text(
                      'Rate Us',
                      style: AppTypography.body1.copyWith(
                        color: AppColors.textPrimary,
                      ),
                    ),
                    trailing: const Icon(Icons.arrow_forward_ios, size: 16),
                    onTap: () {
                      // TODO: Open app store
                    },
                  ),
                ],
              ),
            ),

            SizedBox(height: AppSpacing.xxl),
          ],
        ),
      ),
    );
  }

  void _showDeleteAccountDialog() {
    Get.dialog(
      AlertDialog(
        title: Text(
          'Delete Account',
          style: AppTypography.h3.copyWith(
            color: AppColors.textPrimary,
          ),
        ),
        content: Text(
          'Are you sure you want to delete your account? This action cannot be undone.',
          style: AppTypography.body2.copyWith(
            color: AppColors.textSecondary,
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Get.back(),
            child: Text(
              'Cancel',
              style: AppTypography.button.copyWith(
                color: AppColors.textSecondary,
              ),
            ),
          ),
          TextButton(
            onPressed: () {
              Get.back();
              // TODO: Delete account
              UIHelper.showSnackbar(
                title: 'Account Deleted',
                message: 'Your account has been deleted',
                backgroundColor: AppColors.error,
              );
            },
            child: Text(
              'Delete',
              style: AppTypography.button.copyWith(
                color: AppColors.error,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
