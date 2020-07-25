import 'dart:convert';

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
    _socket.on("connection", (data) => print("connected!!"));

    _socket.on('well', (data) {
      print(data);
    });

    _socket.on("requestReceived", (data) {
      var user = ResponseParsingHelper.parsePublicUserData(data);
      print(user.userID);
      _userDataService.addRequests(user);
    });

    _socket.on("requestAccepted", (data) {
      print(data);
      // update the friends
    });

    _socket.on("newMessage", (data) {
      print(data);
      // update the messages in the existing loop
    });

    _socket.on("newLoop", (data) {
      print(data);
      // update all the loops
    });

    _socket.on("loopComplete", (data) {
      print(data);
      // update the loop status to be completed
    });
  }
}
