import 'package:SnapLoop/Model/user.dart';
import 'package:SnapLoop/app/constants.dart';
import 'package:SnapLoop/ui/views/chat/LoopDetailsWidget/LoopDetailsView.dart';
import 'package:SnapLoop/ui/views/chat/NewLoopChat/NewLoopChatViewModel.dart';
import 'package:SnapLoop/ui/views/chat/Messages/messagesView.dart';
import 'package:SnapLoop/ui/views/chat/NewMessage/newMessageView.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

/// author: @sanchitmonga22

class NewLoopChatView extends StatelessWidget {
  final String loopName;
  final FriendsData friend;
  NewLoopChatView({Key key, @required this.loopName, @required this.friend})
      : super(key: key);

  Widget getChatWidget(model) {
    return Container(
      decoration: BoxDecoration(color: kChatViewColor),
      child: Column(
        children: [
          MessagesView(
            loopId: model.loopId,
          ),
          if (!model.messageSent)
            NewMessageView(sendMessage: (String enteredMessage) async {
              await model.sendMessage(enteredMessage);
            })
          else
            Padding(padding: EdgeInsets.only(bottom: 50))
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder.reactive(
      viewModelBuilder: () => NewLoopChatViewModel(),
      disposeViewModel: true,
      onModelReady: (model) =>
          model.initialize(loopName, friend, kradiusCalculator(2)),
      builder: (context, model, child) {
        return model.isBusy
            ? Material(
                child: Center(
                child: Container(
                  height: 30,
                  width: 30,
                  child: CircularProgressIndicator(),
                ),
              ))
            : LoopsDetailsView(
                loop: model.loop,
                chatWidget: getChatWidget(model),
                loopWidget: model.loopWidget,
              );
      },
    );
  }
}
