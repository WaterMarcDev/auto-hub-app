import 'dart:math' as math;

import 'package:auto_hub_app/core/constants/app_icons.dart';
import 'package:auto_hub_app/core/theme/app_colors.dart';
import 'package:auto_hub_app/core/theme/app_text_styles.dart';
import 'package:auto_hub_app/features/settings/presentation/widgets/delete_account_bottom_sheet.dart';
import 'package:auto_hub_app/features/settings/presentation/widgets/language_bottom_sheet.dart';
import 'package:auto_hub_app/features/settings/presentation/widgets/settings_action_tile.dart';
import 'package:auto_hub_app/features/settings/presentation/widgets/settings_group_card.dart';
import 'package:auto_hub_app/features/settings/presentation/widgets/settings_switch_tile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  // Notification States
  bool _pushNotifications = true;
  bool _emailNotifications = true;
  bool _priceDropAlerts = false;
  bool _orderUpdates = true;
  bool _chatMessages = true;

  // Sound & Haptics States
  bool _notificationSounds = true;
  bool _vibration = true;

  // Appearance States
  bool _darkMode = true;
  bool _autoDistanceUnit = true;
  String _selectedLanguage = 'English';
  String _selectedLanguageFlag = '🇺🇸';

  // Cache State
  double _cacheSizeMb = 23.4;

  void _clearCache() {
    if (_cacheSizeMb == 0.0) {
      ScaffoldMessenger.of(context)
        ..hideCurrentSnackBar()
        ..showSnackBar(
          const SnackBar(content: Text('Cache is already empty')),
        );
      return;
    }
    setState(() {
      _cacheSizeMb = 0.0;
    });
    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(
        const SnackBar(content: Text('Cache cleared successfully!')),
      );
  }

  void _clearSearchHistory() {
    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(
        const SnackBar(content: Text('Search history cleared!')),
      );
  }

  void _showLanguageBottomSheet() {
    showModalBottomSheet<void>(
      context: context,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      builder: (context) => LanguageBottomSheet(
        selectedLanguage: _selectedLanguage,
        onLanguageSelected: (langName, flag) {
          setState(() {
            _selectedLanguage = langName;
            _selectedLanguageFlag = flag;
          });
        },
      ),
    );
  }

  void _showDeleteAccountBottomSheet() {
    showModalBottomSheet<void>(
      context: context,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      builder: (context) => DeleteAccountBottomSheet(
        onDeleteConfirmed: () {
          ScaffoldMessenger.of(context)
            ..hideCurrentSnackBar()
            ..showSnackBar(
              const SnackBar(
                content: Text('Account deletion request submitted.'),
                backgroundColor: AppColors.error,
              ),
            );
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
            _buildTopBar(context),
            Expanded(
              child: SingleChildScrollView(
                padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 12.h),
                child: Column(
                  children: [
                    // Notifications Section
                    SettingsGroupCard(
                      title: 'Notifications',
                      children: [
                        SettingsSwitchTile(
                          title: 'Push Notifications',
                          subtitle: 'Get notified on your device',
                          value: _pushNotifications,
                          onChanged: (val) => setState(() => _pushNotifications = val),
                        ),
                        SettingsSwitchTile(
                          title: 'Email Notifications',
                          subtitle: 'Receive updates via email',
                          value: _emailNotifications,
                          onChanged: (val) => setState(() => _emailNotifications = val),
                        ),
                        SettingsSwitchTile(
                          title: 'Price Drop Alerts',
                          subtitle: 'Get notified when saved parts drop',
                          value: _priceDropAlerts,
                          onChanged: (val) => setState(() => _priceDropAlerts = val),
                        ),
                        SettingsSwitchTile(
                          title: 'Order Updates',
                          subtitle: 'Shipping and delivery notifications',
                          value: _orderUpdates,
                          onChanged: (val) => setState(() => _orderUpdates = val),
                        ),
                        SettingsSwitchTile(
                          title: 'Chat Messages',
                          subtitle: 'New message notifications',
                          value: _chatMessages,
                          showDivider: false,
                          onChanged: (val) => setState(() => _chatMessages = val),
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
                          value: _notificationSounds,
                          onChanged: (val) => setState(() => _notificationSounds = val),
                        ),
                        SettingsSwitchTile(
                          title: 'Vibration',
                          value: _vibration,
                          showDivider: false,
                          onChanged: (val) => setState(() => _vibration = val),
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
                          value: _darkMode,
                          onChanged: (val) => setState(() => _darkMode = val),
                        ),
                        SettingsSwitchTile(
                          title: 'Auto-detect Distance Unit',
                          subtitle: 'Use miles or km based on locale',
                          value: _autoDistanceUnit,
                          onChanged: (val) => setState(() => _autoDistanceUnit = val),
                        ),
                        SettingsActionTile(
                          title: 'Language',
                          leading: Icon(
                            Icons.language,
                            color: const Color(0xFF8B929A),
                            size: 20.sp,
                          ),
                          trailing: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text(
                                '$_selectedLanguageFlag ',
                                style: const TextStyle(fontSize: 16),
                              ),
                              Text(
                                _selectedLanguage,
                                style: AppTextStyles.bodyMedium.copyWith(
                                  color: AppColors.onboardingCyan,
                                  fontWeight: FontWeight.w600,
                                  fontSize: 14.sp,
                                ),
                              ),
                            ],
                          ),
                          showDivider: false,
                          onTap: _showLanguageBottomSheet,
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
                          subtitle: _cacheSizeMb > 0
                              ? 'Free up ${_cacheSizeMb.toStringAsFixed(1)} MB of storage'
                              : 'Cache is empty',
                          leading: Icon(
                            Icons.cached_rounded,
                            color: const Color(0xFF8B929A),
                            size: 20.sp,
                          ),
                          onTap: _clearCache,
                        ),
                        SettingsActionTile(
                          title: 'Clear Search History',
                          leading: Icon(
                            Icons.delete_outline_rounded,
                            color: const Color(0xFF8B929A),
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
                        color: const Color(0xFF484F58),
                        fontSize: 11.sp,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    SizedBox(height: 4.h),
                    Text(
                      'Build 2026.03.31 · Flutter',
                      textAlign: TextAlign.center,
                      style: AppTextStyles.bodySmall.copyWith(
                        color: const Color(0xFF2D333B),
                        fontSize: 10.sp,
                      ),
                    ),
                    SizedBox(height: 24.h),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTopBar(BuildContext context) {
    return SizedBox(
      height: 70.h,
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20.w),
        child: Row(
          children: [
            GestureDetector(
              onTap: () {
                if (Navigator.of(context).canPop()) {
                  Navigator.of(context).pop();
                }
              },
              child: Container(
                width: 36.w,
                height: 36.h,
                decoration: BoxDecoration(
                  color: AppColors.onboardingSurface,
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: Colors.white.withValues(alpha: 0.07),
                    width: 0.8,
                  ),
                ),
                alignment: Alignment.center,
                child: Transform.rotate(
                  angle: math.pi,
                  child: SvgPicture.asset(
                    AppIcons.chevronRight,
                    width: 16.w,
                    height: 16.h,
                    colorFilter: const ColorFilter.mode(
                      Colors.white,
                      BlendMode.srcIn,
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(width: 14.w),
            Text(
              'Settings',
              style: AppTextStyles.headlineLarge.copyWith(
                color: AppColors.onboardingTextPrimary,
                fontSize: 22.sp,
                fontWeight: FontWeight.w800,
                letterSpacing: -0.5,
                height: 1.5,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
