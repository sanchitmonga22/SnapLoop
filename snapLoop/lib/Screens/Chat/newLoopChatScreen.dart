import 'package:SnapLoop/Model/loop.dart';
import 'package:SnapLoop/Model/user.dart';
import 'package:SnapLoop/Screens/Chat/LoopDetailsScreen.dart';
import 'package:SnapLoop/Screens/Chat/newMessage.dart';
import 'package:SnapLoop/Screens/Home/LoopWidget/loopWidget.dart';
import 'package:SnapLoop/constants.dart';
import 'package:flutter/material.dart';

/// author: @sanchitmonga22

class NewLoopChatScreen extends StatefulWidget {
  NewLoopChatScreen({Key key}) : super(key: key);
  static const routeName = "/NewLoopChatScreen";
  @override
  _NewLoopChatScreenState createState() => _NewLoopChatScreenState();
}

class _NewLoopChatScreenState extends State<NewLoopChatScreen> {
  double radius = 0;

  @override
  Widget build(BuildContext context) {
    Color backgroundColor = determineLoopColor(LoopType.EXISTING_LOOP);
    radius = MediaQuery.of(context).size.width * 0.25 * kfixedRadiusFactor[2];
    final args =
        ModalRoute.of(context).settings.arguments as Map<String, dynamic>;
    final loopName = args["loopName"] as String;
    final userData = args["friend"] as FriendsData;
    Loop loop = new Loop(
        chatID: "",
        creatorId: "",
        id: "",
        name: loopName,
        numberOfMembers: 2,
        type: LoopType.NEW_LOOP,
        userIDs: ["", ""]);
    LoopWidget loopWidget = LoopWidget(
      isTappable: false,
      radius: radius,
      flipOnTouch: false,
      loop: loop,
    );

    Widget chatWidget = Container(
      decoration: BoxDecoration(color: backgroundColor),
      child: Column(
        children: [
          Expanded(child: Container()),
          NewMessage(),
        ],
      ),
    );

    return LoopsDetailsScreen(
      backgroundColor: backgroundColor,
      chatWidget: chatWidget,
      loopWidget: loopWidget,
    );
  }
}
