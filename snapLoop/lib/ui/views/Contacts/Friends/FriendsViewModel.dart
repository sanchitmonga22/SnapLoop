import 'dart:ui';

import 'package:SnapLoop/Model/loop.dart';
import 'package:SnapLoop/Model/user.dart';
import 'package:SnapLoop/app/locator.dart';
import 'package:SnapLoop/services/LoopsDataService.dart';
import 'package:SnapLoop/services/UserDataService.dart';
import 'package:flappy_search_bar/flappy_search_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

import '../../../../app/constants.dart';

class FriendsViewModel extends ReactiveViewModel {
  final _userData = locator<UserDataService>();
  final _loopData = locator<LoopsDataService>();
  SearchBarController _controller = SearchBarController();
  SearchBarController get controller => _controller;

  String _loopName;
  String get loopName => _loopName;

  bool _loopForwarding;
  bool get loopForwarding => _loopForwarding;

  bool _contactOpened = false;
  bool get contactOpened => _contactOpened;

  bool get newLoop {
    if (_loopName == "") {
      return false;
    }
    return true;
  }

  List<FriendsData> get friends => _userData.friends;

  void initialize(String loopName, bool loopForwarding) async {
    _loopName = loopName;
    _loopForwarding = loopForwarding;
    setBusy(true);
    await _userData.updateFriends();
    if (!newLoop) await _userData.updateRequests();
    setBusy(false);
  }

  int _activeIndex;
  int get activeIndex => _activeIndex;

  String getNumberOfRequestsReceived() {
    return _userData.requests.length.toString();
  }

  Future<List<dynamic>> getUsersByEmail(String email) {
    return _userData.searchByEmail(email);
  }

  List<FriendsData> getMutualFriendsData(List<String> mutualFriendsIDs) {
    List<FriendsData> mutualFriendsData = [];
    mutualFriendsIDs.forEach((e) {
      friends.forEach((element) {
        if (element.userID == e) {
          mutualFriendsData.add(element);
        }
      });
    });
    return mutualFriendsData;
  }

  void sendRequest(int index, userData) async {
    _activeIndex = index;
    notifyListeners();
    await _userData.sendFriendRequest(userData.userID);
    _activeIndex = -1;
    _controller.replayLastSearch();
    notifyListeners();
  }

  List<Loop> getLoopInfoByIds(List<String> commonLoops) {
    return _loopData.getLoopInforByIds(commonLoops);
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

  @override
  List<ReactiveServiceMixin> get reactiveServices => [_userData];
}
