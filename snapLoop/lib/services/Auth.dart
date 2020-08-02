import 'dart:async';
import 'dart:convert';
import 'package:SnapLoop/Model/HttpException.dart';
import 'package:SnapLoop/Model/user.dart';
import 'package:SnapLoop/Model/responseParsingHelper.dart';
import 'package:SnapLoop/app/locator.dart';
import 'package:SnapLoop/services/ConnectionService.dart';
import 'package:SnapLoop/services/StorageService.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;
import 'package:injectable/injectable.dart';
import 'package:observable_ish/value/value.dart';
import 'package:stacked/stacked.dart';

import '../constants.dart';

/// author: @sanchitmonga22
@lazySingleton
class Auth with ReactiveServiceMixin {
  Auth() {
    listenToReactiveValues([_isAuth, user, _token]);
  }

  final _storageService = locator<StorageService>();
  //final _userDataService = locator<UserDataService>();
  final _connectionSerice = locator<ConnectionStatusService>();

  final storage = FlutterSecureStorage();
  String _token;
  RxValue<User> user = RxValue();
  String _userId;
  RxValue<bool> _isAuth = RxValue<bool>(initial: false);

  bool get isAuth => _isAuth.value;

  String get token => _token;

  String get userId => _userId;

  Future<void> attemptLogIn(String email, String password) async {
    http.Response res = await http.post('$SERVER_IP/users/login',
        headers: {"Content-Type": "application/json"},
        body: jsonEncode({"email": email, "password": password}));
    var response = json.decode(res.body);
    if (res.statusCode == 200) {
      final jwt = response['token'];
      if (jwt != null) {
        _token = jwt;
        _userId = response['userId'] as String;
        _isAuth.value = true;
        response['email'] = email;
        user.value = ResponseParsingHelper.parseUser(response, _userId);
        await _storageService.addNewKeyValue("userData", response);
        await storage.write(key: "jwt", value: jwt);
        await storage.write(key: "userId", value: response['userId']);
      }
    }
  }

  Future<void> attemptSignUp(String username, String password,
      String phoneNumber, String email) async {
    try {
      http.Response res = await http.post('$SERVER_IP/users/signup',
          headers: {"Content-Type": "application/json"},
          body: jsonEncode({
            "username": username,
            "password": password,
            "email": email,
            //"phoneNumber": phoneNumber
          }));
      final response = json.decode(res.body);
      if (res.statusCode == 201) {
        _token = response['token'];
        _userId = response['userId'];
        user.value = new User(
            status: "I am new to SnapLoop!",
            numberOfLoopsRemaining: 5,
            contacts: [],
            requestsSent: [],
            requestsReceived: [],
            userID: _userId,
            username: username,
            displayName: username,
            email: email,
            score: 0,
            friendsIds: [],
            loopsData: []);
        _isAuth.value = true;
        await storage.write(key: "jwt", value: response['token']);
        await storage.write(key: "userId", value: response['userId']);
        //await _userDataService.updateUserData();
      } else {
        _isAuth.value = false;
      }
    } catch (err) {
      throw new HttpException('could not sign up:' + err.toString());
    }
  }

  Future<void> logOut() async {
    try {
      http.Response res = await http.post(
        "$SERVER_IP/users/logout",
        headers: {
          "Content-Type": "application/json",
          "Authorization": "Bearer $token"
        },
      );
      if (res.statusCode == 200) {
        _token = null;
        _isAuth.value = false;
        await storage.delete(key: "jwt");
        await _storageService.clearAll();
      }
    } catch (err) {
      throw new HttpException(
          "Could not logout, an error occured: " + err.toString());
    }
  }

  Future<bool> tryAutoLogin() async {
    //TODO: add a validation for the token whether or not if it has expired!
    final token1 = await storage.read(key: "jwt");
    final userId1 = await storage.read(key: "userId");

    if (token1 == null) {
      _isAuth.value = false;
      return false;
    }
    _token = token1;
    _userId = userId1;

    if (!_connectionSerice.connected) {
      dynamic userData = await _storageService.getValueFromKey("userData");
      if (userData != null) {
        user.value = ResponseParsingHelper.parseUser(userData, userId);
        _isAuth.value = true;
        return true;
      }
      _isAuth.value = false;
      return false;
    }

    // getting the userData from the server using the _token, add the API to the server
    http.Response res = await http.get(
      "$SERVER_IP/users/data",
      headers: {
        "Content-Type": "application/json",
        "Authorization": "Bearer " + token,
      },
    );
    final response = json.decode(res.body);
    if (res.statusCode == 200) {
      user.value = ResponseParsingHelper.parseUser(response, userId);
      _isAuth.value = true;
      await _storageService.addNewKeyValue("userData", response);
      return true;
    }
    _isAuth.value = false;
    return false;
  }
}
