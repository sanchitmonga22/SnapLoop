import 'dart:ui';
import 'package:SnapLoop/Screens/Contacts/ContactsScreen.dart';
import 'package:SnapLoop/Screens/Home/homeScreen.dart';
import 'package:SnapLoop/Screens/UserProfile/userProfile.dart';
import 'package:SnapLoop/Screens/constants.dart';
import 'package:flutter/material.dart';
import 'package:persistent_bottom_nav_bar/models/persisten-bottom-nav-item.widget.dart';
import 'package:persistent_bottom_nav_bar/models/persistent-bottom-nav-bar-styles.widget.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';
import 'package:provider/provider.dart';

import 'Home/AppBarData.dart';
import 'FloatingActionButton.dart';

/// author:@sanchitmonga22
class NavBar extends StatefulWidget {
  NavBar({Key key}) : super(key: key);
  static const routeName = "/NavBar";

  @override
  _NavBarState createState() => _NavBarState();
}

class _NavBarState extends State<NavBar>
    with TickerProviderStateMixin, AutomaticKeepAliveClientMixin<NavBar> {
  TabController _tabController;
  Animation<double> _floatingBubbleAnimation;
  AnimationController _floatingBubbleAnimationController;

  @override
  void initState() {
    super.initState();
    _floatingBubbleAnimationController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 260),
    );
    final curvedAnimation = CurvedAnimation(
        curve: Curves.easeInOut, parent: _floatingBubbleAnimationController);
    _floatingBubbleAnimation =
        Tween<double>(begin: 0, end: 1).animate(curvedAnimation);
    _tabController = TabController(vsync: this, length: 4);
  }

  List<Widget> getChildren() {
    return [
      HomeScreen(
        completedLoopsScreen: false,
      ),
      HomeScreen(
        completedLoopsScreen: true,
      ),
      ContactScreen(),
      UserProfile()
    ];
  }

  List<PersistentBottomNavBarItem> _navBarsItems() {
    return [
      PersistentBottomNavBarItem(
        icon: Icon(CupertinoIcons.loop_thick),
        title: ("Home"),
        activeColor: kActiveNavBarIconColor,
        inactiveColor: kInactiveNavBarIconColor,
      ),
      PersistentBottomNavBarItem(
        icon: Icon(Icons.contacts),
        title: ("Contacts"),
        activeColor: kActiveNavBarIconColor,
        inactiveColor: kInactiveNavBarIconColor,
      ),
      PersistentBottomNavBarItem(
        icon: Icon(Icons.person),
        title: ("Profile"),
        activeColor: kActiveNavBarIconColor,
        inactiveColor: kInactiveNavBarIconColor,
      ),
    ];
  }

  @override
  void dispose() {
    super.dispose();
    _tabController.dispose();
    _floatingBubbleAnimationController.dispose();
  }

  void _toggleTab(int index) {
    _tabController.animateTo(index);
  }

  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    if (_tabController.index > 1) {}

    super.build(context);
    return SafeArea(
        child: Scaffold(
            resizeToAvoidBottomPadding:
                false, // IMPORTANT: to avoid bottom overflow for the create a loop dialog
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
              animationController: _floatingBubbleAnimationController,
              animation: _floatingBubbleAnimation,
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
                if (_floatingBubbleAnimationController.isCompleted) {
                  Provider.of<FloatingActionButtonDataChanges>(context,
                          listen: false)
                      .toggleIsTapped();
                  _floatingBubbleAnimationController.reverse();
                }
              },
              child: Consumer<FloatingActionButtonDataChanges>(
                builder: (context, value, child) {
                  return Stack(
                    children: [
                      child,
                      value.isTapped &&
                              !_floatingBubbleAnimationController.isCompleted
                          ? Container(
                              width: double.infinity,
                              child: BackdropFilter(
                                filter: ImageFilter.blur(
                                    sigmaX: ksigmaX, sigmaY: ksigmaY),
                                child: Container(
                                  color: Colors.black.withOpacity(kopacity),
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
                child: TabBarView(
                  physics: NeverScrollableScrollPhysics(),
                  children: getChildren(),
                  controller: _tabController,
                ),
              ),
            ),
            bottomNavigationBar: PersistentBottomNavBar(
              items: _navBarsItems(),
              onItemSelected: (value) {
                if (value > 0) {
                  value++;
                }
                setState(() {
                  if (_floatingBubbleAnimationController.isCompleted) {
                    Provider.of<FloatingActionButtonDataChanges>(context,
                            listen: false)
                        .toggleIsTapped();
                    _floatingBubbleAnimationController.reverse();
                  }
                  _toggleTab(value);
                });
              },
              navBarHeight: 70,
              navBarStyle: NavBarStyle.style2,
              iconSize: 26,
              selectedIndex:
                  _tabController.index > 0 ? _tabController.index - 1 : 0,
              backgroundColor: Colors.black,
              popScreensOnTapOfSelectedTab: false,
              showElevation: true,
            )));
  }
}
