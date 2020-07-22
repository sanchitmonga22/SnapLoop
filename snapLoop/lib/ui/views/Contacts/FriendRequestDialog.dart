import 'package:SnapLoop/ui/views/Contacts/FriendRequestDialogModel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:stacked/stacked.dart';

import '../../../constants.dart';

class FriendRequestsDialog extends StatefulWidget {
  FriendRequestsDialog({Key key}) : super(key: key);

  @override
  _FriendRequestsDialogState createState() => _FriendRequestsDialogState();
}

class _FriendRequestsDialogState extends State<FriendRequestsDialog> {
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder.reactive(
      viewModelBuilder: () => FriendRequestDialogModel(),
      builder: (context, model, child) {
        model.setRequests();
        return ListView.builder(
          itemCount: model.requests.length,
          itemBuilder: (context, index) {
            return Slidable(
              key: ValueKey(model.requests[index]),
              actionPane: SlidableDrawerActionPane(),
              actions: <Widget>[
                IconSlideAction(
                  caption: 'Accept',
                  color: Colors.green,
                  icon: Icons.add,
                ),
              ],
              secondaryActions: <Widget>[
                IconSlideAction(
                  caption: 'Delete',
                  color: Colors.red,
                  icon: Icons.delete,
                ),
              ],
              dismissal: SlidableDismissal(
                  child: SlidableDrawerDismissal(),
                  onDismissed: (actionType) =>
                      model.onDismissed(actionType, index)),
              child: ListTile(
                subtitle: Text(
                  model.requests[index].email,
                  style: kTextFormFieldStyle.copyWith(
                      color: Colors.white70, fontSize: 10),
                ),
                leading: CircleAvatar(
                  radius: 20,
                  child: Icon(
                    Icons.person,
                    color: Colors.white,
                    size: 20,
                  ),
                ),
                title: Text(
                  model.requests[index].username,
                  style: kTextFormFieldStyle.copyWith(fontSize: 15),
                ),
              ),
            );
          },
        );
      },
    );
  }
}
