import 'package:SnapLoop/app/locator.dart';
import 'package:SnapLoop/services/FABTapped.dart';
import 'package:SnapLoop/services/UserDataService.dart';
import 'package:stacked/stacked.dart';

class FloatingActionButtonModel extends ReactiveViewModel {
  var _userData = locator<UserDataService>();
  var _fabTapped = locator<FABTapped>();

  int get numberOfLoops => _userData.user.numberOfLoopsRemaining;

  void toggleIsTapped() {
    _fabTapped.toggleIsTapped();
  }

  @override
  List<ReactiveServiceMixin> get reactiveServices => [_fabTapped];
}
