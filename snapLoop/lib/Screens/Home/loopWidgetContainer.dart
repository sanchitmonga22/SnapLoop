import 'package:SnapLoop/Screens/Home/loopWidget.dart';
import 'package:align_positioned/align_positioned.dart';
import 'package:flutter/material.dart';
import 'dart:math';

class LoopWidgetContainer extends StatefulWidget {
  LoopWidgetContainer({Key key}) : super(key: key);
  int numberOfLoops = 10;
  @override
  _LoopWidgetContainerState createState() => _LoopWidgetContainerState();
}

double random(double minimum, double maximum) {
  var rng = new Random();
  return minimum + (rng.nextDouble() * maximum);
}

class _LoopWidgetContainerState extends State<LoopWidgetContainer> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: ListView.builder(
          itemBuilder: (context, index) {
            return Container(
              height: 100,
              child: AlignPositioned(
                  moveByChildHeight: random(-1, 1),
                  moveByChildWidth: random(-1, 2),
                  child: LoopWidget(radius: random(1, 10) * 10)),
            );
          },
          itemCount: widget.numberOfLoops),
    );
  }
}
