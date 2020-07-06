import 'dart:ui';

import 'package:SnapLoop/Model/loop.dart';
import 'package:SnapLoop/Model/user.dart';
import 'package:SnapLoop/Provider/LoopsProvider.dart';
import 'package:SnapLoop/Provider/UserDataProvider.dart';
import 'package:SnapLoop/Screens/Contacts/ContactDetails/ContactsDetailsWidget.dart';
import 'package:SnapLoop/Screens/Contacts/ContactsDialog.dart';
import 'package:SnapLoop/Screens/Contacts/FriendRequestDialog.dart';
import 'package:SnapLoop/constants.dart';
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
                          child: Text(Provider.of<UserDataProvider>(context)
                              .requests
                              .length
                              .toString()),
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
                    return ContactsDetailsWidget(
                      friend: friend,
                      friends: friends,
                      friendsLoops: friendsLoops,
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
