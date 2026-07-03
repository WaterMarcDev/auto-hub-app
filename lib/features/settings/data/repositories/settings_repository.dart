import 'dart:async';

import 'package:auto_hub_app/features/settings/domain/models/app_settings.dart';

class SettingsRepository {
  factory SettingsRepository() => _instance;
  SettingsRepository._internal();
  // Singleton pattern for the mock repository
  static final SettingsRepository _instance = SettingsRepository._internal();

  AppSettings _settings = const AppSettings();

  // Stream controller to broadcast settings changes
  final _settingsController = StreamController<AppSettings>.broadcast();
  
  Stream<AppSettings> get settingsStream => _settingsController.stream;
  AppSettings get currentSettings => _settings;

  void _updateSettings(AppSettings newSettings) {
    _settings = newSettings;
    _settingsController.add(_settings);
  }

  Future<void> updatePushNotifications(bool value) async {
    // Simulate async operation
    await Future.delayed(const Duration(milliseconds: 100));
    _updateSettings(_settings.copyWith(pushNotifications: value));
  }

  Future<void> updateEmailNotifications(bool value) async {
    await Future.delayed(const Duration(milliseconds: 100));
    _updateSettings(_settings.copyWith(emailNotifications: value));
  }

  Future<void> updatePriceDropAlerts(bool value) async {
    await Future.delayed(const Duration(milliseconds: 100));
    _updateSettings(_settings.copyWith(priceDropAlerts: value));
  }

  Future<void> updateOrderUpdates(bool value) async {
    await Future.delayed(const Duration(milliseconds: 100));
    _updateSettings(_settings.copyWith(orderUpdates: value));
  }

  Future<void> updateChatMessages(bool value) async {
    await Future.delayed(const Duration(milliseconds: 100));
    _updateSettings(_settings.copyWith(chatMessages: value));
  }

  Future<void> updateNotificationSounds(bool value) async {
    await Future.delayed(const Duration(milliseconds: 100));
    _updateSettings(_settings.copyWith(notificationSounds: value));
  }

  Future<void> updateVibration(bool value) async {
    await Future.delayed(const Duration(milliseconds: 100));
    _updateSettings(_settings.copyWith(vibration: value));
  }

  Future<void> updateDarkMode(bool value) async {
    await Future.delayed(const Duration(milliseconds: 100));
    _updateSettings(_settings.copyWith(darkMode: value));
  }

  Future<void> updateAutoDistanceUnit(bool value) async {
    await Future.delayed(const Duration(milliseconds: 100));
    _updateSettings(_settings.copyWith(autoDistanceUnit: value));
  }

  Future<void> updateLanguage(String language, String flag) async {
    await Future.delayed(const Duration(milliseconds: 100));
    _updateSettings(_settings.copyWith(
      selectedLanguage: language,
      selectedLanguageFlag: flag,
    ));
  }

  Future<void> clearCache() async {
    await Future.delayed(const Duration(milliseconds: 300));
    _updateSettings(_settings.copyWith(cacheSizeMb: 0.0));
  }

  Future<void> clearSearchHistory() async {
    await Future.delayed(const Duration(milliseconds: 300));
    // Implementation would go here to clear search history
  }

  Future<void> requestAccountDeletion() async {
    await Future.delayed(const Duration(seconds: 1));
    // Implementation would go here for account deletion
  }

  void dispose() {
    _settingsController.close();
  }
}
