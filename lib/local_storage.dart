import 'package:shared_preferences/shared_preferences.dart';

class LocalStorage {
  Future<void> saveHtml(String key, String value) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(key, value);
  }

  Future<String?> getHtml(String key) async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(key);
  }
}