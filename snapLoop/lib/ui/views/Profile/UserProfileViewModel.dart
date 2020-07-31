import 'package:SnapLoop/Model/user.dart';
import 'package:SnapLoop/app/locator.dart';
import 'package:SnapLoop/services/Auth.dart';
import 'package:stacked/stacked.dart';

class UserProfileViewModel extends ReactiveViewModel {
  final _auth = locator<Auth>();

  User get user => _auth.user.value;

  void logout() async {
    await _auth.logOut();
  }

  @override
  List<ReactiveServiceMixin> get reactiveServices => [_auth];
}
