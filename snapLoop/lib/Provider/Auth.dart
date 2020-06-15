import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:SnapLoop/Model/HttpException.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;

class Auth with ChangeNotifier {
  //String _url = "";
  static const SERVER_IP = "http://192.168.0.37:3000/users";
  final storage = FlutterSecureStorage();
  String _token;

  bool get isAuth {
    print("ISAUTH??");
    print(token != null);
    print(token);
    return token != null;
  }

  Future<void> attemptLogIn(String username, String password) async {
    http.Response res = await http.post("$SERVER_IP/login",
        headers: {"Content-Type": "application/json"},
        body: json.encode({"username": username, "password": password}));
    final response = json.decode(res.body);
    if (res.statusCode == 200) {
      final jwt = response['token'];
      if (jwt != null) {
        storage.write(key: "jwt", value: jwt);
        notifyListeners();
      }
    }
  }

  Future<void> logOut() async {
    http.Response res = await http.post("$SERVER_IP/logout",
        headers: {"Content-Type": "application/json", "Authorization": token});
    if (res.statusCode == 200) {
      print(res.statusCode);
      _token = null;
      await storage.deleteAll();
      print("Logout Successfull");
      notifyListeners();
    }
  }

  String get token {
    return _token;
  }

  Future<void> attemptSignUp(String username, String password,
      String phoneNumber, String email) async {
    http.Response res = await http.post('$SERVER_IP/signup',
        headers: {"Content-Type": "application/json"},
        body: jsonEncode({
          "username": username,
          "password": password,
          "email": email,
          "phoneNumber": phoneNumber
        }));
    final response = json.decode(res.body);
    print(response);
    if (res.statusCode == 201) {
      final token = response['token'];
      print(token);
      await storage.write(key: "jwt", value: token);
      _token = token;
      notifyListeners();
    }
  }

  Future<bool> tryAutoLogin() async {
    //final token1 = await storage.read(key: "jwt");
    //String response =
    //  await http.read('$SERVER_IP/data', headers: {"Authorization": token1});
    //notifyListeners();
    //print(response);
    return true;
    // return response;
  }
}
