import 'dart:ui';

import 'package:SnapLoop/Provider/LoopsProvider.dart';
import 'package:SnapLoop/Screens/Home/AppBarData.dart';
import 'package:SnapLoop/Screens/constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';
import 'package:provider/provider.dart';
import 'FloatingActionButton.dart';

/// author: @sanchitmonga22
class HomeScreen extends StatefulWidget {
  static const routeName = '/homeScreen';

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>
    with TickerProviderStateMixin, AutomaticKeepAliveClientMixin<HomeScreen> {
  @override
  bool get wantKeepAlive => true;
  @override
  Widget build(BuildContext context) {
    super.build(context);
    MediaQueryData size = MediaQuery.of(context);
    final List<Widget> loopWidgets = Provider.of<LoopsProvider>(context)
        .loopBuilder((size.size.width) * 0.25);
    return Container(
        decoration: kHomeScreenBoxDecoration,
        child: Stack(children: [
          loopWidgets == null || loopWidgets.length == 0
              ? Center(
                  child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Text(
                      "There are currently no active loops, Please start new loops to show up here!",
                      style: kTextStyleHomeScreen,
                    ),
                  ),
                )
              : ListView.builder(
                  itemBuilder: (_, index) {
                    return loopWidgets[index];
                  },
                  itemCount: loopWidgets.length)
        ]));
  }
}
