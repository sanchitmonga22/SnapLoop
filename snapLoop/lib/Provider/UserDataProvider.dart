import 'package:SnapLoop/Model/user.dart';
import 'package:contacts_service/contacts_service.dart';
import 'package:flutter/widgets.dart';
import '../Helper/users.dart' as dummyUsers;

/// author: @sanchitmonga22

class UserDataProvider with ChangeNotifier {
  List<Contact> _contacts = [];
  List<PublicUserData> _requests = dummyUsers.requests;
  List<PublicUserData> allUsers = dummyUsers.users;
  List<FriendsData> _friends = dummyUsers.friends;
  User _user = dummyUsers.user;

  // getting information about the friends
  List<FriendsData> get friends {
    return _friends;
  }

  List<PublicUserData> get requests {
    return _requests;
  }

  int get userScore {
    return _user.score;
  }

  String get username {
    return _user.username;
  }

  String get displayName {
    return _user.displayName;
  }

  void syncContacts(List<Contact> contacts) {
    if (contacts != null && contacts.length != 0) _contacts.addAll(contacts);
  }

  List<PublicUserData> get userContacts {
    List<PublicUserData> userContacts = [];
    if (_contacts == null || _contacts.isEmpty) return [];

    _contacts.forEach((e) {
      dummyUsers.users.forEach((element) {
        if (e.emails.contains(element.email)) {
          userContacts.add(element);
        }
      });
    });
    return userContacts;
  }

  void acceptRequest(String email) {
    PublicUserData user;
    allUsers.forEach((element) {
      if (element.email == email) {
        user = element;
      }
    });
    _friends.add(FriendsData(
      commonLoops: [],
      displayName: user.username,
      email: user.email,
      mutualFriendsIDs: [],
      score: 478,
      userID: user.userID,
      status: "Lol",
      username: user.username,
    ));
    removeRequest(email);
    notifyListeners();
  }

  void removeRequest(String email) {
    _requests.removeWhere((element) => element.email == email);
    notifyListeners();
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

  User get user {
    return _user;
  }

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
