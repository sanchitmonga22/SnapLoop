import 'package:SnapLoop/Screens/Home/loopWidgetContainer.dart';
import 'package:SnapLoop/Screens/constants.dart';
import 'package:flutter/material.dart';
import 'package:persistent_bottom_nav_bar/models/persistent-nav-bar-scaffold.widget.dart';

///author: @sanchitmonga22

class CompletedLoopsScreen extends StatelessWidget {
  static const routeName = '/completedLoopsScreen';
  final PersistentTabController controller;
  CompletedLoopsScreen({this.controller = null});

  @override
  Widget build(BuildContext context) {
    MediaQueryData size = MediaQuery.of(context);
    return Scaffold(
        appBar: AppBar(
          title: Text("SnapLoop"),
          centerTitle: true,
        ),
        body: Column(children: <Widget>[
          Expanded(
            child: GestureDetector(
              onHorizontalDragUpdate: (details) {
                if (details.delta.dx > kSwipeConstant) {
                  controller.jumpToTab(0);
                } else if (details.delta.dx < -kSwipeConstant) {
                  controller.jumpToTab(2);
                }
              },
              child: Container(
                  decoration: kHomeScreenBoxDecoration,
                  child: LoopWidgetContainer(
                    maxRadius: (size.size.width) / 4,
                    isInactive: true,
                  )),
            ),
          ),
        ]));
  }
}
