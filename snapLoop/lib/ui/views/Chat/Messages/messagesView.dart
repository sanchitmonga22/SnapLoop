import 'package:SnapLoop/Model/chat.dart';
import 'package:SnapLoop/ui/views/Chat/MessageBubble/messageBubbleView.dart';
import 'package:SnapLoop/ui/views/chat/Messages/MessagesViewModel.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

/// author: @sanchitmonga22
class MessagesView extends StatelessWidget {
  final String loopId;
  const MessagesView({Key key, @required this.loopId}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    String nextID = "";
    return ViewModelBuilder.reactive(
      viewModelBuilder: () => MessagesViewModel(),
      builder: (context, model, child) {
        model.initialize(loopId);
        return Expanded(
            child: loopId == "" || model.chat == null
                ? Container()
                : ListView.builder(
                    reverse: true,
                    itemBuilder: (context, index) {
                      ChatInfo message = model.chat[index];
                      bool nextUserExists = index + 2 <= model.chat.length;
                      if (nextUserExists)
                        nextID = model.chat[index + 1].senderID;
                      final view = MessageBubbleView(
                        isMe: message.senderID == model.myId,
                        message: message.content,
                        repeat:
                            index == // it is the last message, as seen from bottom to top since the list is reverse
                                    model.chat.length - 1
                                ? false
                                : nextID == message.senderID,
                        showMemoji:
                            index == // it is the last message, as seen from bottom to top since the list is reverse
                                    model.chat.length - 1
                                ? true
                                : nextID != message.senderID,
                        sent: message.time,
                        //TODO: fix the broken emojis
                        userRandomMemoji: model.loop.avatars[message.senderID],
                        key: ValueKey(index),
                      );
                      return view;
                    },
                    itemCount: model.chat.length ?? 0,
                  ));
      },
    );
  }
}
