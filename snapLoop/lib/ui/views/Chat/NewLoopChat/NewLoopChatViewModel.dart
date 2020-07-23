import 'package:SnapLoop/Model/chat.dart';
import 'package:SnapLoop/Model/loop.dart';
import 'package:SnapLoop/Model/user.dart';
import 'package:SnapLoop/app/locator.dart';
import 'package:SnapLoop/services/ChatDataService.dart';
import 'package:SnapLoop/services/LoopsDataService.dart';
import 'package:SnapLoop/services/UserDataService.dart';
import 'package:SnapLoop/ui/views/Home/LoopWidget/loopWidgetView.dart';
import 'package:flutter/cupertino.dart';
import 'package:stacked/stacked.dart';

import '../../../../constants.dart';

class NewLoopChatViewModel extends BaseViewModel {
  final _userDataService = locator<UserDataService>();
  final _loopDataService = locator<LoopsDataService>();
  final _chatDataService = locator<ChatDataService>();

  double _radius;

  Loop _loop;

  LoopWidgetView _loopWidget;
  LoopWidgetView get loopWidget => _loopWidget;

  Chat _chat;
  Chat get chat => _chat;

  FriendsData _friend;

  Color _backgroundColor = determineLoopColor(LoopType.EXISTING_LOOP);
  Color get backgroundColor => _backgroundColor;

  List<dynamic> _images;
  List<dynamic> get image => _images;

  String _loopId = "";
  String get loopId => _loopId;

  String _loopName;
  String get loopName => _loopName;

  void initialize(BuildContext context, String loopName, FriendsData friend) {
    _loopName = loopName;
    _friend = friend;
    //_radius=
  }

  Future<bool> initializeScreen() async {
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
      loop: _loop,
    );
    return true;
  }

  Future<void> sendMessage(String enteredMessage) async {
    var result = await _loopDataService.createLoop(
        _loopName, _friend.userID, enteredMessage, _images[1], _images[0]);
    notifyListeners();

    if (result != null) {
      _loop.chatID = result["chatId"];
      _loop.id = result['_id'];
      _chat.chatID = result['chatId'];
      _chat.chat.add(ChatInfo(
          senderID: _userDataService.userId,
          content: enteredMessage,
          time:
              DateTime.fromMicrosecondsSinceEpoch(result["sentTime"] as int)));
      _loopDataService.addNewLoop(_loop);
      await _chatDataService.initializeChatByIdFromNetwork(_loop.chatID);
      await _userDataService.updateUserData();
      _loopDataService.initializeLoopsFromUserData();
      // rebuilding the widget once the chat has been saved in the chats array in the chat provider
      _loopId = result['_id'];
      notifyListeners();
    } else {
      print("result not found and loop not created");
    }
  }
}
