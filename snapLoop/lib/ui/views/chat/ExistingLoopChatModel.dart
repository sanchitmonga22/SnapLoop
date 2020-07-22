import 'package:SnapLoop/app/locator.dart';
import 'package:SnapLoop/services/UserDataService.dart';
import 'package:stacked/stacked.dart';

class ExistingLoopChatViewModel extends BaseViewModel {
  final _userData = locator<UserDataService>();
}
