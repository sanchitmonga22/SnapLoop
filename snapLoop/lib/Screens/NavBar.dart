import 'package:SnapLoop/Screens/Contacts/ContactsScreen.dart';
import 'package:SnapLoop/Screens/Home/homeScreen.dart';
import 'package:SnapLoop/Screens/UserProfile/userProfile.dart';
import 'package:SnapLoop/Screens/constants.dart';
import 'package:flutter/material.dart';
import 'package:persistent_bottom_nav_bar/models/persisten-bottom-nav-item.widget.dart';
import 'package:persistent_bottom_nav_bar/models/persistent-bottom-nav-bar-styles.widget.dart';
import 'package:persistent_bottom_nav_bar/models/persistent-nav-bar-scaffold.widget.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.widget.dart';

/// author:@sanchitmonga22
class NavBar extends StatefulWidget {
  NavBar({Key key}) : super(key: key);
  static const routeName = "/NavBar";

  @override
  _NavBarState createState() => _NavBarState();
}

class _NavBarState extends State<NavBar> with SingleTickerProviderStateMixin {
  PersistentTabController _controller;

  @override
  void initState() {
    super.initState();
    _controller = PersistentTabController(initialIndex: 0);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  List<Widget> _buildScreens() {
    return [
      HomeScreen(
        persistentTabController: _controller,
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
