import 'dart:ui';

import 'package:SnapLoop/Screens/constants.dart';
import 'package:flappy_search_bar/flappy_search_bar.dart';
import 'package:flappy_search_bar/search_bar_style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

class FriendsScreen extends StatefulWidget {
  FriendsScreen({Key key}) : super(key: key);
  static const routeName = "/FriendsScreen";

  @override
  _FriendsScreenState createState() => _FriendsScreenState();
}

class _FriendsScreenState extends State<FriendsScreen> {
  SearchBarController _controller = SearchBarController();
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: Container(
        child: Stack(
          children: [
            Align(
              alignment: Alignment(1.05, -0.95),
              child: GestureDetector(
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
                                borderRadius: BorderRadius.circular(20.0)),
                            backgroundColor: Colors.black45,
                            content: Container(
                              height: MediaQuery.of(context).size.height * .65,
                              width: MediaQuery.of(context).size.width,
                              child: ListView(
                                children: [
                                  Slidable.builder(
                                    key: UniqueKey(),
                                    dismissal: SlidableDismissal(
                                      child: SlidableDrawerDismissal(),
                                      onDismissed: (actionType) {
                                        if (actionType ==
                                            SlideActionType.primary) {
                                          print(actionType.index);
                                          // accept the request
                                        } else if (actionType ==
                                            SlideActionType.secondary) {
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
                                              color: Colors.white70,
                                              fontSize: 10),
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
                                          style: kTextFormFieldStyle.copyWith(
                                              fontSize: 15),
                                        ),
                                        trailing: Text(
                                          "Score:250",
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 10),
                                        ),
                                      ),
                                    ),

                                    // actions: <Widget>[
                                    //   IconSlideAction(
                                    //     caption: 'Accept',
                                    //     color: Colors.green,
                                    //     icon: Icons.add,
                                    //     onTap: () {},
                                    //   ),
                                    // ],
                                    // secondaryActions: <Widget>[
                                    //   IconSlideAction(
                                    //     caption: 'Delete',
                                    //     color: Colors.red,
                                    //     icon: Icons.delete,
                                    //     onTap: () {},
                                    //   ),
                                    // ],
                                  ),
                                  Slidable(
                                    key: UniqueKey(),
                                    dismissal: SlidableDismissal(
                                      child: SlidableDrawerDismissal(),
                                      onDismissed: (actionType) {
                                        if (actionType ==
                                            SlideActionType.primary) {
                                          print(actionType.index);
                                          // accept the request
                                        } else if (actionType ==
                                            SlideActionType.secondary) {
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
                                          "sanchit12322monga@gmail.com",
                                          style: kTextFormFieldStyle.copyWith(
                                              color: Colors.white70,
                                              fontSize: 10),
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
                                          "sanchit12322tmonga",
                                          style: kTextFormFieldStyle.copyWith(
                                              fontSize: 15),
                                        ),
                                        trailing: Text(
                                          "Score:2500",
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 10),
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
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                  );
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
                    print('pressed');
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
                headerPadding: EdgeInsets.all(15),
                hintStyle: kTextFormFieldStyle.copyWith(color: Colors.white70),
                textStyle: kTextFormFieldStyle,
                searchBarController: _controller,
                //searchBarPadding: EdgeInsets.all(10),
                hintText: "Enter here",
                iconActiveColor: Colors.white,
                buildSuggestion: (item, index) {},
                onItemFound: (item, index) {},
                onSearch: (text) {},
              ),
            ),
          ],
        ),
      ),
    );
  }
}
