import 'dart:async';
import 'dart:convert';

import 'package:flutter/widgets.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import 'package:wacomi/constants.dart';
import 'package:wacomi/helpers/client.dart';
import 'package:wacomi/exceptions/http_exception.dart';
import 'package:wacomi/models/user.dart';

class Auth with ChangeNotifier {
  String _token;
  DateTime _expiryDate;
  User _currentUser;
  Timer _authTimer;

  bool get isAuth {
    return token != null;
  }

  String get token {
    return _token;
    // if (_expiryDate != null &&
    //     _expiryDate.isAfter(DateTime.now()) &&
    //     _token != null) {
    //   return _token;
    // }
    // return null;
  }

  User get currentUser {
    return _currentUser;
  }

  // Future<void> _authenticate(
  //   String email, String password,
  // )

  Future<void> signup(
    String email,
    String password,
    String password_confirmation,
    String name,
  ) async {
    final url = kApiUrl + 'auth/register';
    try {
      final response = await Client.httpPost(
        url,
        {
          'email': email,
          'password': password,
          'name': name,
          'password_confirmation': password_confirmation,
        },
      );

      final responseData = json.decode(response.body) as Map<String, dynamic>;

      if (responseData['error'] != null) {
        throw HttpException(responseData['error']['message']);
      }
    } catch (error) {
      print(error);
      throw error;
    }
  }

  Future<void> login(String email, String password) async {
    final url = kApiUrl + 'auth/login';

    try {
      final response = await Client.httpPost(
        url,
        {
          'email': email,
          'password': password,
        },
      );

      // final response = await http.post(
      //   url,
      //   headers: {
      //     "Content-Type": "application/x-www-form-urlencoded",
      //     "Accept": "application/json",
      //   },
      //   body: {
      //     'email': email,
      //     'password': password,
      //   },
      // );

      final responseData = json.decode(response.body) as Map<String, dynamic>;
      print(responseData);

      // if (responseData['error'] != null) {
      //   throw HttpException(responseData['error']['message']);
      // }

      print(responseData['user']['id']);

      _token = responseData['token'];
      _currentUser = User.fromJson(responseData['user']);

      notifyListeners();

      final prefs = await SharedPreferences.getInstance();
      final userData = json.encode({'token': _token, 'user': _currentUser});
      prefs.setString('userData', userData);
    } catch (error) {
      throw error;
    }
  }

  Future<bool> tryAutoLogin() async {
    final prefs = await SharedPreferences.getInstance();
    if (!prefs.containsKey('userData')) {
      return false;
    }

    final extractedUserData =
        json.decode(prefs.getString('userData')) as Map<String, Object>;

    _token = extractedUserData['token'];
    _currentUser = User.fromJson(extractedUserData['user']);

    //TODO: should logout somehow here if the token expire

    notifyListeners();

    return true;
  }

  Future<void> logout() async {
    final url = kApiUrl + 'auth/logout';
    try {
      print(url);
      final response = await http.get(
        url,
      );
      print(response);

      _token = null;
      _currentUser = null;

      notifyListeners();

      final prefs = await SharedPreferences.getInstance();
      prefs.clear();
    } catch (error) {
      print(error);
      throw error;
    }

    return;
  }
}
