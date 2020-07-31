import 'package:SnapLoop/Model/chat.dart';
import 'package:SnapLoop/Model/loop.dart';
import 'package:SnapLoop/Model/user.dart';
import 'package:SnapLoop/app/locator.dart';
import 'package:SnapLoop/services/ChatDataService.dart';
import 'package:SnapLoop/services/LoopsDataService.dart';
import 'package:SnapLoop/services/UserDataService.dart';
import 'package:SnapLoop/ui/Widget/time/timezones.dart';
import 'package:SnapLoop/ui/views/Home/LoopWidget/loopWidgetView.dart';
import 'package:flutter/cupertino.dart';
import 'package:stacked/stacked.dart';

import '../../../../constants.dart';

class NewLoopChatViewModel extends ReactiveViewModel {
  final _userDataService = locator<UserDataService>();
  final _loopDataService = locator<LoopsDataService>();
  final _chatDataService = locator<ChatDataService>();

  double _radius;

  Loop _loop;
  Loop get loop => _loop;

  LoopWidgetView _loopWidget;
  LoopWidgetView get loopWidget => _loopWidget;

  Chat _chat;
  // Chat get chat => _chat;

  FriendsData _friend;

  Color _backgroundColor = determineLoopColor(LoopType.EXISTING_LOOP);
  Color get backgroundColor => _backgroundColor;

  List<dynamic> _images;
  List<dynamic> get image => _images;

  String _loopId = "";
  String get loopId => _loopId;

  String _loopName;
  String get loopName => _loopName;

  bool first = true;
  bool _messageSent = false;
  bool get messageSent => _messageSent;

  void initialize(String loopName, FriendsData friend, double radius) async {
    _loopName = loopName;
    _friend = friend;
    _radius = radius;
    setBusy(true);
    await initializeScreen();
    setBusy(false);
  }

  Future<void> initializeScreen() async {
    if (!first) return;
    _images = await _loopDataService.getRandomAvatarURL(2);
    _loop = new Loop(
        currentUserId: _friend.userID,
        chatID: "",
        creatorId: _userDataService.userId,
        id: "",
        avatars: {
          _userDataService.userId: _images[0],
          _friend.userID: _images[1]
        },
        name: loopName,
        numberOfMembers: 2,
        type: LoopType.NEW_LOOP,
        userIDs: [_userDataService.userId, _friend.userID]);
    _chat = new Chat(chatID: "", chat: []);
    _loopWidget = LoopWidgetView(
      isTappable: false,
      radius: _radius,
      flipOnTouch: false,
      loop: loop,
    );
    return;
  }

  Future<void> sendMessage(String enteredMessage) async {
    enteredMessage = enteredMessage.trim();
    var result = await _loopDataService.createLoop(
        _loopName, _friend.userID, enteredMessage, _images[1], _images[0]);
    if (result != null) {
      _loop.chatID = result["chatId"];
      _loop.id = result['_id'];
      _loop.type = LoopType.EXISTING_LOOP;
      _chat.chatID = result['chatId'];
      _chat.chat.add(ChatInfo(
          senderID: _userDataService.userId,
          content: enteredMessage,
          time: await TimeHelperService.convertToLocal(
              DateTime.fromMillisecondsSinceEpoch(result["sentTime"]))));

      _loop.atTimeEnding =
          DateTime.fromMillisecondsSinceEpoch(result['sentTime'])
              .add(Duration(days: 1));

      _chatDataService.addNewChat(_chat);
      _loopDataService.addNewLoop(_loop);
      _loopId = result['_id'];
      _userDataService.addScore(result['score'] as int);
      _messageSent = true;
    } else {
      throw new Exception("result not found and loop not created");
    }
  }

  @override
  List<ReactiveServiceMixin> get reactiveServices => [_chatDataService];
}
