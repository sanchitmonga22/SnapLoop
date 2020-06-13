import 'package:SnapLoop/Model/user.dart';
import 'package:flutter/widgets.dart';
import '../Helper/users.dart' as dummyUsers;

class UserDataProvider with ChangeNotifier {
  User _user = dummyUsers.user;

  // getting information about the friends
  List<User> get friends {
    List<User> friends = [];
    dummyUsers.users.forEach((user) {
      if (_user.friendsIds.contains(user.userID)) {
        friends.add(user);
      }
    });
    return friends;
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

  List<User> get contacts {
    List<User> friends = [];
    dummyUsers.users.forEach((user) {
      if (_user.friendsIds.contains(user.userID)) {
        friends.add(user);
      }
    });
    return friends;
  }

  // for dummy users only, actual users will be stored on the database
  void createUser(User user) {
    dummyUsers.users.add(user);
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
