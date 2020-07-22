import 'package:SnapLoop/Model/chat.dart';
import 'package:SnapLoop/Model/loop.dart';
import 'package:SnapLoop/Provider/ChatProvider.dart';
import 'package:SnapLoop/Provider/LoopsProvider.dart';
import 'package:SnapLoop/app/locator.dart';
import 'package:SnapLoop/services/UserDataService.dart';
import 'package:SnapLoop/ui/views/chat/Messages/MessagesViewModel.dart';
import 'package:SnapLoop/ui/views/chat/MessageBubble/messageBubbleView.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:stacked/stacked.dart';

/// author: @sanchitmonga22
class MessagesView extends StatefulWidget {
  final String loopId;
  final bool newLoop;
  const MessagesView({Key key, @required this.loopId, this.newLoop = false})
      : super(key: key);

  @override
  _MessagesViewState createState() => _MessagesViewState();
}

class _MessagesViewState extends State<MessagesView> {
  Loop loop;
  Chat chat;
  String myId;

  @override
  Widget build(BuildContext context) {
    final _userData = locator<UserDataService>();
    if (widget.loopId != "") {
      loop = Provider.of<LoopsProvider>(context).findById(widget.loopId);
      myId = _userData.userId;
      chat = Provider.of<ChatProvider>(context, listen: false)
          .getChatById(loop.chatID);
    }
    //final messages = "";
    return ViewModelBuilder.reactive(
      viewModelBuilder: () => MessagesViewModel(),
      builder: (context, model, child) => Expanded(
          child: widget.loopId == "" && chat == null
              ? Container()
              : ListView.builder(
                  itemBuilder: (context, index) {
                    ChatInfo message = chat.chat[index];
                    return MessageBubbleView(
                      isMe: message.senderID == myId,
                      message: message.content,
                      sent: message.time,
                      userRandomMemoji: loop.avatars[message.senderID],
                      key: ValueKey(index),
                    );
                  },
                  itemCount: chat.chat.length,
                )),
    );
  }
}
