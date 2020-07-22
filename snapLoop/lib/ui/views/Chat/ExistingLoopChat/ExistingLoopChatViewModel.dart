import 'package:SnapLoop/Model/loop.dart';
import 'package:SnapLoop/Model/user.dart';
import 'package:SnapLoop/app/locator.dart';
import 'package:SnapLoop/app/router.gr.dart';
import 'package:SnapLoop/services/ChatDataService.dart';
import 'package:SnapLoop/services/LoopsDataService.dart';
import 'package:SnapLoop/services/UserDataService.dart';
import 'package:SnapLoop/ui/views/Home/LoopWidget/loopWidgetView.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

import '../../../../constants.dart';

class ExistingLoopChatViewModel extends BaseViewModel {
  final _chatDataService = locator<ChatDataService>();
  final _loopDataService = locator<LoopsDataService>();
  final _userDataService = locator<UserDataService>();
  Loop _loop;
  double _radius;

  Future<void> initialize(Loop loop, double radius) async {
    _loop = loop;
    _radius = radius;
  }

  LoopWidgetView get loopWidget => LoopWidgetView(
        isTappable: false,
        loop: _loop,
        radius: _radius,
        flipOnTouch: false,
      );

  Loop get loop => _loop;

  Color get backgroundColor => determineLoopColor(_loop.type);

  Future<bool> initializeChat() async {
    await _chatDataService.initializeChatByIdFromNetwork(_loop.chatID);
    return true;
  }

  Future<void> sendMessage(String enteredMessage, BuildContext context) async {
    var friend = await Navigator.of(context).pushNamed(
      Routes.friendsView,
      arguments:
          FriendsViewArguments(loopName: _loop.name, loopForwarding: true),
    ) as FriendsData;

    List<dynamic> imageUrl = await _loopDataService.getRandomAvatarURL(1);

    await _loopDataService.forwardLoop(
        friend.userID, enteredMessage, imageUrl[0], _loop.chatID, _loop.id);

    await _chatDataService.initializeChatByIdFromNetwork(_loop.chatID);

    await _userDataService.updateUserData();

    _loopDataService.initializeLoopsFromUserData();

    _loop = _loopDataService.findById(_loop.id);
    notifyListeners();
  }
}
