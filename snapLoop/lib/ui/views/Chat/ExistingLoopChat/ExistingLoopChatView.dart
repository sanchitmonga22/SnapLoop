import 'package:SnapLoop/Model/loop.dart';
import 'package:SnapLoop/ui/views/chat/ExistingLoopChat/ExistingLoopChatViewModel.dart';
import 'package:SnapLoop/ui/views/chat/LoopDetailsWidget/LoopDetailsView.dart';
import 'package:SnapLoop/ui/views/chat/Messages/messagesView.dart';
import 'package:SnapLoop/ui/views/chat/NewMessage/newMessageView.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

/// author: @sanchitmonga22

class ExistingLoopChatView extends StatefulWidget {
  ExistingLoopChatView({
    Key key,
    this.radius,
    this.loop,
  }) : super(key: key);

  final Loop loop;
  final double radius;

  @override
  _ExistingLoopChatViewState createState() => _ExistingLoopChatViewState();
}

class _ExistingLoopChatViewState extends State<ExistingLoopChatView>
    with AutomaticKeepAliveClientMixin<ExistingLoopChatView> {
  @override
  bool get wantKeepAlive => true;

  Widget getChatWidget(model) {
    return Container(
        decoration:
            BoxDecoration(color: model.backgroundColor.withOpacity(0.4)),
        child: Stack(
          children: [
            Column(
              children: [
                MessagesView(
                  loopId: model.loop.id,
                ),
                if (model.loop.type == LoopType.INACTIVE_LOOP_SUCCESSFUL ||
                    model.loop.type == LoopType.NEW_LOOP)
                  NewMessageView(
                    sendMessage: (enteredMessage) {
                      return model.sendMessage(enteredMessage, context);
                    },
                  )
              ],
            )
          ],
        ));
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return ViewModelBuilder.reactive(
      viewModelBuilder: () => ExistingLoopChatViewModel(),
      createNewModelOnInsert: true,
      onModelReady: (model) => model.initialize(widget.loop, widget.radius),
      builder: (context, model, child) => FutureBuilder(
          future: model.initializeChat(),
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
                    loop: widget.loop,
                    backgroundColor: model.backgroundColor,
                    chatWidget: getChatWidget(model),
                    loopWidget: model.loopWidget,
                  );
          }),
    );
  }
}
