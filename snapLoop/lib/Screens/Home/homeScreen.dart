import 'package:SnapLoop/Screens/Home/AppBarData.dart';
import 'package:SnapLoop/Screens/Home/createLoopDialog.dart';
import 'package:SnapLoop/Screens/constants.dart';
import 'package:floating_action_bubble/floating_action_bubble.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:persistent_bottom_nav_bar/models/persistent-nav-bar-scaffold.widget.dart';
import 'LoopWidget/loopWidgetContainer.dart';

/// author: @sanchitmonga22
class HomeScreen extends StatefulWidget {
  static const routeName = '/homeScreen';

  final PersistentTabController controller;
  HomeScreen({this.controller});

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>
    with SingleTickerProviderStateMixin {
  Animation<double> _animation;
  AnimationController _animationController;

  @override
  void initState() {
    _animationController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 260),
    );

    final curvedAnimation =
        CurvedAnimation(curve: Curves.easeInOut, parent: _animationController);
    _animation = Tween<double>(begin: 0, end: 1).animate(curvedAnimation);

    super.initState();
  }

  Widget build(BuildContext context) {
    MediaQueryData size = MediaQuery.of(context);
    return Scaffold(
        resizeToAvoidBottomPadding:
            false, // to avoid bottom overflow in the alert dialog box
        appBar: AppBar(
          title: AppBarData(),
          centerTitle: true,
          backgroundColor: kAppBarBackgroundColor,
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
        //NOTE FloatingActionBubble modified:
        //Line 39 crossAxisAlignment: CrossAxisAlignment.start,
        //Line 43 Size:35
        floatingActionButton: FloatingActionBubble(
            backGroundColor: Colors.black,
            items: <Bubble>[
              Bubble(
                title: "+",
                iconColor: Colors.white,
                bubbleColor: Colors.black,
                icon: CupertinoIcons.loop,
                titleStyle: kTextStyleHomeScreen,
                onPress: () {
                  _animationController.reverse();
                  showDialog(
                    context: context,
                    builder: (context) {
                      return CreateALoopDialog();
                    },
                  );
                },
              ),
              Bubble(
                title: "+",
                iconColor: Colors.white,
                bubbleColor: Colors.black,
                icon: CupertinoIcons.person_add,
                titleStyle: kTextStyleHomeScreen,
                onPress: () {
                  _animationController.reverse();
                  //TODO: To add a new friend
                },
              ),
            ],
            animation: _animation,
            onPress: () {
              _animationController.isCompleted
                  ? _animationController.reverse()
                  : _animationController.forward();
            },
            iconColor: Colors.white,
            animatedIconData: AnimatedIcons.menu_home),
        body: GestureDetector(
          // if the user taps on the outside of the Bubble then the bubble automatically goes away
          onTap: () {
            if (_animationController.isCompleted)
              _animationController.reverse();
          },
          // if the user swipes horizontally to the left, the screen changes to the Completed Loops Screen
          onHorizontalDragUpdate: (details) {
            // swiping right
            if (details.delta.dx < -kSwipeConstant) {
              widget.controller.jumpToTab(1);
            }
          },
          child: LoopWidgetContainer(
            maxRadius: (size.size.width) * 0.25,
            isInactive: false,
          ),
        ));
  }
}
