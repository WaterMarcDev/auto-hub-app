import 'package:auto_hub_app/core/theme/app_colors.dart';
import 'package:auto_hub_app/core/theme/app_text_styles.dart';
import 'package:auto_hub_app/features/settings/data/repositories/settings_repository.dart';
import 'package:auto_hub_app/features/settings/domain/models/app_settings.dart';
import 'package:auto_hub_app/features/settings/presentation/widgets/delete_account_bottom_sheet.dart';
import 'package:auto_hub_app/features/settings/presentation/widgets/language_bottom_sheet.dart';
import 'package:auto_hub_app/features/settings/presentation/widgets/settings_action_tile.dart';
import 'package:auto_hub_app/features/settings/presentation/widgets/settings_group_card.dart';
import 'package:auto_hub_app/features/settings/presentation/widgets/settings_switch_tile.dart';
import 'package:auto_hub_app/features/settings/presentation/widgets/settings_top_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  late final SettingsRepository _repository;

  @override
  void initState() {
    super.initState();
    _repository = SettingsRepository();
  }

  Future<void> _clearCache(double currentCache) async {
    if (currentCache == 0.0) {
      ScaffoldMessenger.of(context)
        ..hideCurrentSnackBar()
        ..showSnackBar(
          const SnackBar(content: Text('Cache is already empty')),
        );
      return;
    }

    await _repository.clearCache();

    if (mounted) {
      ScaffoldMessenger.of(context)
        ..hideCurrentSnackBar()
        ..showSnackBar(
          const SnackBar(content: Text('Cache cleared successfully!')),
        );
    }
  }

  Future<void> _clearSearchHistory() async {
    await _repository.clearSearchHistory();
    if (mounted) {
      ScaffoldMessenger.of(context)
        ..hideCurrentSnackBar()
        ..showSnackBar(
          const SnackBar(content: Text('Search history cleared!')),
        );
    }
  }

  Future<void> _showLanguageBottomSheet(String currentLang) async {
    await showModalBottomSheet<void>(
      context: context,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      builder: (context) => LanguageBottomSheet(
        selectedLanguage: currentLang,
        onLanguageSelected: (langName, flag) {
          _repository.updateLanguage(langName, flag);
        },
      ),
    );
  }

  Future<void> _showDeleteAccountBottomSheet() async {
    await showModalBottomSheet<void>(
      context: context,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      builder: (context) => DeleteAccountBottomSheet(
        onDeleteConfirmed: () async {
          await _repository.requestAccountDeletion();
          if (mounted) {
            ScaffoldMessenger.of(context)
              ..hideCurrentSnackBar()
              ..showSnackBar(
                const SnackBar(
                  content: Text('Account deletion request submitted.'),
                  backgroundColor: AppColors.error,
                ),
              );
          }
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.onboardingBackground,
      body: SafeArea(
        bottom: false,
        child: Column(
          children: [
            const SettingsTopBar(),
            Expanded(
              child: StreamBuilder<AppSettings>(
                stream: _repository.settingsStream,
                initialData: _repository.currentSettings,
                builder: (context, snapshot) {
                  final settings = snapshot.data!;
                  return SingleChildScrollView(
                    padding: EdgeInsets.symmetric(
                      horizontal: 20.w,
                      vertical: 12.h,
                    ),
                    child: Column(
                      children: [
                        // Notifications Section
                        SettingsGroupCard(
                          title: 'Notifications',
                          children: [
                            SettingsSwitchTile(
                              title: 'Push Notifications',
                              subtitle: 'Get notified on your device',
                              value: settings.pushNotifications,
                              onChanged: _repository.updatePushNotifications,
                            ),
                            SettingsSwitchTile(
                              title: 'Email Notifications',
                              subtitle: 'Receive updates via email',
                              value: settings.emailNotifications,
                              onChanged: _repository.updateEmailNotifications,
                            ),
                            SettingsSwitchTile(
                              title: 'Price Drop Alerts',
                              subtitle: 'Get notified when saved parts drop',
                              value: settings.priceDropAlerts,
                              onChanged: _repository.updatePriceDropAlerts,
                            ),
                            SettingsSwitchTile(
                              title: 'Order Updates',
                              subtitle: 'Shipping and delivery notifications',
                              value: settings.orderUpdates,
                              onChanged: _repository.updateOrderUpdates,
                            ),
                            SettingsSwitchTile(
                              title: 'Chat Messages',
                              subtitle: 'New message notifications',
                              value: settings.chatMessages,
                              showDivider: false,
                              onChanged: _repository.updateChatMessages,
                            ),
                          ],
                        ),
                        SizedBox(height: 16.h),

                        // Sound & Haptics Section
                        SettingsGroupCard(
                          title: 'Sound & Haptics',
                          children: [
                            SettingsSwitchTile(
                              title: 'Notification Sounds',
                              value: settings.notificationSounds,
                              onChanged: _repository.updateNotificationSounds,
                            ),
                            SettingsSwitchTile(
                              title: 'Vibration',
                              value: settings.vibration,
                              showDivider: false,
                              onChanged: _repository.updateVibration,
                            ),
                          ],
                        ),
                        SizedBox(height: 16.h),

                        // Appearance Section
                        SettingsGroupCard(
                          title: 'Appearance',
                          children: [
                            SettingsSwitchTile(
                              title: 'Dark Mode',
                              subtitle: 'Use dark color scheme',
                              value: settings.darkMode,
                              onChanged: _repository.updateDarkMode,
                            ),
                            SettingsSwitchTile(
                              title: 'Auto-detect Distance Unit',
                              subtitle: 'Use miles or km based on locale',
                              value: settings.autoDistanceUnit,
                              onChanged: _repository.updateAutoDistanceUnit,
                            ),
                            SettingsActionTile(
                              title: 'Language',
                              leading: Icon(
                                Icons.language,
                                color: AppColors.onboardingTextSecondary,
                                size: 20.sp,
                              ),
                              trailing: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Text(
                                    '${settings.selectedLanguageFlag} ',
                                    style: TextStyle(fontSize: 16.sp),
                                  ),
                                  Text(
                                    settings.selectedLanguage,
                                    style: AppTextStyles.bodyMedium.copyWith(
                                      color: AppColors.onboardingCyan,
                                      fontWeight: FontWeight.w600,
                                      fontSize: 14.sp,
                                    ),
                                  ),
                                ],
                              ),
                              showDivider: false,
                              onTap: () => _showLanguageBottomSheet(
                                settings.selectedLanguage,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 16.h),

                        // Data & Storage Section
                        SettingsGroupCard(
                          title: 'Data & Storage',
                          children: [
                            SettingsActionTile(
                              title: 'Clear Cache',
                              subtitle: settings.cacheSizeMb > 0
                                  ? 'Free up ${settings.cacheSizeMb.toStringAsFixed(1)} MB of storage'
                                  : 'Cache is empty',
                              leading: Icon(
                                Icons.cached_rounded,
                                color: AppColors.onboardingTextSecondary,
                                size: 20.sp,
                              ),
                              onTap: () => _clearCache(settings.cacheSizeMb),
                            ),
                            SettingsActionTile(
                              title: 'Clear Search History',
                              leading: Icon(
                                Icons.delete_outline_rounded,
                                color: AppColors.onboardingTextSecondary,
                                size: 20.sp,
                              ),
                              showDivider: false,
                              onTap: _clearSearchHistory,
                            ),
                          ],
                        ),
                        SizedBox(height: 16.h),

                        // Danger Zone Section
                        SettingsGroupCard(
                          title: 'Danger Zone',
                          children: [
                            SettingsActionTile(
                              title: 'Delete Account',
                              subtitle: 'Permanently delete all your data',
                              titleColor: AppColors.error,
                              leading: Container(
                                width: 32.w,
                                height: 32.h,
                                decoration: BoxDecoration(
                                  color: AppColors.error.withValues(alpha: 0.1),
                                  shape: BoxShape.circle,
                                ),
                                alignment: Alignment.center,
                                child: Icon(
                                  Icons.warning_amber_rounded,
                                  color: AppColors.error,
                                  size: 16.sp,
                                ),
                              ),
                              showDivider: false,
                              onTap: _showDeleteAccountBottomSheet,
                            ),
                          ],
                        ),
                        SizedBox(height: 32.h),

                        // Version Info
                        Text(
                          'AutoHub Express v2.4.1',
                          textAlign: TextAlign.center,
                          style: AppTextStyles.bodySmall.copyWith(
                            color: AppColors.textTertiary,
                            fontSize: 11.sp,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        SizedBox(height: 4.h),
                        Text(
                          'Build 2026.03.31 · Flutter',
                          textAlign: TextAlign.center,
                          style: AppTextStyles.bodySmall.copyWith(
                            color: AppColors.colorLightGray,
                            fontSize: 10.sp,
                          ),
                        ),
                        SizedBox(height: 24.h),
                      ],
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
