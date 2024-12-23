import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:student_panel/services/shared_preference_service.dart';

class LanguageController extends GetxController {
  bool isEnglish = false;
  final english = const Locale('en', 'US');
  final bengali = const Locale('bn', 'BD');
  void changeLanguage() async {
    isEnglish = !isEnglish;
    Get.updateLocale(isEnglish ? english : bengali);
    SharedPreferencesService().saveLanguage(isEnglish ? 'english' : 'bengali');
    update();
  }

  Future<void> _loadLanguageFromPrefs() async {
    final languageString = SharedPreferencesService().getLanguage();
    final locale = languageString == 'english' ? english : bengali;
    Get.updateLocale(locale); // Update GetX locale based on saved language
    isEnglish = languageString == 'english';
    update();
  }

  @override
  void onInit() {
    super.onInit();
    _loadLanguageFromPrefs();
  }
}
