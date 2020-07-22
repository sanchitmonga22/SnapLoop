import 'package:SnapLoop/app/locator.dart';
import 'package:SnapLoop/services/FABTapped.dart';
import 'package:SnapLoop/services/UserDataService.dart';
import 'package:stacked/stacked.dart';

class FloatingActionButtonModel extends BaseViewModel {
  var _userData = locator<UserDataService>();
  var fabTapped = locator<FABTapped>();

  int get numberOfLoops => _userData.user.numberOfLoopsRemaining;

  void toggleIsTapped() {
    fabTapped.toggleIsTapped();
    notifyListeners();
  }
}
