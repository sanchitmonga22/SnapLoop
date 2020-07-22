import 'package:SnapLoop/app/locator.dart';
import 'package:SnapLoop/services/Auth.dart';
import 'package:stacked/stacked.dart';

class UserProfileViewModel extends BaseViewModel {
  final _auth = locator<Auth>();
  void logout() {
    _auth.logOut();
  }
}
