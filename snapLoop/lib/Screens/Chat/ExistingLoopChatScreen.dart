import 'package:SnapLoop/Model/loop.dart';
import 'package:SnapLoop/Screens/Chat/messages.dart';
import 'package:SnapLoop/Screens/Chat/newMessages.dart';
import 'package:SnapLoop/Screens/constants.dart';
import 'package:flutter/material.dart';

/// author: @sanchitmonga22

class ExistingLoopChatScreen extends StatefulWidget {
  static const routeName = "/ExisitingLoop";
  ExistingLoopChatScreen(
      {Key key,
      this.loopID = "",
      this.loopType = LoopType.EXISTING_LOOP,
      this.numberOfMembers,
      this.memojiWidget,
      this.loopName = ""})
      : super(key: key);
  final String loopID;
  final loopType;
  final int numberOfMembers;
  final String loopName;
  final Widget memojiWidget;

  @override
  _ExistingLoopChatScreenState createState() => _ExistingLoopChatScreenState();
}

class _ExistingLoopChatScreenState extends State<ExistingLoopChatScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          backgroundColor: Colors.black,
          title: Container(
            decoration: BoxDecoration(
                shape: BoxShape.circle,
                boxShadow: [BoxShadow(offset: Offset(1, 1))]),
            child: CircleAvatar(),
          ),
        ),
        body: Stack(
          children: [
            Container(
              decoration: BoxDecoration(
                  color: determineLoopColor(widget.loopType).withOpacity(0.5)),
            ),
            Container(
              alignment: Alignment.center,
              width: (MediaQuery.of(context).size.width / 4) *
                          widget.numberOfMembers >
                      13
                  ? (kfixedRadiusFactor["MAX"] + 400)
                  : (kfixedRadiusFactor[widget.numberOfMembers]),
              height: (MediaQuery.of(context).size.width / 4) *
                          widget.numberOfMembers >
                      13
                  ? (kfixedRadiusFactor["MAX"] + 450)
                  : (kfixedRadiusFactor[widget.numberOfMembers]),

              margin: EdgeInsets.all(80),
              child: Hero(
                // to avoid pixel overflow
                // flightShuttleBuilder: (
                //   BuildContext flightContext,
                //   Animation<double> animation,
                //   HeroFlightDirection flightDirection,
                //   BuildContext fromHeroContext,
                //   BuildContext toHeroContext,
                // ) {
                //   return SingleChildScrollView(
                //     child: fromHeroContext.widget,
                //   );
                // },
                // will use the unique id of the loop
                tag: widget.loopName,
                child: Center(
                  child: widget.memojiWidget,
                ),
              ),
              //Expanded(child: Messages()),
              //NewMessage(),
            ),
            Container(
              decoration: BoxDecoration(color: Colors.transparent),
            )
          ],
        ));
  }
}
