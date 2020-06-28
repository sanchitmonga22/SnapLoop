import 'package:SnapLoop/Provider/UserDataProvider.dart';
import 'package:SnapLoop/Screens/constants.dart';
import 'package:flutter/material.dart';
import 'package:persistent_bottom_nav_bar/models/persistent-nav-bar-scaffold.widget.dart';
import 'package:provider/provider.dart';
import 'loopWidgetContainer.dart';

/// author: @sanchitmonga22

class HomeScreen extends StatelessWidget {
  static const routeName = '/homeScreen';
  final PersistentTabController controller;
  HomeScreen({this.controller = null});

  Widget build(BuildContext context) {
    final userDataProvider = Provider.of<UserDataProvider>(context);

    MediaQueryData size = MediaQuery.of(context);
    return Scaffold(
        resizeToAvoidBottomPadding:
            false, // to avoid bottom overflow in the alert dialog box
        appBar: AppBar(
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Score: ${userDataProvider.userScore.toString()}",
                textAlign: TextAlign.left,
                style: kTextStyleHomeScreen,
              ),
              Text(
                "Snap∞Loop",
                style: kTextFormFieldStyle.copyWith(fontSize: 25),
              ),
              GestureDetector(
                onTap: () {},
                child: Container(
                  foregroundDecoration: BoxDecoration(
                      border: Border.all(style: BorderStyle.solid),
                      borderRadius: BorderRadius.circular(10)),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      userDataProvider.displayName,
                      style: kTextStyleHomeScreen,
                    ),
                  ),
                ),
              ),
              // going to the user profile
              // onPressed: () {
              //   Navigator.of(context).pushNamed(UserProfile.routeName);
              // },
            ],
          ),
          centerTitle: true,
          backgroundColor: kAppBarBackgroundColor,
          // backgroundColor: Colors.blueGrey[900],
          //backgroundColor: Color.fromRGBO(74, 20, 140, 1).withOpacity(0.8),
        ),
        body: GestureDetector(
          onHorizontalDragUpdate: (details) {
            // swiping right
            if (details.delta.dx < -kSwipeConstant) {
              controller.jumpToTab(1);
            }
          },
          child: Container(
            decoration: kHomeScreenBoxDecoration,
            child: Column(
              children: <Widget>[
                Container(
                  height: size.size.height * 0.75,
                  child: LoopWidgetContainer(
                    maxRadius: (size.size.width) * 0.25,
                    isInactive: false,
                  ),
                ),
                //BottomButtonsWidget()
              ],
            ),
          ),
        ));
  }
}
