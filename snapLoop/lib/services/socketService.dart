import 'package:SnapLoop/Model/user.dart';
import 'package:SnapLoop/app/locator.dart';
import 'package:SnapLoop/constants.dart';
import 'package:SnapLoop/services/Auth.dart';
import 'package:injectable/injectable.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;
import 'package:stacked/stacked.dart';

@lazySingleton
class SocketService with ReactiveServiceMixin {
  final _auth = locator<Auth>();
  SocketService() {
    listenToReactiveValues([]);
  }
  IO.Socket _socket;

  void createSocketConnection() {
    _socket = IO.io("$SERVER_IP", <String, dynamic>{
      'transports': ['websocket'],
      'query': {"token": 'Bearer ${_auth.token}'}
    });
    // this.socket.on("connect", (_) => print('Connected'));
    // this.socket.on("disconnect", (_) => print('Disconnected'));
  }

  void onConnection() {
    _socket.on("connection", (data) => print("connected!!"));
    _socket.on('well', (data) {
      print(data);
    });
  }

  FriendsData requestAccepted() {
    _socket.on("requestAccepted", (data) {});
  }
}
