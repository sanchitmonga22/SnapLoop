import 'package:SnapLoop/Model/user.dart';
import 'package:flutter/material.dart';

class LoopChatScreen extends StatefulWidget {
  LoopChatScreen({Key key}) : super(key: key);
  static const routeName = "/LoopChatScreen";
  @override
  _LoopChatScreenState createState() => _LoopChatScreenState();
}

class _LoopChatScreenState extends State<LoopChatScreen> {
  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context).settings.arguments as List<Object>;
    final loopName = args[1] as String;
    final userData = args[0] as User;
    return Scaffold(
        appBar: AppBar(title: Text(loopName)),
        body: Center(child: Column(children: [])));
  }
}
