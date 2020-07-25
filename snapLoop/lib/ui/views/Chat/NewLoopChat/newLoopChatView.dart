import 'package:SnapLoop/Model/user.dart';
import 'package:SnapLoop/constants.dart';
import 'package:SnapLoop/ui/views/chat/LoopDetailsWidget/LoopDetailsView.dart';
import 'package:SnapLoop/ui/views/chat/NewLoopChat/NewLoopChatViewModel.dart';
import 'package:SnapLoop/ui/views/chat/Messages/messagesView.dart';
import 'package:SnapLoop/ui/views/chat/NewMessage/newMessageView.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

/// author: @sanchitmonga22

class NewLoopChatView extends StatefulWidget {
  final String loopName;
  final FriendsData friend;
  NewLoopChatView({Key key, @required this.loopName, @required this.friend})
      : super(key: key);
  @override
  _NewLoopChatViewState createState() => _NewLoopChatViewState();
}

class _NewLoopChatViewState extends State<NewLoopChatView> {
  Widget getChatWidget(model) {
    return Container(
      decoration: BoxDecoration(color: model.backgroundColor),
      child: Column(
        children: [
          MessagesView(
            loopId: model.loopId,
            newLoop: true,
          ),
          NewMessageView(sendMessage: model.sendMessage),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder.reactive(
      viewModelBuilder: () => NewLoopChatViewModel(),
      createNewModelOnInsert: true,
      onModelReady: (model) => model.initialize(widget.loopName, widget.friend,
          kradiusCalculator(2, MediaQuery.of(context).size.width / 4)),
      builder: (context, model, child) {
        return FutureBuilder(
            future: model.initializeScreen(),
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
                      backgroundColor: model.backgroundColor,
                      chatWidget: getChatWidget(model),
                      loopWidget: model.loopWidget,
                    );
            });
      },
    );
  }
}
