import 'package:SnapLoop/Screens/constants.dart';
import 'package:flutter/material.dart';
import 'package:SnapLoop/Provider/LoopsProvider.dart';
import 'package:provider/provider.dart';

/// author: @sanchitmonga22
class LoopWidgetContainer extends StatefulWidget {
  final double maxRadius;
  final bool isInactive;
  const LoopWidgetContainer({this.maxRadius, this.isInactive});

  @override
  _LoopWidgetContainerState createState() => _LoopWidgetContainerState();
}

class _LoopWidgetContainerState extends State<LoopWidgetContainer>
    with AutomaticKeepAliveClientMixin<LoopWidgetContainer> {
  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    final List<Widget> inactiveLoops = Provider.of<LoopsProvider>(context)
        .completedLoopBuilder(widget.maxRadius);
    final List<Widget> loopWidgets =
        Provider.of<LoopsProvider>(context).loopBuilder(widget.maxRadius);
    return Container(
      decoration: kHomeScreenBoxDecoration,
      child: Stack(children: [
        widget.isInactive
            ? inactiveLoops == null || inactiveLoops.length == 0
                ? Center(
                    child: Text(
                    "There are no inactive loops available yet, \n once you are part of a successfully completed loop it will show up here!",
                    style: kTextStyleHomeScreen,
                  ))
                : ListView.builder(
                    itemBuilder: (_, index) {
                      return inactiveLoops[index];
                    },
                    itemCount: inactiveLoops.length)
            : loopWidgets == null || loopWidgets.length == 0
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
                    itemCount: loopWidgets.length),
      ]),
    );
  }
}
