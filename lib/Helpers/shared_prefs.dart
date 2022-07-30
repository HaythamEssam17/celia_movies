import 'package:shared_preferences/shared_preferences.dart';

class DefaultSharedPrefs {
  /// Keys
  static String peoplesKey = 'peoples';

  /// Setters
  static Future<bool> setPeoples(String value) async {
    final prefs = await SharedPreferences.getInstance();
    var result = await prefs.setString(peoplesKey, value);
    return result;
  }

  static Future<String> getPeoples() async {
    final prefs = await SharedPreferences.getInstance();
    final String result = prefs.getString(peoplesKey) ?? '';

    return result;
  }
}
