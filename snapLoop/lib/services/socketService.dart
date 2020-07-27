import 'package:SnapLoop/Model/loop.dart';
import 'package:SnapLoop/Model/responseParsingHelper.dart';
import 'package:SnapLoop/app/locator.dart';
import 'package:SnapLoop/constants.dart';
import 'package:SnapLoop/services/Auth.dart';
import 'package:SnapLoop/services/ChatDataService.dart';
import 'package:SnapLoop/services/LoopsDataService.dart';
import 'package:injectable/injectable.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;
import 'package:stacked/stacked.dart';

import 'UserDataService.dart';

@lazySingleton
class SocketService with ReactiveServiceMixin {
  final _auth = locator<Auth>();
  final _userDataService = locator<UserDataService>();
  final _loopsDataService = locator<LoopsDataService>();
  final _chatDataService = locator<ChatDataService>();

  IO.Socket _socket;

  void createSocketConnection() {
    print('created');
    _socket = IO.io("$SERVER_IP", <String, dynamic>{
      'transports': ['websocket'],
      'query': {"token": 'Bearer ${_auth.token}'}
    });
    onConnection();
  }

  void onConnection() {
    _socket.on("connect", (data) => print("connected!!"));

    _socket.on("requestReceived", (data) {
      print(data);
      var user = ResponseParsingHelper.parsePublicUserData(data);
      _userDataService.addRequests(user);
    });

    _socket.on("requestAccepted", (data) {
      print(data);
      var friend = ResponseParsingHelper.parseFriend(data);
      _userDataService.addFriend(friend);
    });

    _socket.on("newMessage", (data) async {
      print(data);
      _loopsDataService.updateExistingLoop(data);
      _chatDataService.addNewMessage(
          _loopsDataService.loops
              .firstWhere((element) => element.id == data['loopId'])
              .chatID,
          await ResponseParsingHelper.parseChatInfo(data['newMessageData']));
    });

    _socket.on("newLoop", (data) async {
      _chatDataService
          .addNewChat(await ResponseParsingHelper.parseChat(data['chat']));
      Loop loop = ResponseParsingHelper.parseLoop(data['loop']);
      loop.type = LoopType.NEW_LOOP;
      _loopsDataService.addNewLoop(loop);
    });

    _socket.on("loopComplete", (data) async {
      print(data);
      Loop loop = _loopsDataService.loops
          .firstWhere((element) => element.id == data['loopId']);
      loop.type = LoopType.INACTIVE_LOOP_SUCCESSFUL;
      // assigning score to the user and do bunch of other stuff
      _chatDataService.addNewMessage(loop.chatID,
          await ResponseParsingHelper.parseChatInfo(data['newMessageData']));
    });
  }
}
