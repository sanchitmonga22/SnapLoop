import 'package:flutter/material.dart';
import 'loopWidgetContainer.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
      title: Text("SnapLoop"),
      actions: <Widget>[
        Column(
          children: <Widget>[
            LoopWidgetContainer(),
          ],
        )
      ],
    ));
  }
}
