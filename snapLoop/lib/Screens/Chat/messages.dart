import 'package:flutter/material.dart';

/// author: @sanchitmonga22
class Messages extends StatelessWidget {
  const Messages({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final messages = "";
    return Expanded(
      child: Container(
        child: ListView.builder(
          itemBuilder: (context, index) {
//          return MessageBubble(isMe: ,key: ,message: ,userRandomMemoji: ,username: ,);
          },
        ),
      ),
    );
  }
}
