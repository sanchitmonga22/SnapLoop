import 'dart:convert';

import 'package:SnapLoop/Model/HttpException.dart';
import 'package:SnapLoop/Model/user.dart';
import 'package:SnapLoop/Provider/responseParsingHelper.dart';
import 'package:SnapLoop/constants.dart';
import 'package:contacts_service/contacts_service.dart';
import 'package:flutter/widgets.dart';
import 'package:http/http.dart' as http;

/// author: @sanchitmonga22

class UserDataProvider with ChangeNotifier {
  List<Contact> contacts = [];
  List<PublicUserData> requests = [];
  List<FriendsData> friends = [];
  User user;
  final String token;
  final String userId;

  UserDataProvider({
    this.user,
    this.token,
    this.userId,
  });

  int get userScore {
    return user.score;
  }

  User get userData {
    return user;
  }

  List<FriendsData> get friendsData {
    return [...friends];
  }

  String get username {
    return user.username;
  }

  String get displayName {
    return user.displayName;
  }

  void syncContacts(List<Contact> contacts) {
    if (contacts != null && contacts.length != 0) contacts.addAll(contacts);
  }

  List<PublicUserData> get userContacts {
    List<PublicUserData> userContacts = [];
    if (contacts == null || contacts.isEmpty) return [];

    contacts.forEach((e) {
      // dummyUsers.users.forEach((element) {
      //   if (e.emails.contains(element.email)) {
      //     userContacts.add(element);
      //   }
      // });
    });
    return userContacts;
  }

  Future<FriendsData> getFriendsDataById(String userId) async {
    try {
      http.Response res =
          await http.get('$SERVER_IP/users/friendsData', headers: {
        "Authorization": "Bearer " + token,
        "Content-Type": "application/json",
        'friendId': userId,
      });
      if (res.statusCode == 200) {
        final response = json.decode(res.body);
        notifyListeners();
        return FriendsData(
            username: response['username'],
            displayName: (response['displayName'] ?? "") == ""
                ? response['username']
                : response['displayName'],
            email: response['email'],
            userID: response['_id'],
            score: response['score'] as int,
            status: response['status'],
            commonLoops:
                (response['commonLoops'] as List).cast<String>().toList(),
            mutualFriendsIDs:
                (response['mutualFriends'] as List).cast<String>().toList());
      }
    } catch (err) {
      print(err);
    }
  }

  Future<PublicUserData> getUserDataById(String userId) async {
    try {
      http.Response res =
          await http.get('$SERVER_IP/users/getPublicDataById', headers: {
        "Content-Type": "application/json",
        'userId': userId,
      });

      if (res.statusCode == 200) {
        final response = json.decode(res.body);
        return PublicUserData(
            email: response['email'],
            userID: response['_id'],
            username: response['username']);
      } else {
        throw new HttpException("User not found with id:$userId");
      }
    } catch (err) {
      print(err);
    }
  }

  Future<bool> updateUserData() async {
    try {
      http.Response res = await http.get(
        "$SERVER_IP/users/data",
        headers: {
          "Content-Type": "application/json",
          "Authorization": "Bearer " + token,
        },
      );
      final response = json.decode(res.body);
      if (res.statusCode == 200) {
        user = ResponseParsingHelper.parseUser(response, "", userId);
        notifyListeners();
        return true;
      }
      return false;
    } catch (err) {
      print(err);
      return false;
    }
  }

  Future<bool> updateRequests() async {
    try {
      // checking for new users
      List<String> newUsers = [];
      newUsers.addAll(user.requestsReceived);
      requests.forEach((element) {
        if (newUsers.contains(element.userID)) {
          newUsers.remove(element.userID);
        }
      });
      if (newUsers.isEmpty) {
        return true;
      } else {
        for (int i = 0; i < newUsers.length; i++) {
          requests.add(await getUserDataById(newUsers[i]));
        }
        return true;
      }
    } catch (err) {
      print(err);
      return false;
    }
  }

  Future<bool> updateFriends() async {
    try {
      // checking for new friends (comparing the data)
      List<String> newFriends = [];
      newFriends.addAll(user.friendsIds);
      friends.forEach((element) {
        if (newFriends.contains(element.userID)) {
          newFriends.remove(element.userID);
        }
      });
      print(newFriends);
      if (newFriends.isEmpty) {
        return true;
      } else {
        for (int i = 0; i < newFriends.length; i++) {
          friends.add(await getFriendsDataById(newFriends[i]));
        }
        return true;
      }
    } catch (err) {
      print(err);
      return false;
    }
  }

  Future<List<PublicUserData>> searchByEmail(String email) async {
    List<PublicUserData> users = [];
    try {
      http.Response res = await http.get(
        '$SERVER_IP/users/getPublicData',
        headers: {
          "Content-Type": "application/json",
          'email': email.trim().toLowerCase(),
        },
      );
      if (res.statusCode == 200) {
        final response = json.decode(res.body);
        response.forEach((element) {
          users.add(PublicUserData(
              email: element['email'],
              userID: element['_id'],
              username: element['username']));
        });
      }
    } catch (err) {
      print(err);
    }
    return users;
  }

  Future<void> sendFriendRequest(String sendToId) async {
    try {
      http.Response res = await http.put(
        '$SERVER_IP/users/sendRequest',
        headers: {
          "Authorization": "Bearer " + token,
          "Content-Type": "application/json",
          "sendToId": sendToId,
        },
      );
      if (res.statusCode == 200) {
        return;
      } else {
        throw new HttpException("Request not sent");
      }
    } catch (err) {
      print(err);
    }
  }

  Future<void> acceptRequest(String userID) async {
    try {
      http.Response res = await http.post(
        '$SERVER_IP/users/acceptRequest',
        headers: {
          "Authorization": "Bearer " + token,
          "Content-Type": "application/json",
          "senderId": userID,
        },
      );
      if (res.statusCode == 200) {
        return;
      } else {
        throw new HttpException("Request not sent");
      }
    } catch (err) {}
  }

  Future<void> removeRequest(String userID) async {
    try {
      http.Response res = await http.post(
        '$SERVER_IP/users/deleteRequest',
        headers: {
          "Authorization": "Bearer " + token,
          "Content-Type": "application/json",
          "senderId": userID,
        },
      );
      if (res.statusCode == 200) {
        return;
      } else {
        throw new HttpException("Request not removed");
      }
    } catch (err) {}
  }

// will use the PublicUserData

  // List<User> get contacts {
  //   List<User> friends = [];
  //   dummyUsers.users.forEach((user) {
  //     if (_user.friendsIds.contains(user.userID)) {
  //       friends.add(user);
  //     }
  //   });
  //   return friends;
  // }

  //AFTER APIs
/**
  //for actual Users
  // A call to the server to create a new user
  Future<void> createNewUser(User user) async {}

  Future<List<User>> universalSearchFriend() {}

  Future<bool> updateDisplayName(String value) async {}

  Future<bool> resetPassword(String value) async {}
  List<User> universalSearch(String value) {
  }

  // Match the email ids and phone numbers provided for each user to load the users with the given phone numbers
  Future<void> syncUserContacts() async {}
  */
}
