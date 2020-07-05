import 'dart:ui';

import 'package:flutter/foundation.dart';

import 'loop.dart';

/// author: @sanchitmonga22

class User {
  final String userID;
  final String username;
  String displayName; // can be set to the same as username
  final String email;
  final int score;
  List<String> friendsIds;
  // all the loops that the user is involved in
  List<String> loopIDs;
  final String phone;
  final Image avatar;

  User(
      {@required this.userID,
      this.avatar,
      @required this.username,
      @required this.displayName,
      @required this.email,
      @required this.score,
      @required this.friendsIds,
      this.phone,
      @required this.loopIDs});
}

class FriendsData {
  String displayName; // how you want to save your friends name,
  //by default it will be same as that in the contacts or their username
  final String username;
  final String email;
  final String userID;
  final int score;
  final String status;
  final List<String> commonLoops;
  final Image avatar;

  FriendsData(
      {@required this.username,
      this.avatar,
      @required this.displayName,
      @required this.email,
      @required this.userID,
      @required this.score,
      @required this.status,
      @required this.commonLoops});
}

class PublicUserData {
  final String username;
  final String email;
  final String userID;
  // final int score;
  // final String status;

  PublicUserData({
    @required this.username,
    @required this.email,
    @required this.userID,
    //@required this.score
  });
}
