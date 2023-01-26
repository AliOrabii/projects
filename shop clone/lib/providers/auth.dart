import 'dart:async';
import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

import 'package:flutter/material.dart';

class Auth with ChangeNotifier {
  String? _UserName;
  String? _userId;
  String? _token;
  DateTime? _ExpiresIn = DateTime.now();
  Timer? _authTimer;

  bool get isAuth {
    return _token != null;
  }

  String? get token {
    if (_ExpiresIn != null &&
        _ExpiresIn!.isAfter(DateTime.now()) &&
        _token != null) {
      return _token;
    }
    return null.toString();
  }

  String? get userId {
    return _userId;
  }

  Future<void> SignUp(String? username, String? password) async {
    print('Signed up');
    const Url =
        'https://identitytoolkit.googleapis.com/v1/accounts:signUp?key=AIzaSyBR0I2_rehVoKRuSuhWr23iMUTKN_6lgUk';
    try {
      final response = await http.post(
        Uri.parse(Url),
        body: json.encode(
          {
            'email': username,
            'password': password,
            'returnSecureToken': true,
          },
        ),
      );
      print(json.decode(response.body));
      final ResponseData = json.decode(response.body);
      if (ResponseData['error'] != null) {
        throw Exception(ResponseData['error']['message']);
      }
      _token = ResponseData['idToken'];
      _userId = ResponseData['localId'];
      _UserName = ResponseData['email'];
      _ExpiresIn = DateTime.now().add(
        Duration(
          seconds: int.parse(
            ResponseData['expiresIn'],
          ),
        ),
      );
      final prefs = await SharedPreferences.getInstance();
      final userbox = jsonEncode(
        {
          'username': _UserName,
          'token': _token,
          'ExpiresIn': _ExpiresIn!.toIso8601String(),
          'userId': _userId,
        },
      );
      notifyListeners();
      _autologout();
      prefs.setString('userbox', userbox);
    } on Exception catch (e) {
      print(e);
    }
  }

  Future<void> Login(String? username, String? password) async {
    print('Logged in');
    const Url =
        'https://identitytoolkit.googleapis.com/v1/accounts:signInWithPassword?key=AIzaSyBR0I2_rehVoKRuSuhWr23iMUTKN_6lgUk';
    try {
      final response = await http.post(
        Uri.parse(Url),
        body: json.encode(
          {
            'email': username,
            'password': password,
            'returnSecureToken': true,
          },
        ),
      );
      print(json.decode(response.body));
      final ResponseData = json.decode(response.body);
      if (ResponseData['error'] != null) {
        throw Exception(ResponseData['error']['message']);
      }
      _token = ResponseData['idToken'];
      _userId = ResponseData['localId'];
      _UserName = ResponseData['email'];
      _ExpiresIn = DateTime.now().add(
        Duration(
          seconds: int.parse(
            ResponseData['expiresIn'],
          ),
        ),
      );
      notifyListeners();
      _autologout();
      final prefs = await SharedPreferences.getInstance();
      final userbox = jsonEncode(
        {
          'username': _UserName,
          'token': _token,
          'ExpiresIn': _ExpiresIn!.toIso8601String(),
          'userId': _userId,
        },
      );
      prefs.setString('userbox', userbox);
    } on Exception catch (e) {
      print(e);
    }
  }

  Future<void> Logout() async {
    print('Logouttttttt');
    _token = null;
    _ExpiresIn = null;
    _userId = null;
    if (_authTimer != null) {
      _authTimer!.cancel();
      _authTimer = null;
    }
    notifyListeners();
    print(_token);
    print(_ExpiresIn);
    print(_userId);
    print(isAuth);
    final prefs = await SharedPreferences.getInstance();
    prefs.clear();
  }

  void _autologout() {
    if (_authTimer != null) {
      _authTimer!.cancel();
    }
    final timeToExpiry = _ExpiresIn!.difference(DateTime.now()).inSeconds;
    _authTimer = Timer(Duration(seconds: timeToExpiry), Logout);
  }

  Future<bool> tryAutologin() async {
    var box = await SharedPreferences.getInstance();
    if (!box.containsKey('userbox')) return false;
    final extractedData =
        json.decode(box.getString('userbox')!) as Map<String, dynamic>;
    final expirydate = DateTime.parse(extractedData['ExpiresIn']!);
    if (expirydate.isBefore(DateTime.now())) return false;
    _token = extractedData['token']!;
    _userId = extractedData['userId']!;
    _ExpiresIn = expirydate;
    notifyListeners();
    _autologout();
    return true;
  }
}
