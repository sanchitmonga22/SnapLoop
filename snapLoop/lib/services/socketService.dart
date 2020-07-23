import 'package:SnapLoop/constants.dart';
import 'package:injectable/injectable.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;

@lazySingleton
class SocketService {
  IO.Socket socket;

  createSocketConnection() {
    socket = IO.io("$SERVER_IP", <String, dynamic>{
      'transports': ['websocket'],
    });

    this.socket.on("connect", (_) => print('Connected'));
    this.socket.on("disconnect", (_) => print('Disconnected'));
  }
}
