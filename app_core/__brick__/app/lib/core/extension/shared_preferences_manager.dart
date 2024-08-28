import '../utils/constants.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferencesManager {
  final SharedPreferences _sharedPreferences;
  SharedPreferencesManager(this._sharedPreferences);

  String? getCurrentTheme() {
    String? themeName =
        _sharedPreferences.getString(SharedPreferencesKeys.CurrentTheme);
    return themeName;
  }

  void changeCurrentTheme(String theme) {
    _sharedPreferences.setString(SharedPreferencesKeys.CurrentTheme, theme);
  }

  String? getCurrentLanguage() {
    String? currentLanguage =
        _sharedPreferences.getString(SharedPreferencesKeys.CURRENT_LANGUAGE);
    return currentLanguage;
  }

  void setCurrentLanguage(String language) {
    _sharedPreferences.setString(
        SharedPreferencesKeys.CURRENT_LANGUAGE, language);
  }

  bool isSelectedLanguageForFirstTime() {
    bool? currentLanguage = _sharedPreferences
        .getBool(SharedPreferencesKeys.IS_SELECTED_LANGUAGE_FOR_FIRST_TIME);
    return currentLanguage ?? false;
  }

  void setSelectedLanguageForFirstTime(bool selected) {
    _sharedPreferences.setBool(
        SharedPreferencesKeys.IS_SELECTED_LANGUAGE_FOR_FIRST_TIME, selected);
  }

  void setToken(String token) {
    _sharedPreferences.setString(SharedPreferencesKeys.CURRENT_TOKEN, token);
  }

  void clearToken() {
    _sharedPreferences.remove(SharedPreferencesKeys.CURRENT_TOKEN);
  }

  String? getToken() {
    String? currentToken =
        _sharedPreferences.getString(SharedPreferencesKeys.CURRENT_TOKEN);
    return currentToken;
  }

  void setRefreshToken(String token) {
    _sharedPreferences.setString(SharedPreferencesKeys.REFRESH_TOKEN, token);
  }

  void clearRefreshToken() {
    _sharedPreferences.remove(SharedPreferencesKeys.REFRESH_TOKEN);
  }

  String? getRefreshToken() {
    String? currentToken =
        _sharedPreferences.getString(SharedPreferencesKeys.REFRESH_TOKEN);
    return currentToken;
  }
}
