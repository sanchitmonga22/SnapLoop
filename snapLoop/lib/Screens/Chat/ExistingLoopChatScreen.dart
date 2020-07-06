import 'package:SnapLoop/Model/loop.dart';
import 'package:SnapLoop/Screens/Chat/messages.dart';
import 'package:SnapLoop/Screens/Chat/newMessage.dart';
import 'package:SnapLoop/Screens/Home/LoopWidget/loopWidget.dart';
import 'package:SnapLoop/constants.dart';
import 'package:flutter/material.dart';

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

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return SafeArea(
      child: Scaffold(
          appBar: PreferredSize(
            child: Container(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  LoopWidget(
                    isTappable: false,
                    loopName: widget.loopName,
                    numberOfMembers: widget.numberOfMembers,
                    radius: widget.radius,
                    type: widget.loopType,
                  ),
                ],
              ),
            ),
            preferredSize: Size.fromHeight(widget.radius * 3),
          ),
          body: Stack(
            children: [
              Container(
                decoration: BoxDecoration(
                    color:
                        determineLoopColor(widget.loopType).withOpacity(0.4)),
              ),
              Column(
                children: [Messages(), NewMessage()],
              ),
            ],
          )),
    );
  }
}
