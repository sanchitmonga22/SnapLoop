import 'package:SnapLoop/services/Auth.dart';
import 'package:stacked/stacked.dart';

import 'app/locator.dart';

class MainModel extends BaseViewModel {
  final _auth = locator<Auth>();

  bool _isAuth = false;
  bool get isAuth => _isAuth;

  Future<void> tryAutoLogin() async {
    _isAuth = await _auth.tryAutoLogin();
    notifyListeners();
  }
}
