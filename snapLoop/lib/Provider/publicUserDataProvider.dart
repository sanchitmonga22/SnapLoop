import 'package:flutter/foundation.dart';

/// author: @sanchitmonga22

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

class PublicUserDataProvider with ChangeNotifier {
  String url;

  Future<List<PublicUserData>> getUsers(String username) async {
    // make the API call to get the users search results;

    return [
      PublicUserData(
        username: null,
        email: null,
        userID: null,
      )
    ];
  }
}
