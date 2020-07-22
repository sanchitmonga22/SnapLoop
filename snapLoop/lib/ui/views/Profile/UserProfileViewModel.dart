import 'package:SnapLoop/Model/user.dart';
import 'package:SnapLoop/app/locator.dart';
import 'package:SnapLoop/services/Auth.dart';
import 'package:SnapLoop/services/UserDataService.dart';
import 'package:stacked/stacked.dart';

class UserProfileViewModel extends BaseViewModel {
  final _userData = locator<UserDataService>();
  User get user => _userData.user;

  final _auth = locator<Auth>();
  void logout() {
    _auth.logOut();
  }
}
