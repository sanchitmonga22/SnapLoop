import 'package:flutter/foundation.dart';

class User {
  final String userID;
  final String username;
  final String displayName;
  final String email;
  final int score;
  List<String> friendsIds;

  User(
      {@required this.userID,
      @required this.username,
      @required this.displayName,
      @required this.email,
      @required this.score,
      @required this.friendsIds});
}
