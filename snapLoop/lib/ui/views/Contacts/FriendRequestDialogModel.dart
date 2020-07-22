import 'package:SnapLoop/Model/user.dart';
import 'package:SnapLoop/app/locator.dart';
import 'package:SnapLoop/services/UserDataService.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:stacked/stacked.dart';

class FriendRequestDialogModel extends BaseViewModel {
  final _userData = locator<UserDataService>();

  List<PublicUserData> _requests = [];
  void setRequests() {
    _requests = _userData.requests;
  }

  List<PublicUserData> get requests => _requests;

  void onDismissed(actionType, int index) {
    String userID = _requests[index].userID;

    _requests.removeAt(index);
    notifyListeners();

    if (actionType == SlideActionType.primary) {
      _userData.acceptRequest(userID);
    } else if (actionType == SlideActionType.secondary) {
      _userData.removeRequest(userID);
    }
  }
}
