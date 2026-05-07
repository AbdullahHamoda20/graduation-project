import 'package:shared_preferences/shared_preferences.dart';

class PrefHelper {
  static const String _accessTokenKey = 'access_token';
  static const String _refreshTokenKey = 'refresh_token';

  // ================= ACCESS TOKEN =================

  static Future<void> saveToken(String token) async {
    final pref = await SharedPreferences.getInstance();
    await pref.setString(_accessTokenKey, token);
  }

  static Future<String?> getToken() async {
    final pref = await SharedPreferences.getInstance();
    return pref.getString(_accessTokenKey);
  }

  static Future<void> clearToken() async {
    final pref = await SharedPreferences.getInstance();
    await pref.remove(_accessTokenKey);
  }

  // ================= REFRESH TOKEN =================

  static Future<void> saveRefreshToken(String token) async {
    final pref = await SharedPreferences.getInstance();
    await pref.setString(_refreshTokenKey, token);
  }

  static Future<String?> getRefreshToken() async {
    final pref = await SharedPreferences.getInstance();
    return pref.getString(_refreshTokenKey);
  }

  static Future<void> clearRefreshToken() async {
    final pref = await SharedPreferences.getInstance();
    await pref.remove(_refreshTokenKey);
  }

  // ================= CLEAR ALL =================

  static Future<void> clearAll() async {
    final pref = await SharedPreferences.getInstance();
    await pref.clear();
  }
}