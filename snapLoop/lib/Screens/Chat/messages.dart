import 'package:SnapLoop/Model/chat.dart';
import 'package:SnapLoop/Model/loop.dart';
import 'package:SnapLoop/Provider/ChatProvider.dart';
import 'package:SnapLoop/Provider/LoopsProvider.dart';
import 'package:SnapLoop/Provider/UserDataProvider.dart';
import 'package:SnapLoop/Screens/Chat/messageBubble.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

/// author: @sanchitmonga22
class Messages extends StatefulWidget {
  final String loopId;
  final bool newLoop;
  const Messages({Key key, @required this.loopId, this.newLoop = false})
      : super(key: key);

  @override
  _MessagesState createState() => _MessagesState();
}

class _MessagesState extends State<Messages> {
  Loop loop;
  Chat chat;
  String myId;

  @override
  Widget build(BuildContext context) {
    if (widget.loopId != "") {
      loop = Provider.of<LoopsProvider>(context).findById(widget.loopId);
      myId = Provider.of<UserDataProvider>(context).userId;
      chat = Provider.of<ChatProvider>(context, listen: false)
          .getChatById(loop.chatID);
    }
    //final messages = "";
    return Expanded(
        child: widget.loopId == "" && chat == null
            ? Container()
            : ListView.builder(
                reverse: true,
                itemBuilder: (context, index) {
                  ChatInfo message = chat.chat[index];
                  return MessageBubble(
                    isMe: message.senderID == myId,
                    message: message.content,
                    sent: message.time,
                    userRandomMemoji: loop.avatars[message.senderID],
                    key: ValueKey(index),
                  );
                },
                itemCount: chat.chat.length,
              ));
  }
}
