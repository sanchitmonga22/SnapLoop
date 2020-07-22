import 'package:SnapLoop/app/locator.dart';
import 'package:SnapLoop/services/UserDataService.dart';
import 'package:stacked/stacked.dart';

class NavBarViewModel extends BaseViewModel {
  var _userData = locator<UserDataService>();

  int get userScore => _userData.user.score;

  String get displayName => _userData.user.displayName;
}
