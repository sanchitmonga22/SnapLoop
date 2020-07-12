import 'dart:ui';

import 'package:SnapLoop/Model/loop.dart';
import 'package:flutter/material.dart';

/// author: @sanchitmonga22

class User {
  final String userID;
  final String username;
  String displayName; // can be set to the same as username
  final String email;
  final int score;
  List<String> friendsIds;
  // all the loops that the user is involved in
  List<Loop> loopsData;
  final String phone;
  final Image avatar;
  List<String> requests;
  // people who are in the user's contacts and are part of the snaploop
  List<String> contacts;

  User({
    @required this.userID,
    @required this.contacts,
    @required this.requests,
    @required this.loopsData,
    this.avatar,
    @required this.username,
    @required this.displayName,
    @required this.email,
    @required this.score,
    @required this.friendsIds,
    this.phone,
  });
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
  final List<String> mutualFriendsIDs;
  final Image avatar;
  final String phone;

  FriendsData(
      {@required this.username,
      this.avatar,
      @required this.displayName,
      @required this.email,
      @required this.userID,
      @required this.score,
      @required this.status,
      @required this.commonLoops,
      this.phone,
      @required this.mutualFriendsIDs});
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
