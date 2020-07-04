import 'package:SnapLoop/Model/user.dart';
import 'package:SnapLoop/Screens/Chat/newMessages.dart';
import 'package:flutter/material.dart';

/// author: @sanchitmonga22

class NewLoopChatScreen extends StatefulWidget {
  NewLoopChatScreen({Key key}) : super(key: key);
  static const routeName = "/NewLoopChatScreen";
  @override
  _NewLoopChatScreenState createState() => _NewLoopChatScreenState();
}

class _NewLoopChatScreenState extends State<NewLoopChatScreen> {
  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context).settings.arguments as List<Object>;
    final loopName = args[1] as String;
    final userData = args[0] as User;
    return Scaffold(
        appBar: AppBar(title: Text(loopName)),
        body: Column(
          children: [
            Expanded(child: Container()),
            NewMessage(),
          ],
        ));
  }
}
