import 'package:SnapLoop/Model/loop.dart';
import 'package:SnapLoop/Model/user.dart';
import 'package:SnapLoop/Screens/Contacts/ContactDetails/CommonsLoopsTile.dart';
import 'package:SnapLoop/Screens/Contacts/ContactDetails/MutualFriendsTile.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../constants.dart';

class ContactsDetailsWidget extends StatelessWidget {
  const ContactsDetailsWidget(
      {Key key, this.friend, this.friendsLoops, this.friends})
      : super(key: key);
  // represents a single friend created by this widget
  final FriendsData friend;
  final List<Loop> friendsLoops;
  // list of all the friends of the users
  final List<FriendsData> friends;

  @override
  Widget build(BuildContext context) {
    return ExpansionTile(
      backgroundColor: Colors.black,
      maintainState: true,
      title: Text(
        friend.displayName,
        style: kTextFormFieldStyle.copyWith(
            fontWeight: FontWeight.bold, color: kSystemPrimaryColor),
      ),
      leading: CircleAvatar(
        child: friend.avatar ?? Icon(Icons.person),
        backgroundColor: kSystemPrimaryColor,
      ),
      trailing: Text(
        "Score: ${friend.score}",
        style: kTextFormFieldStyle.copyWith(color: kSystemPrimaryColor),
      ),
      subtitle: AutoSizeText(
        friend.email,
        style: kTextFormFieldStyle.copyWith(),
      ),
      children: [
        Container(
          padding: const EdgeInsets.all(15.0),
          child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Status: ${friend.status}",
                  textAlign: TextAlign.left,
                  style: kTextFormFieldStyle.copyWith(
                      fontWeight: FontWeight.w600, fontSize: 15),
                ),
                SizedBox(
                  height: 5,
                ),
                Text(
                  "User ID: ${friend.userID}",
                  textAlign: TextAlign.left,
                  style: kTextFormFieldStyle.copyWith(),
                ),
                SizedBox(
                  height: 5,
                ),
                CommonsLoopsTile(
                  friend: friend,
                  friendsLoops: friendsLoops,
                ),
                MutualFriendsTile(
                  friend: friend,
                  friends: friends,
                )
              ]),
        )
      ],
      // children: [
      //   Row(
      //     children: [Text()],
      //   )
      // ],
    );
  }
}
