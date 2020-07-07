import 'dart:ui';

import 'package:SnapLoop/Model/user.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';

import '../../../constants.dart';
import '../ContactsDialog.dart';

class MutualFriendsTile extends StatelessWidget {
  const MutualFriendsTile({Key key, this.friend, this.friends})
      : super(key: key);
  final FriendsData friend;
  final List<FriendsData> friends;

  List<FriendsData> getMutualFriendsData(
      List<FriendsData> allFriends, List<String> mutualFriendsIDs) {
    List<FriendsData> mutualFriendsData = [];
    mutualFriendsIDs.forEach((e) {
      allFriends.forEach((element) {
        if (element.userID == e) {
          mutualFriendsData.add(element);
        }
      });
    });
    return mutualFriendsData;
  }

  @override
  Widget build(BuildContext context) {
    return ExpansionTile(
      title: Text(
        "Mutual Friends",
        style: kTextFormFieldStyle.copyWith(fontWeight: FontWeight.normal),
      ),
      children: [
        friend.mutualFriendsIDs.isEmpty
            ? Container(
                //     padding: const EdgeInsets.all(12.0),
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.white, width: 1),
                ),
                child: ListTile(
                  title: AutoSizeText(
                    "You don't currently have any mutual friends with ${friend.username}",
                    style: kTextFormFieldStyle.copyWith(
                        color: kSystemPrimaryColor,
                        fontSize: 15,
                        fontWeight: FontWeight.w100),
                    maxLines: 3,
                  ),
                  subtitle: AutoSizeText(
                    "Click on the icon to add friends from your contacts",
                    style: kTextFormFieldStyle.copyWith(
                        fontWeight: FontWeight.w100),
                  ),
                  trailing: GestureDetector(
                    onTap: () {
                      showDialog(
                        context: context,
                        builder: (context) {
                          return SafeArea(
                            child: BackdropFilter(
                                filter: ImageFilter.blur(
                                    sigmaX: ksigmaX, sigmaY: ksigmaY),
                                child: AlertDialog(
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(20.0)),
                                    backgroundColor: Colors.black45,
                                    content: Container(
                                      height:
                                          MediaQuery.of(context).size.height *
                                              .65,
                                      width: MediaQuery.of(context).size.width,
                                      child: ContactsDialog(),
                                    ))),
                          );
                        },
                      );
                    },
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Icon(
                          Icons.add,
                          color: Colors.white,
                        ),
                        Icon(
                          Icons.people,
                          color: Colors.white,
                        )
                      ],
                    ),
                  ),
                ),
              )
            : ListView.builder(
                itemCount: friend.mutualFriendsIDs.length,
                scrollDirection: Axis.vertical,
                shrinkWrap: true,
                itemBuilder: (context, index) {
                  List<FriendsData> mutualFriends =
                      getMutualFriendsData(friends, friend.mutualFriendsIDs);
                  return ListTile(
                    dense: true,
                    title: AutoSizeText(mutualFriends[index].displayName,
                        style: kTextFormFieldStyle.copyWith(
                            fontSize: 15, fontWeight: FontWeight.normal)),
                    trailing: Text("Score ${mutualFriends[index].score}",
                        style: kTextFormFieldStyle.copyWith(
                            fontSize: 12, fontWeight: FontWeight.normal)),
                  );
                },
              ),
      ],
    );
  }
}
