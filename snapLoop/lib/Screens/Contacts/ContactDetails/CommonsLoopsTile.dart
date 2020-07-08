import 'package:SnapLoop/Model/loop.dart';
import 'package:SnapLoop/Model/user.dart';
import 'package:SnapLoop/Screens/Chat/ExistingLoopChatScreen.dart';
import 'package:SnapLoop/Widget/createLoopDialog.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../constants.dart';

class CommonsLoopsTile extends StatelessWidget {
  const CommonsLoopsTile({Key key, this.friendsLoops, this.friend})
      : super(key: key);

  final List<Loop> friendsLoops;
  final FriendsData friend;
  double getRadius(int numberOfMembers, BuildContext context) {
    double radius = 0.0;
    radius = MediaQuery.of(context).size.width *
        0.25 *
        (numberOfMembers > 12
            ? kfixedRadiusFactor["MAX"]
            : kfixedRadiusFactor[numberOfMembers]);
    return radius;
  }

  @override
  Widget build(BuildContext context) {
    return ExpansionTile(
      title: Text(
        "Common Loops",
        style: kTextFormFieldStyle.copyWith(fontWeight: FontWeight.normal),
      ),
      children: [
        friendsLoops.isEmpty
            ? Container(
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.white, width: 1),
                ),
                child: ListTile(
                  title: AutoSizeText(
                    "You don't have any loops in common with ${friend.username}.",
                    style: kTextFormFieldStyle.copyWith(
                        color: kSystemPrimaryColor,
                        fontSize: 15,
                        fontWeight: FontWeight.w100),
                    maxLines: 3,
                  ),
                  subtitle: AutoSizeText(
                    "Click on the icon to start a new loop with the user!",
                    style: kTextFormFieldStyle.copyWith(
                        fontWeight: FontWeight.w100),
                  ),
                  trailing: GestureDetector(
                    onTap: () {
                      showDialog(
                        context: context,
                        barrierDismissible: false,
                        builder: (context) {
                          return CreateALoopDialog(
                            friend: friend,
                          );
                        },
                      );
                    },
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(
                          CupertinoIcons.loop,
                          color: Colors.white,
                        ),
                        Icon(CupertinoIcons.add, color: Colors.white, size: 15)
                      ],
                    ),
                  ),
                ),
              )
            : ListView.builder(
                itemCount: friendsLoops.length,
                scrollDirection: Axis.vertical,
                shrinkWrap: true,
                itemBuilder: (context, index) {
                  return Container(
                    decoration: BoxDecoration(
                        color: determineLoopColor(friendsLoops[index].type)
                            .withOpacity(0.7)),
                    child: ListTile(
                        onTap: () {
                          Navigator.pushReplacement(
                              context,
                              new MaterialPageRoute(
                                  builder: (context) => ExistingLoopChatScreen(
                                        key: ValueKey(index),
                                        loop: friendsLoops[index],
                                        radius: getRadius(
                                            friendsLoops[index].numberOfMembers,
                                            context),
                                      )));
                        },
                        dense: true,
                        title: Text(friendsLoops[index].name,
                            style: kTextFormFieldStyle)),
                  );
                },
              ),
      ],
    );
  }
}
