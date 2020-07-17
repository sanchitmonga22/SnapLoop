import 'package:SnapLoop/Model/loop.dart';
import 'package:SnapLoop/Provider/ChatProvider.dart';
import 'package:SnapLoop/Screens/Chat/LoopDetailsScreen.dart';
import 'package:SnapLoop/Screens/Chat/messages.dart';
import 'package:SnapLoop/Screens/Chat/newMessage.dart';
import 'package:SnapLoop/Screens/Home/LoopWidget/loopWidget.dart';
import 'package:SnapLoop/constants.dart';
import 'package:flutter/material.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';
import 'package:provider/provider.dart';

/// author: @sanchitmonga22

class ExistingLoopChatScreen extends StatefulWidget {
  static const routeName = "/ExisitingLoop";
  ExistingLoopChatScreen({
    Key key,
    this.radius,
    this.loop,
  }) : super(key: key);

  final Loop loop;
  final double radius;

  @override
  _ExistingLoopChatScreenState createState() => _ExistingLoopChatScreenState();
}

class _ExistingLoopChatScreenState extends State<ExistingLoopChatScreen>
    with AutomaticKeepAliveClientMixin<ExistingLoopChatScreen> {
  @override
  bool get wantKeepAlive => true;

  Future future;
  bool init = true;

  Future<bool> initializeChat() async {
    await Provider.of<ChatProvider>(context, listen: false)
        .initializeChatByIdFromNetwork(
      widget.loop.chatID,
    );
    return true;
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (init) {
      future = initializeChat();
      init = false;
    }
  }

  Widget getChatWidget(Color backgroundColor) {
    return Container(
        decoration: BoxDecoration(color: backgroundColor.withOpacity(0.4)),
        child: Stack(
          children: [
            Column(
              children: [
                Messages(
                  loopId: widget.loop.id,
                  newLoop: false,
                ),
                NewMessage()
              ],
            )
          ],
        ));
  }

  @override
  Widget build(BuildContext context) {
    Color backgroundColor = determineLoopColor(widget.loop.type);
    LoopWidget loopWidget = LoopWidget(
      isTappable: false,
      loop: widget.loop,
      radius: widget.radius,
      flipOnTouch: false,
    );
    super.build(context);
    return FutureBuilder(
        future: future,
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
              : LoopsDetailsScreen(
                  loop: widget.loop,
                  backgroundColor: backgroundColor,
                  chatWidget: getChatWidget(backgroundColor),
                  loopWidget: loopWidget,
                );
        });
  }
}
