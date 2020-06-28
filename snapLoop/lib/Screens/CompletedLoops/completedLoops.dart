import 'package:SnapLoop/Screens/Home/loopWidgetContainer.dart';
import 'package:SnapLoop/Screens/constants.dart';
import 'package:flutter/material.dart';

///author: @sanchitmonga22

class CompletedLoopsScreen extends StatelessWidget {
  static const routeName = '/completedLoopsScreen';
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
            child: Container(
                decoration: kHomeScreenBoxDecoration,
                child: LoopWidgetContainer(
                  maxRadius: (size.size.width) / 4,
                  isInactive: true,
                )),
          ),
        ]));
  }
}
