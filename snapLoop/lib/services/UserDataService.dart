import 'dart:convert';

import 'package:SnapLoop/app/locator.dart';
import 'package:SnapLoop/services/Auth.dart';
import 'package:contacts_service/contacts_service.dart';
import 'package:http/http.dart' as http;

import 'package:SnapLoop/Model/HttpException.dart';
import 'package:SnapLoop/Model/user.dart';
import 'package:SnapLoop/Model/responseParsingHelper.dart';
import 'package:SnapLoop/constants.dart';
import 'package:injectable/injectable.dart';
import 'package:observable_ish/list/list.dart';
import 'package:observable_ish/set/set.dart';
import 'package:stacked/stacked.dart';

/// author: @sanchitmonga22

@lazySingleton
class UserDataService with ReactiveServiceMixin {
  UserDataService() {
    listenToReactiveValues([_contacts, _requests, _friends]);
  }
  final _auth = locator<Auth>();
  RxList<Contact> _contacts = RxList<Contact>();

  RxSet<PublicUserData> _requests = RxSet<PublicUserData>();

  RxSet<FriendsData> _friends = RxSet<FriendsData>();

  int get userScore {
    return _auth.user.value.score;
  }

  List<PublicUserData> get requests {
    return [..._requests.toList()];
  }

  List<Contact> get contacts {
    return [..._contacts.toList()];
  }

  List<FriendsData> get friends {
    return [..._friends.toList()];
  }

  User get user {
    return _auth.user.value;
  }

  String get userId {
    return user.userID;
  }

  void updateLoopsRemaining() {
    user.numberOfLoopsRemaining--;
  }

  String get username {
    return user.username;
  }

  String get displayName {
    return user.displayName;
  }

  void addRequests(PublicUserData user) {
    _requests.add(user);
    notifyListeners();
  }

  void addFriend(FriendsData friend) {
    _friends.add(friend);
    notifyListeners();
  }

  bool canStartANewLoop() {
    return _auth.user.value.numberOfLoopsRemaining > 0;
  }

  Future<FriendsData> getFriendsDataById(String userId) async {
    try {
      http.Response res =
          await http.get('$SERVER_IP/users/friendsData', headers: {
        "Authorization": "Bearer " + _auth.token,
        "Content-Type": "application/json",
        'friendId': userId,
      });
      if (res.statusCode == 200) {
        final response = json.decode(res.body);
        return ResponseParsingHelper.parseFriend(response);
      } else {
        throw new HttpException('Friend from id not found!');
      }
    } catch (err) {
      throw new HttpException(err);
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
        return ResponseParsingHelper.parsePublicUserData(response);
      } else {
        throw new HttpException("User not found with id:$userId");
      }
    } catch (err) {
      throw new HttpException(err);
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
      throw new HttpException(err);
    }
    return users;
  }

  Future<bool> updateUserData() async {
    try {
      http.Response res = await http.get(
        "$SERVER_IP/users/data",
        headers: {
          "Content-Type": "application/json",
          "Authorization": "Bearer " + _auth.token,
        },
      );
      final response = json.decode(res.body);
      if (res.statusCode == 200) {
        _auth.user.value =
            ResponseParsingHelper.parseUser(response, "", userId);
        return true;
      }
      return false;
    } catch (err) {
      throw new HttpException(err);
    }
  }

// FIXME: weird async behavior,calls api twice and adds the requests twice
  Future<bool> updateRequests() async {
    try {
      // checking for new users
      List<String> newUsers = [];
      newUsers.addAll(user.requestsReceived);
      _requests.forEach((element) {
        if (newUsers.contains(element.userID)) {
          newUsers.remove(element.userID);
        }
      });
      if (newUsers.isEmpty) {
        return true;
      } else {
        for (int i = 0; i < newUsers.length; i++) {
          _requests.add(await getUserDataById(newUsers[i]));
        }
        _requests = _requests.toSet();
        return true;
      }
    } catch (err) {
      throw new HttpException(err);
    }
  }

// FIXME: weird async behavior,calls api twice and adds the friends twice
  Future<bool> updateFriends() async {
    try {
      // checking for new friends (comparing the data)
      List<String> newFriends = [];
      newFriends.addAll(user.friendsIds);
      _friends.forEach((element) {
        if (newFriends.contains(element.userID)) {
          newFriends.remove(element.userID);
        }
      });
      if (newFriends.isEmpty) {
        return true;
      } else {
        for (int i = 0; i < newFriends.length; i++) {
          _friends.add(await getFriendsDataById(newFriends[i]));
        }
        _friends.toSet();
        return true;
      }
    } catch (err) {
      throw new HttpException(err);
    }
  }

  Future<void> sendFriendRequest(String sendToId) async {
    try {
      http.Response res = await http.put(
        '$SERVER_IP/users/sendRequest',
        headers: {
          "Authorization": "Bearer " + _auth.token,
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
      throw new HttpException(err);
    }
  }

  Future<void> acceptRequest(String userID) async {
    PublicUserData req;
    _requests.removeWhere((element) {
      if (element.userID == userID) {
        req = element;
        return true;
      }
      return false;
    });
    try {
      http.Response res = await http.post(
        '$SERVER_IP/users/acceptRequest',
        headers: {
          "Authorization": "Bearer " + _auth.token,
          "Content-Type": "application/json",
          "senderId": userID,
        },
      );
      final response = json.decode(res.body);
      if (res.statusCode == 200) {
        // adding the new friend in the list after accepting the request
        _friends.add(ResponseParsingHelper.parseFriend(response));
        return;
      } else {
        // if request not send add the request back to the list
        _requests.add(req);
        throw new HttpException("Request not sent");
      }
    } catch (err) {
      throw new HttpException(err);
    }
  }

  Future<void> removeRequest(String userID) async {
    try {
      http.Response res = await http.post(
        '$SERVER_IP/users/deleteRequest',
        headers: {
          "Authorization": "Bearer " + _auth.token,
          "Content-Type": "application/json",
          "senderId": userID,
        },
      );
      if (res.statusCode == 200) {
        return;
      } else {
        throw new HttpException("Request not removed");
      }
    } catch (err) {
      throw new HttpException(err);
    }
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

  // Future<bool> updateDisplayName(String value) async {}

  // Future<bool> resetPassword(String value) async {}
  // List<User> universalSearch(String value) {
  // }
  // void syncContacts(List<Contact> contacts) {
  //   if (contacts != null && contacts.length != 0) contacts.addAll(contacts);
  // }

  // List<PublicUserData> get userContacts {
  //   List<PublicUserData> userContacts = [];
  //   if (contacts == null || contacts.isEmpty) return [];

  //   contacts.forEach((e) {
  //     // dummyUsers.users.forEach((element) {
  //     //   if (e.emails.contains(element.email)) {
  //     //     userContacts.add(element);
  //     //   }
  //     // });
  //   });
  //   return userContacts;
  // }

}
