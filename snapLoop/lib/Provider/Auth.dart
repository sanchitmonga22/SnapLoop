import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:SnapLoop/Model/HttpException.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;

class Auth with ChangeNotifier {
  String _url = "";
  static const SERVER_IP = "";
  final storage = FlutterSecureStorage();

  bool get isAuth {
    return token != null;
  }

  Future<void> attemptLogIn(String username, String password) async {
    var res = await http.post("$SERVER_IP/login",
        body: {"username": username, "password": password});
    if (res.statusCode == 200) {
      var jwt = res.body;
      if (jwt != null) {
        storage.write(key: "jwt", value: jwt);
      }
    }
  }

  Future<String> get token async {
    var jwt = await storage.read(key: "jwt");
    return jwt;
  }

  Future<void> attemptSignUp(String username, String password,
      String phoneNumber, String email) async {
    var res = await http.post('$SERVER_IP/signup', body: {
      "username": username,
      "password": password,
      "email": email,
      "phoneNumber": phoneNumber
    });
    if (res.statusCode == 201) {
      print("The user was created successfully");
    }
  }

  Future<String> tryAutoLogin() async {
    String response = await http
        .read('$SERVER_IP/data', headers: {"Authorization": await token});
    print(response);
    return response;
  }
}
