import 'dart:ui';

import 'package:SnapLoop/Model/loop.dart';
import 'package:SnapLoop/Model/user.dart';
import 'package:SnapLoop/Provider/LoopsProvider.dart';
import 'package:SnapLoop/Provider/UserDataProvider.dart';
import 'package:SnapLoop/Screens/Contacts/ContactsDialog.dart';
import 'package:SnapLoop/Screens/Contacts/FriendRequestDialog.dart';
import 'package:SnapLoop/constants.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flappy_search_bar/flappy_search_bar.dart';
import 'package:flappy_search_bar/search_bar_style.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class FriendsScreen extends StatefulWidget {
  FriendsScreen({Key key}) : super(key: key);
  static const routeName = "/FriendsScreen";

  @override
  _FriendsScreenState createState() => _FriendsScreenState();
}

void createADialog(BuildContext context, bool requests) {
  showDialog(
    context: context,
    builder: (context) {
      return SafeArea(
          child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: ksigmaX, sigmaY: ksigmaY),
              child: AlertDialog(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20.0)),
                  backgroundColor: Colors.black45,
                  content: Container(
                    height: MediaQuery.of(context).size.height * .65,
                    width: MediaQuery.of(context).size.width,
                    child: requests ? FriendRequestsDialog() : ContactsDialog(),
                  ))));
    },
  );
}

class _FriendsScreenState extends State<FriendsScreen> {
  SearchBarController _controller = SearchBarController();
  bool contactOpened = false;

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
    List<Loop> friendsLoops = [];
    List<FriendsData> friends = Provider.of<UserDataProvider>(context).friends;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: Container(
        child: Stack(
          children: [
            Align(
              alignment: Alignment(1.05, -0.95),
              child: GestureDetector(
                onTap: () {
                  createADialog(context, true);
                },
                child: CircleAvatar(
                  backgroundColor: Colors.black,
                  child: Stack(
                    children: [
                      Align(
                        alignment: Alignment(0, 0),
                        child: Icon(
                          Icons.person,
                          color: Colors.white,
                        ),
                      ),
                      Align(
                        alignment: Alignment(1, -1.5),
                        child: CircleAvatar(
                          radius: 11,
                          // add the number of current requests received
                          child: Text("15"),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
            //added a new field cursorColor in the package code.
            //added a new field suffix which contains the widget, and added the TextAlignVertical to TextAlignVertical.center
            Container(
              padding: EdgeInsets.only(right: 35),
              child: SearchBar(
                suffix: GestureDetector(
                  onTap: () {
                    createADialog(context, false);
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
                cursorColor: Colors.white,
                searchBarStyle: SearchBarStyle(
                  padding: EdgeInsets.only(left: 25),
                  backgroundColor: kSystemPrimaryColor,
                  borderRadius: BorderRadius.circular(15),
                ),
                icon: Icon(Icons.search),
                hintStyle: kTextFormFieldStyle.copyWith(color: Colors.white70),
                textStyle: kTextFormFieldStyle,
                searchBarController: _controller,
                //searchBarPadding: EdgeInsets.all(10),
                hintText: "Enter here",
                iconActiveColor: Colors.white,
                buildSuggestion: (item, index) {},
                onItemFound: (item, index) {},
                onSearch: (text) {},
                placeHolder: ListView.builder(
                  itemCount: friends.length,
                  itemBuilder: (context, index) {
                    FriendsData friend = friends[index];
                    friendsLoops =
                        Provider.of<LoopsProvider>(context, listen: false)
                            .getLoopInforById(friend.commonLoops);

                    return ExpansionTile(
                      backgroundColor: Colors.black,
                      maintainState: true,
                      title: Text(
                        friend.displayName,
                        style: kTextFormFieldStyle.copyWith(
                            fontWeight: FontWeight.bold,
                            color: kSystemPrimaryColor),
                      ),
                      leading: CircleAvatar(
                        child: friend.avatar ?? Icon(Icons.person),
                        backgroundColor: kSystemPrimaryColor,
                      ),
                      trailing: Text(
                        "Score: ${friend.score}",
                        style: kTextFormFieldStyle.copyWith(
                            color: kSystemPrimaryColor),
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
                                      fontWeight: FontWeight.w600,
                                      fontSize: 15),
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
                                ExpansionTile(
                                  title: Text(
                                    "Common Loops",
                                    style: kTextFormFieldStyle.copyWith(
                                        fontWeight: FontWeight.normal),
                                  ),
                                  children: [
                                    friendsLoops.isEmpty
                                        ? Container(
                                            decoration: BoxDecoration(
                                              border: Border.all(
                                                  color: Colors.white,
                                                  width: 1),
                                            ),
                                            child: ListTile(
                                              title: AutoSizeText(
                                                "You don't have any loops in common with ${friend.username}.",
                                                style: kTextFormFieldStyle
                                                    .copyWith(
                                                        color:
                                                            kSystemPrimaryColor,
                                                        fontSize: 15,
                                                        fontWeight:
                                                            FontWeight.w100),
                                                maxLines: 3,
                                              ),
                                              subtitle: AutoSizeText(
                                                "Click on the icon to start a new loop with the user!",
                                                style: kTextFormFieldStyle
                                                    .copyWith(
                                                        fontWeight:
                                                            FontWeight.w100),
                                              ),
                                              trailing: GestureDetector(
                                                child: Row(
                                                  mainAxisSize:
                                                      MainAxisSize.min,
                                                  children: [
                                                    Icon(
                                                      CupertinoIcons.loop,
                                                      color: Colors.white,
                                                    ),
                                                    Icon(CupertinoIcons.add,
                                                        color: Colors.white,
                                                        size: 15)
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
                                                    color: determineLoopColor(
                                                            friendsLoops[index]
                                                                .type)
                                                        .withOpacity(0.7)),
                                                child: ListTile(
                                                    dense: true,
                                                    title: Text(
                                                        friendsLoops[index]
                                                            .name,
                                                        style:
                                                            kTextFormFieldStyle)),
                                              );
                                            },
                                          ),
                                  ],
                                ),
                                ExpansionTile(
                                  title: Text(
                                    "Mutual Friends",
                                    style: kTextFormFieldStyle.copyWith(
                                        fontWeight: FontWeight.normal),
                                  ),
                                  children: [
                                    friend.mutualFriendsIDs.isEmpty
                                        ? Container(
                                            padding: const EdgeInsets.all(5.0),
                                            decoration: BoxDecoration(
                                              border: Border.all(
                                                  color: Colors.white,
                                                  width: 1),
                                            ),
                                            child: AutoSizeText(
                                              "You don't currently have any mutual friends with ${friend.username}",
                                              maxLines: 2,
                                              style:
                                                  kTextFormFieldStyle.copyWith(
                                                      color:
                                                          kSystemPrimaryColor,
                                                      fontWeight:
                                                          FontWeight.normal),
                                            ),
                                          )
                                        : ListView.builder(
                                            itemCount:
                                                friend.mutualFriendsIDs.length,
                                            scrollDirection: Axis.vertical,
                                            shrinkWrap: true,
                                            itemBuilder: (context, index) {
                                              List<FriendsData> mutualFriends =
                                                  getMutualFriendsData(friends,
                                                      friend.mutualFriendsIDs);
                                              return ListTile(
                                                dense: true,
                                                title: AutoSizeText(
                                                    mutualFriends[index]
                                                        .displayName,
                                                    style: kTextFormFieldStyle
                                                        .copyWith(
                                                            fontSize: 15,
                                                            fontWeight:
                                                                FontWeight
                                                                    .normal)),
                                                trailing: Text(
                                                    "Score ${mutualFriends[index].score}",
                                                    style: kTextFormFieldStyle
                                                        .copyWith(
                                                            fontSize: 12,
                                                            fontWeight:
                                                                FontWeight
                                                                    .normal)),
                                              );
                                            },
                                          ),
                                  ],
                                ),
                              ]),
                        )
                      ],
                      // children: [
                      //   Row(
                      //     children: [Text()],
                      //   )
                      // ],
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
