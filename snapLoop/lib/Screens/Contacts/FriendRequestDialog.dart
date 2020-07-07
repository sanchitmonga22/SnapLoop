import 'package:SnapLoop/Model/user.dart';
import 'package:SnapLoop/Provider/UserDataProvider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:provider/provider.dart';

import '../../constants.dart';

class FriendRequestsDialog extends StatefulWidget {
  FriendRequestsDialog({Key key}) : super(key: key);

  @override
  _FriendRequestsDialogState createState() => _FriendRequestsDialogState();
}

class _FriendRequestsDialogState extends State<FriendRequestsDialog> {
  @override
  Widget build(BuildContext context) {
    List<PublicUserData> requests =
        Provider.of<UserDataProvider>(context).requests;
    return ListView.builder(
      itemCount: requests.length,
      itemBuilder: (context, index) {
        return Slidable(
          key: ValueKey(requests[index]),
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
            onDismissed: (actionType) {
              String email = requests[index].email;
              print(index);
              setState(() {
                requests.removeAt(index);
              });
              if (actionType == SlideActionType.primary) {
                Provider.of<UserDataProvider>(context, listen: false)
                    .acceptRequest(email);
              } else if (actionType == SlideActionType.secondary) {
                Provider.of<UserDataProvider>(context, listen: false)
                    .removeRequest(email);
              }
            },
          ),
          child: ListTile(
            subtitle: Text(
              requests[index].email,
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
              requests[index].username,
              style: kTextFormFieldStyle.copyWith(fontSize: 15),
            ),
          ),
        );
      },
    );
  }
}
