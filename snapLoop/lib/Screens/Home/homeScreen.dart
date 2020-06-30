import 'dart:ui';

import 'package:SnapLoop/Screens/Home/AppBarData.dart';
import 'package:SnapLoop/Screens/constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';
import 'package:provider/provider.dart';
import 'FloatingActionButton.dart';
import 'LoopWidget/loopWidgetContainer.dart';

/// author: @sanchitmonga22
class HomeScreen extends StatefulWidget {
  static const routeName = '/homeScreen';
  final persistentTabController;
  HomeScreen({this.persistentTabController});
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with TickerProviderStateMixin {
  Animation<double> _animation;
  AnimationController _animationController;
  TabController _tabController;
  static const double _sigmaX = 5.0; // from 0-10
  static const double _sigmaY = 5.0; // from 0-10
  static const double _opacity = 0.1;

  @override
  void initState() {
    _animationController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 260),
    );
    _tabController = TabController(vsync: this, length: 2);
    final curvedAnimation =
        CurvedAnimation(curve: Curves.easeInOut, parent: _animationController);
    _animation = Tween<double>(begin: 0, end: 1).animate(curvedAnimation);

    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    _animationController.dispose();
    _tabController.dispose();
  }

  void _toggleTab(int index) {
    _tabController.animateTo(index);
  }

  Widget build(BuildContext context) {
    // when the user clicks on other screens and comes back to the home screen, it is always shown as the Main Screen
    if (widget.persistentTabController.index > 0) {
      _toggleTab(0);
    }

    MediaQueryData size = MediaQuery.of(context);
    return SafeArea(
      child: Scaffold(
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
          floatingActionButton: FloatingActionButtonData(
            animationController: _animationController,
            animation: _animation,
          ),
          body: GestureDetector(
            onHorizontalDragUpdate: (details) {
              // swiping right
              if (details.delta.dx < -kSwipeConstant &&
                  _tabController.index == 0) {
                _toggleTab(1);
              }
              if (details.delta.dx > kSwipeConstant &&
                  _tabController.index == 1) {
                _toggleTab(0);
              }
            },
            onTap: () {
              if (_animationController.isCompleted) {
                Provider.of<FloatingActionButtonDataChanges>(context,
                        listen: false)
                    .toggleIsTapped();
                _animationController.reverse();
              }
            },
            child: Consumer<FloatingActionButtonDataChanges>(
                builder: (context, value, child) {
                  return Stack(
                    children: [
                      child,
                      value.isTapped && !_animationController.isCompleted
                          ? Container(
                              width: double.infinity,
                              child: BackdropFilter(
                                filter: ImageFilter.blur(
                                    sigmaX: _sigmaX, sigmaY: _sigmaY),
                                child: Container(
                                  color: Colors.black.withOpacity(_opacity),
                                ),
                              ),
                            )
                          : Container(
                              padding: EdgeInsets.zero,
                              height: 0,
                              width: 0,
                            )
                    ],
                  );
                },
                child: TabBarView(controller: _tabController, children: [
                  // ACTIVE LOOPS
                  LoopWidgetContainer(
                    maxRadius: (size.size.width) * 0.25,
                    isInactive: false,
                  ),
                  // COMPLETED LOOPS
                  Column(children: <Widget>[
                    Expanded(
                      child: Container(
                          decoration: kHomeScreenBoxDecoration,
                          child: LoopWidgetContainer(
                            maxRadius: (size.size.width) / 4,
                            isInactive: true,
                          )),
                    ),
                  ])
                ])),
          )),
    );
  }
}
