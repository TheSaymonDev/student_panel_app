import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:student_panel/services/shared_preference_service.dart';

class ThemeController extends GetxController {
  bool isDark = false;
  void changeTheme() async {
    isDark = !isDark;
    Get.changeThemeMode(isDark ? ThemeMode.dark : ThemeMode.light);
    SharedPreferencesService().saveTheme(isDark ? 'dark' : 'light');
    update();
  }

  Future<void> _loadThemeFromPrefs() async {
    final themeModeString = SharedPreferencesService().getTheme();
    final theme = themeModeString == 'dark' ? ThemeMode.dark : ThemeMode.light;
    Get.changeThemeMode(theme);
    isDark = themeModeString == 'dark';
    update();
  }

  @override
  void onInit() {
    super.onInit();
    _loadThemeFromPrefs();
  }
}
