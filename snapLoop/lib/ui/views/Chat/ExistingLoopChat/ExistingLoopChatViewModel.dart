import 'package:SnapLoop/Model/loop.dart';

import 'package:SnapLoop/Model/user.dart';
import 'package:SnapLoop/app/locator.dart';
import 'package:SnapLoop/app/router.gr.dart';
import 'package:SnapLoop/services/ChatDataService.dart';
import 'package:SnapLoop/services/LoopsDataService.dart';
import 'package:SnapLoop/ui/views/Home/LoopWidget/loopWidgetView.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

import '../../../../constants.dart';

class ExistingLoopChatViewModel extends ReactiveViewModel {
  final _chatDataService = locator<ChatDataService>();
  final _loopDataService = locator<LoopsDataService>();
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
    var friend = await Navigator.of(context).pushNamed(
      Routes.friendsView,
      arguments:
          FriendsViewArguments(loopName: _loop.name, loopForwarding: true),
    ) as FriendsData;

    await _loopDataService.forwardLoop(
        friend.userID, enteredMessage, _loop.chatID, _loop.id);

    _loop =
        _loopDataService.loops.firstWhere((element) => element.id == _loop.id);

    if (_loop.type == LoopType.INACTIVE_LOOP_SUCCESSFUL) {
      //TODO:::
      // update the score and everything receieved from the server
      // update the UI such that all the user's who are not friends public data is visible in the loopDetails view,
      // and along with the message bubble it should be reveiled who sent what
      // remove the timer
      // TODO: SERVER: Convert this into a group chat
    }
    notifyListeners();
  }

  @override
  List<ReactiveServiceMixin> get reactiveServices =>
      [_loopDataService, _chatDataService];
}
