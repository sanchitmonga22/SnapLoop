import 'package:SnapLoop/app/locator.dart';
import 'package:SnapLoop/services/UserDataService.dart';
import 'package:stacked/stacked.dart';

class FloatingActionButtonModel extends BaseViewModel {
  var _userData = locator<UserDataService>();
  int get numberOfLoops => _userData.user.numberOfLoopsRemaining;
}
