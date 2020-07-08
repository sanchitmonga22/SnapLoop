import 'package:SnapLoop/Screens/Chat/messageBubble.dart';
import 'package:SnapLoop/Screens/Home/Bitmojis/bitmoji.dart';
import 'package:flutter/material.dart';

/// author: @sanchitmonga22
class Messages extends StatelessWidget {
  const Messages({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    //final messages = "";
    return Expanded(
        child: ListView(children: [
      MessageBubble(
        isMe: true,
        key: UniqueKey(),
        message: "Hello!",
        userRandomMemoji: URLMemojis[10].replaceAll("%s", USERS[10]),
        username: "Monga",
      ),
      MessageBubble(
        key: UniqueKey(),
        message:
            "Hellohhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhh!",
        userRandomMemoji: URLMemojis[3].replaceAll("%s", USERS[3]),
      ),
      MessageBubble(
        key: UniqueKey(),
        message: "Trump is an idiot!",
        userRandomMemoji: URLMemojis[2].replaceAll("%s", USERS[2]),
      ),
      MessageBubble(
        isMe: true,
        key: UniqueKey(),
        message: "Haha true!",
        userRandomMemoji: URLMemojis[10].replaceAll("%s", USERS[10]),
        username: "Monga",
      ),
    ]));
  }
}
