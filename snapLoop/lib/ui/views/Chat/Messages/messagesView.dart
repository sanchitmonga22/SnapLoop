import 'package:SnapLoop/Model/chat.dart';
import 'package:SnapLoop/ui/views/chat/Messages/MessagesViewModel.dart';
import 'package:SnapLoop/ui/views/chat/MessageBubble/messageBubbleView.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

/// author: @sanchitmonga22
class MessagesView extends StatelessWidget {
  final String loopId;
  const MessagesView({Key key, @required this.loopId}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder.reactive(
      viewModelBuilder: () => MessagesViewModel(),
      builder: (context, model, child) {
        model.initialize(loopId);
        return Expanded(
            child: loopId == "" || model.chat == null
                ? Container()
                : ListView.builder(
                    itemBuilder: (context, index) {
                      ChatInfo message = model.chat.chat[index];
                      return MessageBubbleView(
                        isMe: message.senderID == model.myId,
                        message: message.content,
                        sent: message.time,
                        //TODO: fix the broken emojis
                        userRandomMemoji: model.loop.avatars[message.senderID],
                        key: ValueKey(index),
                      );
                    },
                    itemCount: model.chat.chat.length ?? 0,
                  ));
      },
    );
  }
}
