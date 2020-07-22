import 'dart:ui';

import 'package:SnapLoop/Model/user.dart';
import 'package:SnapLoop/app/locator.dart';
import 'package:SnapLoop/services/UserDataService.dart';
import 'package:flappy_search_bar/flappy_search_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

import '../../../../constants.dart';

class ContactsViewModel extends BaseViewModel {
  final _userData = locator<UserDataService>();
  SearchBarController _controller = SearchBarController();
  SearchBarController get controller => _controller;

  bool _contactOpened = false;
  bool get contactOpened => _contactOpened;

  // bool _newLoop = false;
  // bool get newLoop => _newLoop;

  // String _loopName = "";
  // String get loopName => _loopName;

  // bool _loopForwarding = false;
  // bool get loopForwarding => _loopForwarding;

  int _activeIndex;
  int get activeIndex => _activeIndex;

  int _requestSentIndex;
  int get requestSentIndex => _requestSentIndex;

  String getNumberOfRequestsReceived(BuildContext context) {
    return _userData.requests.length.toString();
  }

  Future<List<dynamic>> getUsersByEmail(String email, BuildContext context) {
    return _userData.searchByEmail(email);
  }

  List<FriendsData> getMutualFriendsData(
      List<FriendsData> allFriends, List<String> mutualFriendsIDs) {
    List<FriendsData> mutualFriendsData = [];
    mutualFriendsIDs.forEach((e) {
      allFriends.forEach((element) {
        if (element.userID == e) {
          mutualFriendsData.add(element);
        }
      });
    });
    return mutualFriendsData;
  }

  void sendRequest(int index, BuildContext context, userData) async {
    _activeIndex = index;
    notifyListeners();
    await _userData.sendFriendRequest(userData.userID);
    _activeIndex = -1;
    _requestSentIndex = index;
    notifyListeners();
  }

  void createADialog(BuildContext context, Widget widget) {
    showDialog(
      context: context,
      builder: (context) {
        return SafeArea(
          child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: ksigmaX, sigmaY: ksigmaY),
              child: AlertDialog(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20.0)),
                  backgroundColor: Colors.black45,
                  content: Container(
                    height: MediaQuery.of(context).size.height * .65,
                    width: MediaQuery.of(context).size.width,
                    child: widget,
                  ))),
        );
      },
    );
  }
}
