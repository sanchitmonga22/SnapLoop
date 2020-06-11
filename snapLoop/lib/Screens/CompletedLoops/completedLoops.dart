import 'package:SnapLoop/Screens/Home/loopWidgetContainer.dart';
import 'package:flutter/material.dart';

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
                child: LoopWidgetContainer(
              maxRadius: (size.size.width) / 4,
              isInactive: true,
            )),
          ),
        ]));
  }
}
