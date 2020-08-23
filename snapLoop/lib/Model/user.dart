import 'dart:convert';
import 'dart:typed_data';
import 'package:SnapLoop/Model/loop.dart';
import 'package:flutter/material.dart';

/// author: @sanchitmonga22

class User {
  final String userID;
  final String username;
  final String email;
  int score;
  int numberOfLoopsRemaining;
  Uint8List myAvatar;
  List<String> friendsIds;
  // all the loops that the user is involved in
  List<Loop> loopsData;
  final String phone;
  List<String> requestsSent;
  List<String> requestsReceived;
  String status;
  // people who are in the user's contacts and are part of the snaploop
  List<String> contacts;

  User({
    @required this.status,
    this.myAvatar,
    @required this.userID,
    @required this.numberOfLoopsRemaining,
    @required this.contacts,
    @required this.requestsSent,
    @required this.requestsReceived,
    @required this.loopsData,
    @required this.username,
    @required this.email,
    @required this.score,
    @required this.friendsIds,
    this.phone,
  });

  dynamic toJson() {
    return {
      "status": this.status,
      "username": this.username,
      "myImage": this.myAvatar == null ? "" : base64Encode(this.myAvatar),
      "numberOfLoopsRemaining": this.numberOfLoopsRemaining,
      "contacts": this.contacts,
      "email": this.email,
      "score": this.score,
      "friendsIds": friendsIds,
      "requests": {
        "sent": requestsSent,
        "received": requestsReceived,
      },
      "loopsData": getLoopsData()
    };
  }

  dynamic getLoopsData() {
    var result = [];
    for (int i = 0; i < loopsData.length; i++) {
      result.add(loopsData[i].toJson());
    }
    return result;
  }
}

class FriendsData {
  final String username;
  final String email;
  final String userID;
  final int score;
  final String status;
  final List<String> commonLoops;
  final List<String> mutualFriendsIDs;
  final Uint8List avatar;
  final String phone;

  FriendsData(
      {@required this.username,
      this.avatar,
      @required this.email,
      @required this.userID,
      @required this.score,
      @required this.status,
      @required this.commonLoops,
      this.phone,
      @required this.mutualFriendsIDs});

  dynamic toJson() {
    return {
      "username": this.username,
      "myImage": this.avatar == null ? "" : base64Encode(this.avatar),
      "email": this.email,
      "score": this.score,
      '_id': this.userID,
      'status': this.status,
      'commonLoops': this.commonLoops.toList(),
      'mutualFriends': this.mutualFriendsIDs.toList(),
    };
  }

  @override
  bool operator ==(other) {
    // Dart ensures that operator== isn't called with null
    // if(other == null) {
    //   return false;
    // }
    if (other is! FriendsData) {
      return false;
    }
    return userID == (other as FriendsData).userID;
  }

  int _hashCode;
  @override
  int get hashCode {
    if (_hashCode == null) {
      _hashCode = userID.hashCode;
    }
    return _hashCode;
  }
}

enum RequestStatus { SENT, FRIEND, NOT_SENT, REQUEST_RECEIVED }

class PublicUserData {
  final String username;
  final String email;
  final String userID;
  final RequestStatus sentRequest;
  final Uint8List avatar;
  // final int score;
  // final String status;

  PublicUserData({
    this.avatar,
    @required this.sentRequest,
    @required this.username,
    @required this.email,
    @required this.userID,
    //@required this.score
  });

  dynamic toJson() {
    return {
      "myImage": this.avatar == null ? "" : base64Encode(this.avatar),
      "sentRequest": this.sentRequest,
      "email": this.email,
      "_id": this.userID,
      "username": this.username,
    };
  }

  @override
  bool operator ==(other) {
    // Dart ensures that operator== isn't called with null
    // if(other == null) {
    //   return false;
    // }
    if (other is! PublicUserData) {
      return false;
    }
    return userID == (other as PublicUserData).userID;
  }

  int _hashCode;
  @override
  int get hashCode {
    if (_hashCode == null) {
      _hashCode = userID.hashCode;
    }
    return _hashCode;
  }
}
