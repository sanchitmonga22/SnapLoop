import 'package:SnapLoop/Model/user.dart';
import 'package:SnapLoop/constants.dart';
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
      decoration: BoxDecoration(color: model.backgroundColor),
      child: Column(
        children: [
          MessagesView(
            loopId: model.loopId,
          ),
          if (!model.messageSent)
            NewMessageView(sendMessage: (String enteredMessage) async {
              await model.sendMessage(enteredMessage);
              //setState(() {});
            }),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder.reactive(
      viewModelBuilder: () => NewLoopChatViewModel(),
      disposeViewModel: true,
      onModelReady: (model) => model.initialize(loopName, friend,
          kradiusCalculator(2, MediaQuery.of(context).size.width / 4)),
      builder: (context, model, child) {
        return FutureBuilder(
            future: model.future,
            builder: (context, snapshot) {
              return snapshot.connectionState == ConnectionState.waiting
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
                      backgroundColor: model.backgroundColor,
                      chatWidget: getChatWidget(model),
                      loopWidget: model.loopWidget,
                    );
            });
      },
    );
  }
}
