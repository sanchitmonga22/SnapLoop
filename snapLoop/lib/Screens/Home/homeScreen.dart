import 'package:SnapLoop/Screens/Home/AppBarData.dart';
import 'package:SnapLoop/Screens/Home/createLoopDialog.dart';
import 'package:SnapLoop/Screens/constants.dart';
import 'package:floating_action_bubble/floating_action_bubble.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:persistent_bottom_nav_bar/models/persistent-nav-bar-scaffold.widget.dart';
import 'loopWidgetContainer.dart';

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
        floatingActionButton: FloatingActionBubble(
          backGroundColor: Colors.deepPurple,
          items: <Bubble>[
            Bubble(
              title: "New Loop",
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
              title: "Friend",
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
          onPress: () => _animationController.isCompleted
              ? _animationController.reverse()
              : _animationController.forward(),
          iconColor: Colors.green,
          animatedIconData: AnimatedIcons.ellipsis_search,
        ),
        body: GestureDetector(
          onHorizontalDragUpdate: (details) {
            // swiping right
            if (details.delta.dx < -kSwipeConstant) {
              widget.controller.jumpToTab(1);
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
