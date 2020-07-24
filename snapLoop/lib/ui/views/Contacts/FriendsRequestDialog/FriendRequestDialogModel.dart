import 'package:SnapLoop/Model/user.dart';
import 'package:SnapLoop/app/locator.dart';
import 'package:SnapLoop/services/UserDataService.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:stacked/stacked.dart';

class FriendRequestDialogModel extends ReactiveViewModel {
  final _userData = locator<UserDataService>();

  List<PublicUserData> _requests = [];
  void setRequests() {
    _requests = _userData.requests;
  }

  List<PublicUserData> get requests => _requests;

  void onDismissed(actionType, int index) async {
    String userID = _requests[index].userID;

    _requests.removeAt(index);
    notifyListeners();

    if (actionType == SlideActionType.primary) {
      await _userData.acceptRequest(userID);
    } else if (actionType == SlideActionType.secondary) {
      await _userData.removeRequest(userID);
    }
  }

  @override
  List<ReactiveServiceMixin> get reactiveServices => [_userData];
}
