import 'dart:async';
import 'dart:convert';
import 'dart:ui';
import 'package:SnapLoop/Model/loop.dart';
import 'package:SnapLoop/Model/user.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;

import '../constants.dart';

/// author: @sanchitmonga22

class Auth with ChangeNotifier {
  //String _url = "";
  final storage = FlutterSecureStorage();
  String _token;
  var user;
  String _userId;

  bool get isAuth {
    return token != null;
  }

  Future<void> attemptLogIn(String email, String password) async {
    http.Response res = await http.post('$SERVER_IP/users/login',
        headers: {"Content-Type": "application/json"},
        body: jsonEncode({"email": email, "password": password}));
    final response = json.decode(res.body);
    if (res.statusCode == 200) {
      final jwt = response['token'];
      if (jwt != null) {
        _token = jwt;
        _userId = response['userId'] as String;
        user = parseUser(response, email);
        notifyListeners();
        await storage.write(key: "jwt", value: jwt);
        await storage.write(key: "userId", value: response['userId']);
      }
    }
  }

  User parseUser(dynamic response, String email) {
    return User(
        contacts: (response["contacts"] as List).cast<String>().toList(),
        userID: userId,
        username: response['username'] as String ?? "",
        displayName: response['displayName'] == ""
            ? response['username']
            : response['displayName'],
        email: email == "" ? response['email'] : email,
        loopsData: getLoopsFromResponse(response['loopsData']),
        score: response['score'] as int,
        friendsIds: (response['friendsIds'] as List).cast<String>().toList(),
        requestsSent: response['requests']['sent'].cast<String>().toList(),
        requestsReceived:
            response['requests']['received'].cast<String>().toList());
  }

  List<Loop> getLoopsFromResponse(dynamic response) {
    List<Loop> newLoops;
    response = response as List<dynamic>;
    for (int i = 0; i < response.length; i++) {
      newLoops.add(parseLoop(response[i]));
    }
    return newLoops;
  }

  Loop parseLoop(dynamic loop) {
    List<dynamic> loopUsers = (loop['users'] as List).cast<dynamic>().toList();
    return Loop(
        name: loop['name'],
        type: getLoopsType(loop['type']),
        numberOfMembers: loopUsers.length,
        avatars: getImagesMap(loopUsers),
        chatID: loop['chat'] as String,
        creatorId: loop['creatorId'] as String,
        id: loop._id,
        userIDs: loop['users']);
  }

  Map<String, Image> getImagesMap(dynamic users) {
    Map<String, Image> images = {};
    users = users;
    for (int i = 0; i < users.length; i++) {
      images[users[i]['user']] =
          // TODO:add an image returned when a image url is not correct
          Image(image: NetworkImage(users[i]['avatarLink']));
    }
    return images;
  }

  LoopType getLoopsType(String type) {
    if (type == "NEW_LOOP") {
      return LoopType.NEW_LOOP;
    } else if (type == "NEW_NOTIFICATION") {
      return LoopType.NEW_NOTIFICATION;
    } else if (type == "EXISTING_LOOP") {
      return LoopType.EXISTING_LOOP;
    } else if (type == "INACTIVE_LOOP_SUCCESSFUL") {
      return LoopType.INACTIVE_LOOP_SUCCESSFUL;
    } else if (type == "INACTIVE_LOOP_FAILED") {
      return LoopType.INACTIVE_LOOP_FAILED;
    } else {
      return null;
    }
  }

  Future<void> logOut() async {
    http.Response res = await http.post(
      "$SERVER_IP/users/logout",
      headers: {
        "Content-Type": "application/json",
        "Authorization": "Bearer $token"
      },
    );
    if (res.statusCode == 200) {
      _token = null;
      await storage.delete(key: "jwt");
      notifyListeners();
    }
  }

  String get token {
    if (_token == null) return null;
    return _token;
  }

  String get userId {
    return _userId;
  }

  Future<void> attemptSignUp(String username, String password,
      String phoneNumber, String email) async {
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
      final jwt = response['token'];
      await storage.write(key: "jwt", value: "Bearer $token");
      _token = jwt;
      _userId = response['userId'];
      user = new User(
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
      notifyListeners();
    }
  }

  Future<bool> tryAutoLogin() async {
    //TODO: add a validation for the token whether or not if it has expired!
    final token1 = await storage.read(key: "jwt");
    _userId = await storage.read(key: "userId");

    if (token1 == null) {
      return false;
    }
    _token = token1;
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
      user = parseUser(response, "");
      notifyListeners();
      return true;
    }
    return false;
  }
}
