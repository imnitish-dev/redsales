import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:twocliq/helper/constants.dart';

import '../screens/auth_screens/sign_in_screen.dart';


class UserSharedPref {
  static const String _tokenKey = 'loginToken';
  static const String _userDetailsKey = 'userDetails';

  /// Save login token and user details
  static Future<void> saveUserSession(String token, UserDetails user) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_tokenKey, token);
    await prefs.setString(_userDetailsKey, jsonEncode(user.toJson()));
  }

  /// Get login token
  static Future<String?> getToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_tokenKey);
  }

  /// Get user details (returns null if not stored)
  static Future<UserDetails?> getUserDetails() async {
    final prefs = await SharedPreferences.getInstance();
    final jsonString = prefs.getString(_userDetailsKey);
    if (jsonString != null) {
      final Map<String, dynamic> data = jsonDecode(jsonString);
      return UserDetails.fromJson(data);
    }
    return null;
  }

  /// Check if a user is logged in
  static Future<bool> isLoggedIn() async {
    final token = await getToken();
    return token != null && token.isNotEmpty;
  }

  /// Clear user session (for logout)
  static Future<bool> clearSession() async {
    try{
      final prefs = await SharedPreferences.getInstance();
      await prefs.remove(_tokenKey);
      await prefs.remove(_userDetailsKey);
      return true;
    }catch(eww){
      logError(eww.toString());
      return false;
    }
  }
}
