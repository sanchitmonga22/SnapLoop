import 'package:SnapLoop/Screens/CompletedLoops/completedLoops.dart';
import 'package:SnapLoop/Screens/Contacts/ContactsScreen.dart';
import 'package:SnapLoop/Screens/Home/homeScreen.dart';
import 'package:SnapLoop/Screens/UserProfile/userProfile.dart';
import 'package:flutter/material.dart';
import 'package:persistent_bottom_nav_bar/models/persisten-bottom-nav-item.widget.dart';
import 'package:persistent_bottom_nav_bar/models/persistent-bottom-nav-bar-styles.widget.dart';
import 'package:persistent_bottom_nav_bar/models/persistent-nav-bar-scaffold.widget.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.widget.dart';

/// author:@sanchitmonga22
class NavBar extends StatefulWidget {
  NavBar({Key key}) : super(key: key);

  @override
  _NavBarState createState() => _NavBarState();
}

class _NavBarState extends State<NavBar> with SingleTickerProviderStateMixin {
  PersistentTabController _controller;
  PageController _pageController;

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
    _controller = PersistentTabController(initialIndex: 0);
  }

  @override
  void dispose() {
    _pageController.dispose();
    _controller.dispose();
    super.dispose();
  }

  List<Widget> _buildScreens() {
    return [
      HomeScreen(
        controller: _controller,
      ),
      CompletedLoopsScreen(controller: _controller),
      ContactScreen(controller: _controller),
      UserProfile(controller: _controller)
    ];
  }

  List<PersistentBottomNavBarItem> _navBarsItems() {
    return [
      PersistentBottomNavBarItem(
        icon: Icon(CupertinoIcons.home),
        title: ("Home"),
        activeColor: CupertinoColors.activeOrange,
        inactiveColor: CupertinoColors.systemGrey,
      ),
      PersistentBottomNavBarItem(
        icon: Icon(CupertinoIcons.loop),
        title: ("CompletedLoops"),
        activeColor: CupertinoColors.activeOrange,
        inactiveColor: CupertinoColors.systemGrey,
      ),
      PersistentBottomNavBarItem(
        icon: Icon(Icons.contacts),
        title: ("Contacts"),
        activeColor: CupertinoColors.activeOrange,
        inactiveColor: CupertinoColors.systemGrey,
      ),
      PersistentBottomNavBarItem(
        icon: Icon(Icons.person),
        title: ("Profile"),
        activeColor: CupertinoColors.activeOrange,
        inactiveColor: CupertinoColors.systemGrey,
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: PersistentTabView(
        controller: _controller,
        items: _navBarsItems(),
        screens: _buildScreens(),
        showElevation: true,
        navBarCurve: NavBarCurve.upperCorners,
        confineInSafeArea: true,
        handleAndroidBackButtonPress: true,
        iconSize: 26.0,
        navBarStyle: NavBarStyle.style2,
        backgroundColor: Colors.black,
        onItemSelected: (value) {},
      ),
    );
  }
}
