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

    _socket.on('newGroupMessage', (data) async {
      _chatDataService.addNewMessage(data['chatId'],
          await ResponseParsingHelper.parseChatInfo(data['newMessage']));
    });

    _socket.on("newLoop", (data) async {
      print(data);
      _chatDataService
          .addNewChat(await ResponseParsingHelper.parseChat(data['chat']));
      Loop loop = ResponseParsingHelper.parseLoop(data['loop']);
      loop.type = LoopType.NEW_LOOP;
      _loopsDataService.addNewLoop(loop);
    });

    _socket.on("loopComplete", (data) async {
      print(data);
      //_userDataService.addScore(data['score'] as int);
      _loopsDataService.updateLoopType(
          data['loopId'], LoopType.INACTIVE_LOOP_SUCCESSFUL);
      _chatDataService.addNewMessage(
          _loopsDataService.getChatIdFromLoopId(data['loopId']),
          await ResponseParsingHelper.parseChatInfo(data['newMessageData']));
      //TODO:
      // assigning score to the user and do bunch of other stuff
    });

    _socket.on("loopFailed", (data) async {
      print(data);
      _loopsDataService.updateLoopType(
          data['loopId'], LoopType.INACTIVE_LOOP_FAILED);
    });
  }
}
