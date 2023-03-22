import 'package:shared_preferences/shared_preferences.dart';

class SharedPref {
  static const String prefTokens = "@tokens";
  static const String prefAuth = "@auth";
  static const String currentPage = "";

//! Clear shared preferences
  static Future<void> clear() async {
    final SharedPreferences pref = await SharedPreferences.getInstance();
    pref.clear();
  }

//! bool type shared preferences
  static Future<void> setBool({required String key, required bool data}) async {
    final SharedPreferences pref = await SharedPreferences.getInstance();
    pref.setBool(key, data);
  }

  static Future<bool> getBool({required String key}) async {
    final SharedPreferences pref = await SharedPreferences.getInstance();
    bool res = pref.getBool(key) ?? false;
    return res;
  }

//! String type shared preferences
  static Future<void> setString({required String key, required String data}) async {
    final SharedPreferences pref = await SharedPreferences.getInstance();
    pref.setString(key, data);
  }

  static Future<String> getString({required String key}) async {
    final SharedPreferences pref = await SharedPreferences.getInstance();
    String res = pref.getString(key) ?? '';
    return res;
  }

//! String type shared preferences
  static Future<void> setInt({required String key, required int data}) async {
    final SharedPreferences pref = await SharedPreferences.getInstance();
    pref.setInt(key, data);
  }

  static Future<int> getInt({required String key}) async {
    final SharedPreferences pref = await SharedPreferences.getInstance();
    int res = pref.getInt(key) ?? 0;
    return res;
  }
}
