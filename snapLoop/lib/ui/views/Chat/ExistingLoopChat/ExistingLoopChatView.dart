import 'package:SnapLoop/Model/loop.dart';
import 'package:SnapLoop/ui/views/chat/ExistingLoopChat/ExistingLoopChatViewModel.dart';
import 'package:SnapLoop/ui/views/chat/LoopDetailsWidget/LoopDetailsView.dart';
import 'package:SnapLoop/ui/views/chat/Messages/messagesView.dart';
import 'package:SnapLoop/ui/views/chat/NewMessage/newMessageView.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

/// author: @sanchitmonga22

class ExistingLoopChatView extends StatelessWidget {
  ExistingLoopChatView({
    Key key,
    this.radius,
    this.loop,
  }) : super(key: key);

  final Loop loop;
  final double radius;

  Widget getChatWidget(ExistingLoopChatViewModel model, BuildContext context) {
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
                else
                  Padding(padding: EdgeInsets.only(bottom: 50))
              ],
            )
          ],
        ));
  }

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder.reactive(
        viewModelBuilder: () => ExistingLoopChatViewModel(),
        onModelReady: (model) => model.initialize(loop, radius),
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
                  loop: loop,
                  backgroundColor: model.backgroundColor,
                  chatWidget: getChatWidget(model, context),
                  loopWidget: model.loopWidget,
                );
        });
  }
}
