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
      var friend = ResponseParsingHelper.parseFriend(data['data']);
      _userDataService.addFriend(friend);
    });

    _socket.on("newMessage", (data) async {
      print(data);
      // the message contains, first decide, whether it is a new loop or not
      //_loopsDataService.updateLoop(
      // number of members, timer, loopType,
      // new member addition,
      // new avatars,
      //
      //);
      // update the messages in the existing loop
    });

    _socket.on("newLoop", (data) {
      print(data);
      //_loopsDataService.addNewLoop();
      // update all the loops
    });

    _socket.on("loopComplete", (data) {
      print(data);
      // update the loop status to be completed
    });
  }
}
