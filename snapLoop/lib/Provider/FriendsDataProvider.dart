import 'package:SnapLoop/Model/loop.dart';
import 'package:flutter/widgets.dart';

class FriendsData {
  final String username;
  final String email;
  final String userID;
  final int score;
  final String status;
  final List<Loop> commonLoops;

  FriendsData(
      {this.username,
      this.email,
      this.userID,
      this.score,
      this.status,
      this.commonLoops});
}

class FriendsDataProvider with ChangeNotifier {
  Future<List<FriendsData>> get friendsData async {
    // make an API call and get all friends data;
    return [
      FriendsData(
          commonLoops: null,
          email: null,
          score: null,
          status: null,
          userID: null,
          username: null)
    ];
  }
}
