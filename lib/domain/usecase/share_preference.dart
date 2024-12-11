
import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferencesService {

  // Save data methods
  static Future<bool> saveString(String key, String? value) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    return pref.setString(key, value!);
  }

  Future<bool> saveInt(String key, int value) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    return pref.setInt(key, value);
  }

  Future<bool> saveBool(String key, bool value) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    return pref.setBool(key, value);
  }

  // Retrieve data methods
  static Future<String?> getString(String key) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    return pref.getString(key);
  }

  static Future<int?> getInt(String key) async  {
    SharedPreferences pref = await SharedPreferences.getInstance();
    return pref.getInt(key);
  }

   static Future<bool?> getBool(String key) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    return pref.getBool(key);
  }

  // Remove a key
  static Future<bool> remove(String key) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    return pref.remove(key);
  }

  // Clear all preferences
  static Future<bool> clear() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    return pref.clear();
  }
}
