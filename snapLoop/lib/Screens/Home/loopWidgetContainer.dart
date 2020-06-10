import 'package:SnapLoop/Screens/Home/loopWidget.dart';
import 'package:flutter/material.dart';
import 'dart:math';
import 'package:SnapLoop/Provider/LoopsProvider.dart';
import 'package:provider/provider.dart';

class LoopWidgetContainer extends StatefulWidget {
  final maxRadius;
  const LoopWidgetContainer({this.maxRadius});
  // TODO Will accept the list that will contain all the loops
  //  that are to be rendered on the screen
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
    final List<Widget> loopWidgets =
        Provider.of<LoopsProvider>(context).loopBuilder(widget.maxRadius);
    print('LoopWidgets');
    print(loopWidgets);
    return Container(
      padding: EdgeInsets.all(5),
      child: Stack(children: [
        ListView.builder(
            itemBuilder: (_, index) {
              return loopWidgets[index];
            },
            itemCount: loopWidgets.length),
      ]),
    );
  }
}
