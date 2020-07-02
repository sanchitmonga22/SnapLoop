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
      this.loopName = ""})
      : super(key: key);
  final String loopID;
  final loopType;
  final String loopName;

  @override
  _ExistingLoopChatScreenState createState() => _ExistingLoopChatScreenState();
}

class _ExistingLoopChatScreenState extends State<ExistingLoopChatScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Hero(
            // to avoid pixel overflow
            flightShuttleBuilder: (
              BuildContext flightContext,
              Animation<double> animation,
              HeroFlightDirection flightDirection,
              BuildContext fromHeroContext,
              BuildContext toHeroContext,
            ) {
              return SingleChildScrollView(
                child: fromHeroContext.widget,
              );
            },
            tag: widget.loopName,
            child: CircleAvatar(
              backgroundColor:
                  determineLoopColor(widget.loopType).withOpacity(0.5),
            ),
          ),
        ),
        body: Container(
          child: Column(
            children: [
              Center(
                child: Text("Hello"),
              )
              //Expanded(child: Messages()),
              //NewMessage(),
            ],
          ),
        ));
  }
}
