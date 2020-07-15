import 'dart:convert';

import 'package:SnapLoop/Model/HttpException.dart';
import 'package:SnapLoop/Model/user.dart';
import 'package:SnapLoop/constants.dart';
import 'package:contacts_service/contacts_service.dart';
import 'package:flutter/widgets.dart';
import 'package:http/http.dart' as http;

/// author: @sanchitmonga22

class UserDataProvider with ChangeNotifier {
  List<Contact> contacts = [];
  List<PublicUserData> requests = [];
  List<FriendsData> friends = [];
  final User user;
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

  Future<void> initializeRequests() async {
    user.requestsReceived.forEach((element) async {
      requests.add(await getUserDataById(element));
    });
  }

  Future<void> initializeFriends() async {
    user.friendsIds.forEach((friend) async {
      friends.add(await getFriendsDataById(friend));
    });
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

  Future<bool> userWithUsernameExists(String username) async {}

  Future<bool> userWithPhoneExists(String phoneNumber) async {}

  Future<bool> userWithEmailExists(String email) async {}

  //for actual Users
  // A call to the server to create a new user
  Future<void> createNewUser(User user) async {}

  Future<List<User>> universalSearchFriend() {}

  Future<List<User>> searchForFriendByName(String name) async {}

  Future<User> searchForFriendById(String userId) async {}

  Future<User> searchFriendByUserName(String username) async {}

  Future<bool> updateDisplayName(String value) async {}

  Future<bool> resetPassword(String value) async {}

  //TODO: Research more on the search since the results can be massive, probably performa a limit and skip in the backend to determine the top results
  // TODO: Research more on the lists when scrolled and accordingly results fetched from the server
  List<User> universalSearch(String value) {
    // This will use the 3 functions below to perform a universal
    // search when the search parameters are not given and create a list of all the probable outcomes
  }

  Future<List<User>> searchForUserByName(String name) async {}

  Future<User> searchForUserById(String userId) async {}

  Future<User> searchUserByUserName(String username) async {}

  Future<bool> addSelectedUserAsAFriend(String userId) async {}

  // Match the email ids and phone numbers provided for each user to load the users with the given phone numbers
  Future<void> syncUserContacts() async {}
  */
}
