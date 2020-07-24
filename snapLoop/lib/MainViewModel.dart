import 'package:SnapLoop/services/Auth.dart';
import 'package:SnapLoop/services/socketService.dart';
import 'package:stacked/stacked.dart';

import 'app/locator.dart';

class MainViewModel extends ReactiveViewModel {
  final _auth = locator<Auth>();
  final _socket = locator<SocketService>();
  final firstTime = true;

  void createSocketConnection() {
    _socket.createSocketConnection();
    _socket.onConnection();
  }

  bool get isAuth => _auth.isAuth;

  Future<bool> tryAutoLogin() async {
    setBusy(true);
    bool login = await _auth.tryAutoLogin();
    if (login) {
      createSocketConnection();
    }
    notifyListeners();
    setBusy(false);
    return login;
  }

  @override
  List<ReactiveServiceMixin> get reactiveServices => [_auth];
}
