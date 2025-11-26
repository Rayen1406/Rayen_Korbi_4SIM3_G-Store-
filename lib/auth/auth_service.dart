import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

class AuthService {
  static const String keyLoggedIn = "logged_in";

  // SAVE LOGIN STATE
  static Future<void> login() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(keyLoggedIn, true);
  }

  // LOGOUT
  static Future<void> logout() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(keyLoggedIn, false);
  }

  // CHECK LOGIN STATE
  static Future<bool> isLoggedIn() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool(keyLoggedIn) ?? false;
  }

  static const String usersKey = "registered_users";

// Save account
  static Future<void> registerUser(String email, String password) async {
    final prefs = await SharedPreferences.getInstance();

    Map<String, String> users =
    prefs.getString(usersKey) == null
        ? {}
        : Map<String, String>.from(
      jsonDecode(prefs.getString(usersKey)!),
    );

    users[email] = password;

    await prefs.setString(usersKey, jsonEncode(users));
  }

// Validate login
  static Future<bool> validateUser(String email, String password) async {
    final prefs = await SharedPreferences.getInstance();

    if (!prefs.containsKey(usersKey)) return false;

    final users =
    Map<String, String>.from(jsonDecode(prefs.getString(usersKey)!));

    return users[email] == password;
  }

}
