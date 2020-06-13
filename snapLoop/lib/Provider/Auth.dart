import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:SnapLoop/Model/HttpException.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class Auth with ChangeNotifier {
  String _token;
  DateTime _expiryDate;
  String _userId;
  Timer authTimer;
  String _key = "";
  String _url = "";
  final SERVER_IP = "";
  final storage = FlutterSecureStorage();

  bool get isAuth {
    return token != null;
  }

  String get token {
    if (_expiryDate != null &&
        _expiryDate.isAfter(DateTime.now()) &&
        _token != null) {
      return _token;
    }
    return null;
  }

  void logOut() async {
    _token = null;
    _userId = null;
    _expiryDate = null;
    if (authTimer != null) {
      authTimer.cancel();
      authTimer = null;
    }
    notifyListeners();
    final prefs = await SharedPreferences.getInstance();
    prefs.clear();
  }

  void autoLogOut() {
    if (authTimer != null) {
      authTimer.cancel();
    }
    var timeToExpiry = _expiryDate.difference(DateTime.now()).inSeconds;
    authTimer = Timer(Duration(seconds: timeToExpiry), logOut);
  }

  String get userId {
    return _userId;
  }

  Future<String> attemptLogIn(String username, String password) async {
    var res = await http.post("$SERVER_IP/login",
        body: {"username": username, "password": password});
    if (res.statusCode == 200) {
      var jwt = res.body;
      if (jwt != null) {
        storage.write(key: "jwt", value: jwt);
      }
      return res.body;
    }
    return null;
  }

  Future<int> attemptSignUp(String username, String password,
      String phoneNumber, String email) async {
    var res = await http.post('$SERVER_IP/signup', body: {
      "username": username,
      "password": password,
      "email": email,
      "phoneNumber": phoneNumber
    });
    return res.statusCode;
  }

  // Future<void> authenticate(
  //     String email, String password, String urlSegment) async {
  //   final url = "$_url/accounts:$urlSegment?key=$_key";
  //   try {
  //     final response = await http.post(url,
  //         body: json.encode({
  //           'email': email,
  //           'password': password,
  //           'returnSecureToken': true
  //         }));
  //     final responseData = json.decode(response.body);
  //     if (responseData['error'] != null) {
  //       throw HttpException(responseData['error']['message']);
  //     }
  //     _token = responseData['idToken'];
  //     _userId = responseData['localId'];
  //     _expiryDate = DateTime.now()
  //         .add(Duration(seconds: int.parse(responseData['expiresIn'])));
  //     autoLogOut();
  //     notifyListeners();
  //     final prefs = await SharedPreferences.getInstance();
  //     final userData = json.encode({
  //       'token': _token,
  //       'userId': _userId,
  //       'expiryDate': _expiryDate.toIso8601String()
  //     });

  //     prefs.setString('userData', userData);
  //   } catch (error) {
  //     throw error;
  //   }
  // }

  // Future<void> signUp(String email, String password) async {
  //   return authenticate(email, password, "signUp");
  // }

  // Future<void> login(String email, String password) async {
  //   return authenticate(email, password, "signInWithPassword");
  // }

  Future<bool> tryAutoLogin() async {
    final prefs = await SharedPreferences.getInstance();
    if (!prefs.containsKey('userData')) {
      return false;
    }
    final extractedUserData =
        json.decode(prefs.getString('userData')) as Map<String, Object>;

    final expiryDate = DateTime.parse(extractedUserData['expiryDate']);

    if (expiryDate.isBefore(DateTime.now())) {
      return false;
    }
    _token = extractedUserData['token'];
    _userId = extractedUserData['userId'];
    _expiryDate = expiryDate;
    print("Tried AutoLoggin in");
    notifyListeners();
    return true;
  }
}
