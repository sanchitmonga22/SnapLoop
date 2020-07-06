import 'package:SnapLoop/Model/loop.dart';
import 'package:SnapLoop/Screens/Chat/LoopDetailsScreen.dart';
import 'package:SnapLoop/Screens/Chat/messages.dart';
import 'package:SnapLoop/Screens/Chat/newMessage.dart';
import 'package:SnapLoop/Screens/Home/LoopWidget/loopWidget.dart';
import 'package:SnapLoop/constants.dart';
import 'package:flutter/material.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';

/// author: @sanchitmonga22

class ExistingLoopChatScreen extends StatefulWidget {
  static const routeName = "/ExisitingLoop";
  ExistingLoopChatScreen(
      {Key key,
      this.loopID = "",
      this.radius,
      this.loopType = LoopType.EXISTING_LOOP,
      this.numberOfMembers,
      this.loopName = ""})
      : super(key: key);
  final String loopID;
  final loopType;
  final int numberOfMembers;
  final String loopName;
  final double radius;

  @override
  _ExistingLoopChatScreenState createState() => _ExistingLoopChatScreenState();
}

class _ExistingLoopChatScreenState extends State<ExistingLoopChatScreen>
    with AutomaticKeepAliveClientMixin<ExistingLoopChatScreen> {
  @override
  bool get wantKeepAlive => true;

  Widget getChatWidget(Color backgroundColor) {
    return Container(
        decoration: BoxDecoration(color: backgroundColor.withOpacity(0.4)),
        child: Stack(
          children: [
            Column(
              children: [Messages(), NewMessage()],
            )
          ],
        ));
  }

  @override
  Widget build(BuildContext context) {
    Color backgroundColor = determineLoopColor(widget.loopType);
    LoopWidget loopWidget = LoopWidget(
      isTappable: false,
      loopName: widget.loopName,
      numberOfMembers: widget.numberOfMembers,
      radius: widget.radius,
      type: widget.loopType,
      flipOnTouch: false,
    );
    super.build(context);
    return LoopsDetailsScreen(
      backgroundColor: backgroundColor,
      chatWidget: getChatWidget(backgroundColor),
      loopWidget: loopWidget,
    );
  }
}
