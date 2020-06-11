import 'package:flutter/material.dart';
import 'package:SnapLoop/Provider/LoopsProvider.dart';
import 'package:provider/provider.dart';

class LoopWidgetContainer extends StatefulWidget {
  final double maxRadius;
  final bool isInactive;
  const LoopWidgetContainer({this.maxRadius, this.isInactive});

  @override
  _LoopWidgetContainerState createState() => _LoopWidgetContainerState();
}

class _LoopWidgetContainerState extends State<LoopWidgetContainer> {
  @override
  Widget build(BuildContext context) {
    final List<Widget> inactiveLoops = Provider.of<LoopsProvider>(context)
        .completedLoopBuilder(widget.maxRadius);
    final List<Widget> loopWidgets =
        Provider.of<LoopsProvider>(context).loopBuilder(widget.maxRadius);

    return Container(
      color: Colors.grey[300],
      child: Stack(children: [
        widget.isInactive
            ? ListView.builder(
                itemBuilder: (_, index) {
                  return inactiveLoops[index];
                },
                itemCount: inactiveLoops.length)
            : ListView.builder(
                itemBuilder: (_, index) {
                  return loopWidgets[index];
                },
                itemCount: loopWidgets.length),
      ]),
    );
  }
}
