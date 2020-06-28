import 'package:SnapLoop/Screens/Chat/messages.dart';
import 'package:SnapLoop/Screens/Chat/newMessages.dart';
import 'package:flutter/material.dart';

/**
 * author: @sanchitmonga22
 */
class ExistingLoopChatScreen extends StatefulWidget {
  ExistingLoopChatScreen({Key key}) : super(key: key);

  @override
  _ExistingLoopChatScreenState createState() => _ExistingLoopChatScreenState();
}

class _ExistingLoopChatScreenState extends State<ExistingLoopChatScreen> {
  @override
  Widget build(BuildContext context) {
    final loopName = "";
    return Scaffold(
        appBar: AppBar(title: Text(loopName)),
        body: Column(
          children: [
            Expanded(child: Messages()),
            NewMessage(),
          ],
        ));
  }
}
