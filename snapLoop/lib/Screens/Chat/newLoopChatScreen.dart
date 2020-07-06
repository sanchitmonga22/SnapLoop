import 'package:SnapLoop/Model/loop.dart';
import 'package:SnapLoop/Model/user.dart';
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
    radius = MediaQuery.of(context).size.width * 0.25 * kfixedRadiusFactor[2];
    final args =
        ModalRoute.of(context).settings.arguments as Map<String, dynamic>;
    final loopName = args["loopName"] as String;
    final userData = args["friend"] as FriendsData;
    return SafeArea(
      child: Scaffold(
          appBar: PreferredSize(
            child: Container(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  LoopWidget(
                    isTappable: false,
                    loopName: loopName,
                    numberOfMembers: 2,
                    radius: radius,
                    type: LoopType.EXISTING_LOOP,
                  ),
                ],
              ),
            ),
            preferredSize: Size.fromHeight(radius * 3),
          ),
          body: Container(
            decoration: BoxDecoration(
                color: determineLoopColor(LoopType.EXISTING_LOOP)),
            child: Column(
              children: [
                Expanded(child: Container()),
                NewMessage(),
              ],
            ),
          )),
    );
  }
}
