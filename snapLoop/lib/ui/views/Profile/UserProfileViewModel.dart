import 'package:SnapLoop/Model/user.dart';
import 'package:SnapLoop/app/locator.dart';
import 'package:SnapLoop/services/Auth.dart';
import 'package:SnapLoop/services/UserDataService.dart';
import 'package:stacked/stacked.dart';

class UserProfileViewModel extends ReactiveViewModel {
  final _auth = locator<Auth>();
  final _userDataService = locator<UserDataService>();

  User get user => _userDataService.user;

  void logout() async {
    await _auth.logOut();
  }

  @override
  List<ReactiveServiceMixin> get reactiveServices => [_auth, _userDataService];
}
