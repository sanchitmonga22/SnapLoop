import 'package:SnapLoop/Model/chat.dart';
import 'package:SnapLoop/Model/loop.dart';

import 'package:SnapLoop/Model/user.dart';
import 'package:SnapLoop/app/locator.dart';
import 'package:SnapLoop/app/router.gr.dart';
import 'package:SnapLoop/services/ChatDataService.dart';
import 'package:SnapLoop/services/LoopsDataService.dart';
import 'package:SnapLoop/services/UserDataService.dart';
import 'package:SnapLoop/ui/Widget/time/timezones.dart';
import 'package:SnapLoop/ui/views/Home/LoopWidget/loopWidgetView.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

import '../../../../constants.dart';

class ExistingLoopChatViewModel extends ReactiveViewModel {
  final _chatDataService = locator<ChatDataService>();
  final _loopDataService = locator<LoopsDataService>();
  final _userDataService = locator<UserDataService>();
  Loop _loop;
  double _radius;

  void initialize(Loop loop, double radius) async {
    _loop = loop;
    _radius = radius;
    setBusy(true);
    await _chatDataService.initializeChatByIdFromNetwork(_loop.chatID);
    setBusy(false);
  }

  LoopWidgetView get loopWidget => LoopWidgetView(
        isTappable: false,
        loop: _loop,
        radius: _radius,
        flipOnTouch: false,
      );

  Loop get loop => _loop;

  Color get backgroundColor => determineLoopColor(_loop.type);

  Future<void> sendMessage(String enteredMessage, BuildContext context) async {
    // sending new group message
    if (loop.type == LoopType.INACTIVE_LOOP_SUCCESSFUL) {
      final response = await _chatDataService.sendNewGroupMessage(
          _loop.chatID, _loop.id, enteredMessage);
      _chatDataService.addNewMessage(
          _loop.chatID,
          ChatInfo(
              senderID: _userDataService.userId,
              content: enteredMessage,
              time: await TimeHelperService.convertToLocal(
                  DateTime.fromMillisecondsSinceEpoch(response['sentTime']))));
    } else {
      // forwarding a message
      var friend = await Navigator.of(context).pushNamed(
        Routes.friendsView,
        arguments:
            FriendsViewArguments(loopName: _loop.name, loopForwarding: true),
      ) as FriendsData;

      final response = await _loopDataService.forwardLoop(
          friend.userID, enteredMessage, _loop.chatID, _loop.id);
      _chatDataService.addNewMessage(
          _loopDataService.getChatIdFromLoopId(_loop.id),
          ChatInfo(
              senderID: _userDataService.userId,
              content: enteredMessage,
              time: await TimeHelperService.convertToLocal(
                  DateTime.fromMillisecondsSinceEpoch(response["sentTime"]))));
    }
    notifyListeners();
  }

  @override
  List<ReactiveServiceMixin> get reactiveServices =>
      [_loopDataService, _chatDataService];
}
