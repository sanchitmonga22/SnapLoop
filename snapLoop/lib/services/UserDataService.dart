import 'dart:convert';

import 'package:SnapLoop/app/locator.dart';
import 'package:SnapLoop/services/Auth.dart';
import 'package:SnapLoop/services/ConnectionService.dart';
import 'package:SnapLoop/services/StorageService.dart';
import 'package:contacts_service/contacts_service.dart';
import 'package:http/http.dart' as http;

import 'package:SnapLoop/Model/HttpException.dart';
import 'package:SnapLoop/Model/user.dart';
import 'package:SnapLoop/Model/responseParsingHelper.dart';
import 'package:SnapLoop/app/constants.dart';
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
  final _storageService = locator<StorageService>();
  final _connectionService = locator<ConnectionStatusService>();

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

  void setFriends(List<FriendsData> friends) {
    _friends.addAll(friends);
    _friends.toSet();
  }

  void setRequests(List<PublicUserData> reqs) {
    _requests.addAll(reqs);
    _requests.toSet();
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

  void addRequests(PublicUserData user) {
    _requests.add(user);
    notifyListeners();
  }

  void addFriend(FriendsData friend) {
    _friends.add(friend);
    notifyListeners();
  }

  void addScore(int addition) {
    _auth.user.value.score += addition;
  }

  RequestStatus requestStatusById(String id) {
    RequestStatus requestStatus = RequestStatus.NOT_SENT;
    _auth.user.value.requestsSent.forEach((userid) {
      if (userid == id) {
        requestStatus = RequestStatus.SENT;
        return;
      }
    });
    _friends.forEach((friend) {
      if (friend.userID == id) {
        requestStatus = RequestStatus.FRIEND;
        return;
      }
    });
    _requests.forEach((user) {
      if (user.userID == id) {
        requestStatus = RequestStatus.REQUEST_RECEIVED;
      }
    });
    return requestStatus;
  }

  FriendsData getFriendsData(String id) {
    FriendsData data;
    _friends.forEach((friend) {
      if (friend.userID == id) {
        data = friend;
      }
    });
    return data;
  }

  bool canStartANewLoop() {
    return _auth.user.value.numberOfLoopsRemaining > 0;
  }

  Future<void> setMyImage(String myImage) async {
    try {
      http.Response res = await http.post('$SERVER_IP/users/saveMyImage' as Uri,
          headers: {
            "Content-Type": "application/json",
            "Authorization": "Bearer " + _auth.token,
          },
          body: jsonEncode({"myImage": myImage}));
      if (res.statusCode == 200) {
        _auth.user.value.myAvatar = base64Decode(myImage);
        notifyListeners();
        return;
      } else {
        throw new HttpException("error occured while saving the image");
      }
    } catch (err) {
      throw new HttpException(err.toString());
    }
  }

  Future<void> removeMyImage() async {
    try {
      http.Response res = await http.post(
        '$SERVER_IP/users/removeMyImage' as Uri,
        headers: {
          "Content-Type": "application/json",
          "Authorization": "Bearer " + _auth.token,
        },
      );
      if (res.statusCode == 200) {
        _auth.user.value.myAvatar = null;
        notifyListeners();
        return;
      } else {
        throw new HttpException("error occured while saving the image");
      }
    } catch (err) {
      throw new HttpException(err.toString());
    }
  }

  Future<FriendsData> getFriendsDataById(String userId) async {
    if (_connectionService.connected == false) {
      return _friends.firstWhere((fr) => fr.userID == userId);
    }
    try {
      http.Response res =
          await http.get('$SERVER_IP/users/friendsData' as Uri, headers: {
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
      throw new HttpException(err.toString());
    }
  }

  Future<PublicUserData> getUserDataById(String userId) async {
    try {
      http.Response res =
          await http.get('$SERVER_IP/users/getPublicDataById' as Uri, headers: {
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
      throw new HttpException(err.toString());
    }
  }

  Future<List<PublicUserData>> searchByEmail(String email) async {
    List<PublicUserData> users = [];
    try {
      http.Response res = await http.get(
        '$SERVER_IP/users/getPublicData' as Uri,
        headers: {
          "Content-Type": "application/json",
          'email': email.trim().toLowerCase(),
        },
      );
      if (res.statusCode == 200) {
        final response = json.decode(res.body);
        response.forEach((element) {
          // everyone except the user himself
          if (userId != element['_id'].toString()) {
            users.add(PublicUserData(
                sentRequest: requestStatusById(element['_id']),
                email: element['email'],
                userID: element['_id'],
                username: element['username']));
          }
        });
      }
    } catch (err) {
      throw new HttpException(err.toString());
    }
    return users;
  }

  Future<bool> updateUserData() async {
    try {
      http.Response res = await http.get(
        "$SERVER_IP/users/data" as Uri,
        headers: {
          "Content-Type": "application/json",
          "Authorization": "Bearer " + _auth.token,
        },
      );
      final response = json.decode(res.body);
      if (res.statusCode == 200) {
        await _storageService.addNewKeyValue("userData", response);
        _auth.user.value = ResponseParsingHelper.parseUser(response, userId);
        return true;
      }
      return false;
    } catch (err) {
      throw new HttpException(err.toString());
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
        _requests.toSet();
        return true;
      }
    } catch (err) {
      throw new HttpException(err.toString());
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
      throw new HttpException(err.toString());
    }
  }

  Future<void> sendFriendRequest(String sendToId) async {
    try {
      http.Response res = await http.put(
        '$SERVER_IP/users/sendRequest' as Uri,
        headers: {
          "Authorization": "Bearer " + _auth.token,
          "Content-Type": "application/json",
          "sendToId": sendToId,
        },
      );
      if (res.statusCode == 200) {
        _auth.user.value.requestsSent.add(sendToId);
        notifyListeners();
        return;
      } else {
        throw new HttpException("Request not sent");
      }
    } catch (err) {
      throw new HttpException(err.toString());
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
        '$SERVER_IP/users/acceptRequest' as Uri,
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
      throw new HttpException(err.toString());
    }
  }

  Future<void> removeRequest(String userID) async {
    try {
      http.Response res = await http.post(
        '$SERVER_IP/users/deleteRequest' as Uri,
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
      throw new HttpException(err.toString());
    }
  }

  Future<bool> update(String itemName, String itemValue) async {
    try {
      http.Response res = await http.post('$SERVER_IP/users/update' as Uri,
          headers: {
            "Authorization": "Bearer " + _auth.token,
            "Content-Type": "application/json",
          },
          body: jsonEncode({"item": itemName, "itemValue": itemValue}));
      if (res.statusCode == 200) {
        return true;
      } else {
        throw new HttpException("Request not removed\n" + res.body);
      }
    } catch (err) {
      //throw new HttpException(err.toString());
      print(err.toString());
      return false;
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
