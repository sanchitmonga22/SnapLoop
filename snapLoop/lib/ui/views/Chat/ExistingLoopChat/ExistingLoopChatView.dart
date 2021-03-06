import 'package:SnapLoop/Model/loop.dart';
import 'package:SnapLoop/app/constants.dart';
import 'package:SnapLoop/ui/views/Chat/NewMessage/gifSelectionView.dart';
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

class _ExistingLoopChatViewState extends State<ExistingLoopChatView> {
  bool gifSelection = false; // is the person currently selecting a gif
  Widget getChatWidget(ExistingLoopChatViewModel model, BuildContext context) {
    return Container(
        decoration: BoxDecoration(color: kChatViewColor),
        child: Column(
          children: [
            MessagesView(
              loopId: model.loop.id,
            ),
            // if the user can enter a new message but the gif selection is not selected
            if ((model.loop.type == LoopType.INACTIVE_LOOP_SUCCESSFUL ||
                    model.loop.type == LoopType.NEW_LOOP) &&
                !gifSelection)
              NewMessageView(
                gifSelection: (bool select) {
                  setState(() {
                    gifSelection = select;
                  });
                },
                sendMessage: (enteredMessage) {
                  return model.sendMessage(enteredMessage, context);
                },
              )
            // if the user can enter a new message and the gif selection is selected, a new uplifted view of gifselection is created
            // to user to select a new gif and send it in the chat
            else if (((model.loop.type == LoopType.INACTIVE_LOOP_SUCCESSFUL ||
                    model.loop.type == LoopType.NEW_LOOP) &&
                gifSelection))
              GIFSelection(
                sendMessage: (String enteredMessage, String url) async {
                  String finalMessage = url + kMesagesplitCode + enteredMessage;
                  await model.sendMessage(finalMessage, context);
                  setState(() {
                    gifSelection = false;
                  });
                },
                cancel: (bool cancel) {
                  setState(() {
                    gifSelection = !cancel;
                  });
                },
              )
            else
              Padding(padding: EdgeInsets.only(bottom: 50)),
          ],
        ));
  }

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder.reactive(
        viewModelBuilder: () => ExistingLoopChatViewModel(),
        onModelReady: (model) => model.initialize(widget.loop, widget.radius),
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
                  loop: widget.loop,
                  chatWidget: getChatWidget(model, context),
                  loopWidget: model.loopWidget,
                );
        });
  }
}
