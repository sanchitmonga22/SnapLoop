import 'dart:convert';
import 'dart:typed_data';

import 'package:SnapLoop/app/locator.dart';
import 'package:SnapLoop/services/FABTapped.dart';
import 'package:SnapLoop/services/UserDataService.dart';
import 'package:stacked/stacked.dart';

class NavBarViewModel extends ReactiveViewModel {
  var _userData = locator<UserDataService>();
  var _fabTapped = locator<FABTapped>();

  int get userScore => _userData.user.score;

  String get username => _userData.user.username;

  Uint8List get myImage => _userData.user.myAvatar;

  bool get isTapped {
    return _fabTapped.isTapped;
  }

  void toggleIsTapped() {
    _fabTapped.toggleIsTapped();
  }

  @override
  List<ReactiveServiceMixin> get reactiveServices => [_fabTapped];
}
