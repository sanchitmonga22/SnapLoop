import 'package:SnapLoop/Screens/Contacts/ContactsDialog.dart';
import 'package:SnapLoop/Screens/Contacts/FriendRequestDialog.dart';
import 'package:SnapLoop/Screens/constants.dart';
import 'package:flappy_search_bar/flappy_search_bar.dart';
import 'package:flappy_search_bar/search_bar_style.dart';
import 'package:flutter/material.dart';

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
                      return FriendRequestsDialog();
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
                    showDialog(
                      context: context,
                      builder: (context) {
                        return ContactsDialog();
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
