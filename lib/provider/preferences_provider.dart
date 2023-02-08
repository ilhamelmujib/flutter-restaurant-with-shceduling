import 'package:flutter/material.dart';

import '../data/preferences/preferences_helper.dart';

class PreferencesProvider extends ChangeNotifier {
  PreferencesHelper preferencesHelper;

  PreferencesProvider({required this.preferencesHelper}) {
    _getDailyNotificationPreferences();
  }

  bool _isDailyNotificationActive = false;
  bool get isDailyNotificationActive => _isDailyNotificationActive;

  void _getDailyNotificationPreferences() async {
    _isDailyNotificationActive = await preferencesHelper.isDailyNotificationActive;
    notifyListeners();
  }

  void enableDailyNotification(bool value) {
    preferencesHelper.setDailyNotification(value);
    _getDailyNotificationPreferences();
  }
}
