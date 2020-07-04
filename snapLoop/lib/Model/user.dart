import 'package:flutter/foundation.dart';

/// author: @sanchitmonga22

class User {
  final String userID;
  final String username;
  final String displayName;
  final String email;
  final int score;
  List<String> friendsIds;
  // all the loops that the user is involved in
  List<String> loopIDs;

  User(
      {@required this.userID,
      @required this.username,
      @required this.displayName,
      @required this.email,
      @required this.score,
      @required this.friendsIds,
      @required this.loopIDs});
}
