import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

import '../constants.dart';

class FriendRequestsDialog extends StatefulWidget {
  FriendRequestsDialog({Key key}) : super(key: key);

  @override
  _FriendRequestsDialogState createState() => _FriendRequestsDialogState();
}

class _FriendRequestsDialogState extends State<FriendRequestsDialog> {
  @override
  Widget build(BuildContext context) {
    return ListView(
      //           ListView.builder(
      //     itemCount: 100,
      //     itemBuilder: (context, index) {
      //       return Slidable(
      //         key: ValueKey(index),
      //         actionPane: SlidableDrawerActionPane(),
      //         actions: <Widget>[
      //           IconSlideAction(
      //             caption: 'Share',
      //             color: Colors.indigo,
      //             icon: Icons.share,
      //           ),
      //         ],
      //         secondaryActions: <Widget>[
      //           IconSlideAction(
      //             caption: 'Delete',
      //             color: Colors.red,
      //             icon: Icons.delete,
      //           ),
      //         ],
      //         dismissal: SlidableDismissal(
      //           child: SlidableDrawerDismissal(),
      //         ),
      //         child: ListTile(
      //           title: Text('$index'),
      //         ),
      //       );
      //     },
      //   ),
      // );
      children: [
        Slidable(
          key: UniqueKey(),
          dismissal: SlidableDismissal(
            child: SlidableDrawerDismissal(),
            onDismissed: (actionType) {
              if (actionType == SlideActionType.primary) {
                print(actionType.index);
                // accept the request
              } else if (actionType == SlideActionType.secondary) {
                // deny the request
                print(actionType.index);
              }
              // TODO: remove from the list
            },
          ),
          actionPane: SlidableDrawerActionPane(
            key: UniqueKey(),
          ),
          actionExtentRatio: 1,
          child: Container(
            child: ListTile(
              subtitle: Text(
                "sanchitmonga22@gmail.com",
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
                "sanchitmonga22",
                style: kTextFormFieldStyle.copyWith(fontSize: 15),
              ),
              trailing: Text(
                "Score:250",
                style: TextStyle(color: Colors.white, fontSize: 10),
              ),
            ),
          ),
          actions: <Widget>[
            IconSlideAction(
              caption: 'Accept',
              color: Colors.green,
              icon: Icons.add,
              onTap: () {},
            ),
          ],
          secondaryActions: <Widget>[
            IconSlideAction(
              caption: 'Delete',
              color: Colors.red,
              icon: Icons.delete,
              onTap: () {},
            ),
          ],
        ),
      ],
    );
  }
}
