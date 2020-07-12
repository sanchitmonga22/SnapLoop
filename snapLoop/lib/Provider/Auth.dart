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
  User user;
  String _userId;

  bool get isAuth {
    return token != null;
  }

  Future<void> attemptLogIn(String email, String password) async {
    http.Response res = await http.post('$SERVER_IP/users/login',
        headers: {"Content-Type": "application/json"},
        body: jsonEncode({"email": email, "password": password}));
    final response = json.decode(res.body);
    print(response);
    if (res.statusCode == 200) {
      final jwt = response['token'];
      if (jwt != null) {
        storage.write(key: "jwt", value: jwt);
        _token = jwt;
        _userId = response['userId'];
        user = new User(
            contacts: response['contacts'],
            userID: _userId,
            username: response['username'],
            displayName: response['displayName'] == ""
                ? response['username']
                : response['displayName'],
            email: email,
            loopsData: getLoopsFromResponse(response['loopsData']),
            score: response['score'],
            friendsIds: response['friendsIds'],
            requests: response['requests']);
        notifyListeners();
      }
    }
  }

  List<Loop> getLoopsFromResponse(dynamic response) {
    List<Loop> newLoops;
    for (dynamic loop in response) {
      newLoops.add(new Loop(
          name: loop['name'],
          type: getLoopsType(loop['type']),
          numberOfMembers: loop['users'].length,
          avatars: getImagesMap(loop['users']),
          chatID: loop['chat'],
          creatorId: loop['creatorId'],
          id: loop._id,
          userIDs: getUserIds(loop['users'])));
    }
    return newLoops;
  }

  List<String> getUserIds(dynamic users) {
    List<String> userIds = [];
    for (String user in users) {
      userIds.add(user);
    }
    return userIds;
  }

  Map<String, Image> getImagesMap(dynamic users) {
    Map<String, Image> images = {};
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
    http.Response res = await http.post("$SERVER_IP/users/logout",
        headers: {"Content-Type": "application/json", "Authorization": token});
    if (res.statusCode == 200) {
      _token = null;
      await storage.deleteAll();
      notifyListeners();
    }
  }

  String get token {
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
      await storage.write(key: "jwt", value: token);
      _token = jwt;
      _userId = response['userId'];
      user = new User(
          contacts: [],
          requests: [],
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
    //final token1 = await storage.read(key: "jwt");
    //String response =
    //  await http.read('$SERVER_IP/data', headers: {"Authorization": token1});
    //notifyListeners();
    //print(response);
    return true;
    // return response;
  }
}
