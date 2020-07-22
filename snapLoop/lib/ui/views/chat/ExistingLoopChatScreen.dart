import 'package:SnapLoop/Model/loop.dart';
import 'package:SnapLoop/Model/user.dart';
import 'package:SnapLoop/Provider/ChatProvider.dart';
import 'package:SnapLoop/Provider/LoopsProvider.dart';
import 'package:SnapLoop/app/locator.dart';
import 'package:SnapLoop/app/router.gr.dart';
import 'package:SnapLoop/services/UserDataService.dart';
import 'package:SnapLoop/ui/views/chat/ExistingLoopChatModel.dart';
import 'package:SnapLoop/ui/views/chat/LoopDetailsScreen.dart';
import 'package:SnapLoop/ui/views/chat/messages.dart';
import 'package:SnapLoop/ui/views/chat/newMessage.dart';
import 'package:SnapLoop/constants.dart';
import 'package:SnapLoop/ui/views/Home/LoopWidget/loopWidgetView.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:stacked/stacked.dart';

/// author: @sanchitmonga22

class ExistingLoopChatScreen extends StatefulWidget {
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

  final _userData = locator<UserDataService>();
  Future future;
  bool init = true;
  LoopType loopType;
  String loopId;

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

  Future<void> sendMessage(String enteredMessage) async {
    var friend = await Navigator.of(context).pushNamed(
      Routes.friendsScreen,
      arguments: FriendsScreenArguments(
          loopName: widget.loop.name, loopForwarding: true),
    ) as FriendsData;
    List<dynamic> imageUrl =
        await Provider.of<LoopsProvider>(context, listen: false)
            .getRandomAvatarURL(1);
    await Provider.of<LoopsProvider>(context, listen: false).forwardLoop(
        friend.userID,
        enteredMessage,
        imageUrl[0],
        widget.loop.chatID,
        widget.loop.id);
    await Provider.of<ChatProvider>(context, listen: false)
        .initializeChatByIdFromNetwork(widget.loop.chatID);
    await _userData.updateUserData();
    Provider.of<LoopsProvider>(context, listen: false)
        .initializeLoopsFromUserData();
    Loop newLoop = Provider.of<LoopsProvider>(context).findById(widget.loop.id);
    setState(() {
      loopId = widget.loop.id;
    });
  }

  Widget getChatWidget(Color backgroundColor) {
    loopId = widget.loop.id;
    return Container(
        decoration: BoxDecoration(color: backgroundColor.withOpacity(0.4)),
        child: Stack(
          children: [
            Column(
              children: [
                Messages(
                  loopId: loopId,
                  newLoop: false,
                ),
                if (loopType == LoopType.INACTIVE_LOOP_SUCCESSFUL ||
                    loopType == LoopType.NEW_LOOP)
                  NewMessage(
                    sendMessage: sendMessage,
                  )
              ],
            )
          ],
        ));
  }

  @override
  Widget build(BuildContext context) {
    loopType = widget.loop.type;
    Color backgroundColor = determineLoopColor(widget.loop.type);
    LoopWidget loopWidget = LoopWidget(
      isTappable: false,
      loop: widget.loop,
      radius: widget.radius,
      flipOnTouch: false,
    );
    super.build(context);
    return ViewModelBuilder.reactive(
      viewModelBuilder: () => ExistingLoopChatViewModel(),
      builder: (context, model, child) => FutureBuilder(
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
          }),
    );
  }
}
