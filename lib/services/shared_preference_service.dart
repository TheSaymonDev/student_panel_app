import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferencesService{
  static final SharedPreferencesService _instance = SharedPreferencesService._internal();
  factory SharedPreferencesService() => _instance;
  SharedPreferencesService._internal();
  late SharedPreferences _prefs;

  Future<void> init() async {
    _prefs = await SharedPreferences.getInstance();
  }

  void saveUserId(String userId) {
    _prefs.setString('userId', userId);
  }

  String getUserId() {
    return _prefs.getString('userId') ?? '';
  }

  void clearUserId() {
    _prefs.remove('userId');
  }

  void saveTheme(String theme) {
    _prefs.setString('themeKey', theme);
  }
  String getTheme() {
    return _prefs.getString('themeKey') ?? '';
  }

  void saveLanguage(String language) {
    _prefs.setString('languageKey', language);
  }
  String getLanguage() {
    return _prefs.getString('languageKey') ?? '';
  }
}