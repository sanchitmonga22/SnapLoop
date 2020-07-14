import 'dart:ui';
import 'package:SnapLoop/Model/loop.dart';
import 'package:SnapLoop/Model/user.dart';
import 'package:SnapLoop/Provider/LoopsProvider.dart';
import 'package:SnapLoop/Provider/UserDataProvider.dart';
import 'package:SnapLoop/Screens/Chat/newLoopChatScreen.dart';
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
                ))),
      );
    },
  );
}

class _FriendsScreenState extends State<FriendsScreen>
    with AutomaticKeepAliveClientMixin<FriendsScreen> {
  SearchBarController _controller = SearchBarController();
  bool contactOpened = false;
  bool newLoop = false;
  String loopName = "";

  @override
  bool get wantKeepAlive => true;

  Future<List<dynamic>> getUsers(String email) {
    return Provider.of<UserDataProvider>(context, listen: false)
        .searchByEmail(email);
  }

  @override
  Widget build(BuildContext context) {
    loopName = ModalRoute.of(context).settings.arguments;
    if (loopName != "" && loopName != null) newLoop = true;
    super.build(context);
    List<Loop> friendsLoops = [];
    List<FriendsData> friends = Provider.of<UserDataProvider>(context).friends;
    return Material(
      child: Padding(
        padding: const EdgeInsets.only(right: 10.0, left: 5),
        child: Stack(
          children: [
            newLoop
                ? Container()
                : Align(
                    alignment: Alignment(1.05, -0.95),
                    child: newLoop
                        ? Container()
                        : GestureDetector(
                            onTap: () {
                              createADialog(context, true);
                            },
                            child: Container(
                              padding: EdgeInsets.only(top: 10),
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
                                        child: Text(
                                            Provider.of<UserDataProvider>(
                                                    context)
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
                  ),
            SearchBar(
              minimumChars: 3,
              searchBarPadding: newLoop
                  ? EdgeInsets.only(top: 50)
                  : EdgeInsets.only(right: 35),
              suffix: newLoop
                  ? Row(
                      mainAxisSize: MainAxisSize.min,
                    )
                  : GestureDetector(
                      onTap: () {
                        createADialog(context, false);
                      },
                      child: Container(
                        padding: EdgeInsets.only(right: 10),
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

              // check this
              buildSuggestion: (item, index) {
                print("Hellgersgo");
                return Container(
                  color: Colors.blue,
                  child: ListTile(
                    key: ValueKey(index),
                    title: item.username,
                  ),
                );
              },
              onItemFound: (userData, int index) {
                print("Hello");
                return Container(
                  color: Colors.blue,
                  child: ListTile(
                    key: ValueKey(index),
                    title: Text(userData.username),
                  ),
                );
              },
              loader: CircularProgressIndicator(),
              emptyWidget: Text(
                  "No items found, Please try searching with a different name"),
              onError: (error) {
                print(error);
              },
              onSearch: getUsers,
              placeHolder: friends.length == 0
                  ? Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Center(
                        child: Text(
                          "You don't currently have any friends! please search users above to add them as friend",
                          style:
                              kTextFormFieldStyle.copyWith(color: Colors.black),
                        ),
                      ),
                    )
                  : ListView.builder(
                      itemCount: friends.length,
                      itemBuilder: (context, index) {
                        FriendsData friend = friends[index];
                        friendsLoops =
                            Provider.of<LoopsProvider>(context, listen: false)
                                .getLoopInforById(friend.commonLoops);

                        return ContactsDetailsWidget(
                          onTap: () {
                            Navigator.pushReplacementNamed(
                              context,
                              NewLoopChatScreen.routeName,
                              arguments: {
                                "friend": friend,
                                "loopName": loopName
                              },
                            );
                          },
                          friend: friend,
                          friends: friends,
                          friendsLoops: friendsLoops,
                          newLoop: newLoop,
                          key: ValueKey(index),
                        );
                      },
                    ),
            ),
          ],
        ),
      ),
    );
  }
}
