import 'package:flutter/widgets.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

class Auth with ChangeNotifier {
  Map<String, dynamic> _userLogin;
  Future<void> signIn(String username, String password) async {
    final url =
        'https://www.emraancheema.com/app/wp-json/login-user/v1/data/$username/$password';
    try {
      final response = await http.get(
        Uri.parse(url),
      );

      final extractedData = json.decode(response.body) as Map<String, Object>;
      _userLogin = extractedData['userData'];
      notifyListeners();
      final prefs = await SharedPreferences.getInstance();
      final userData = json.encode(_userLogin);

      prefs.setString('user', userData);
    } catch (error) {
      print(error);
    }
  }

  Future<void> signUp(String username, String email, String password) async {
    final url =
        'https://www.emraancheema.com/app/wp-json/login-user/v1/data/$username/$password/$email';
    final response = await http.post(
      Uri.parse(url),
    );
    // print(json.decode(response.body));
  }

  Future<void> logout() async {
    final prefs = await SharedPreferences.getInstance();
    prefs.clear();
  }

  Future<bool> tryAutoLogin() async {
    final prefs = await SharedPreferences.getInstance();
    if (!prefs.containsKey('user')) {
      return false;
    }
    final extractedUserData =
        json.decode(prefs.getString('user')) as Map<String, Object>;
    _userLogin = extractedUserData['data'];
    notifyListeners();
    return true;
  }

  Map<String, Object> get user {
    if (_userLogin != null) {
      return _userLogin;
    }
    return null;
  }

  bool get isLogin {
    return _userLogin != null;
  }
}
