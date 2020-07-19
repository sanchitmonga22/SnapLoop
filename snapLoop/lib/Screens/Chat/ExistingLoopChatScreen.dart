import 'package:SnapLoop/Model/loop.dart';
import 'package:SnapLoop/Model/user.dart';
import 'package:SnapLoop/Provider/ChatProvider.dart';
import 'package:SnapLoop/Provider/LoopsProvider.dart';
import 'package:SnapLoop/Provider/UserDataProvider.dart';
import 'package:SnapLoop/Screens/Chat/LoopDetailsScreen.dart';
import 'package:SnapLoop/Screens/Chat/messages.dart';
import 'package:SnapLoop/Screens/Chat/newMessage.dart';
import 'package:SnapLoop/Screens/Contacts/FriendsScreen.dart';
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
      FriendsScreen.routeName,
      arguments: {"loopName": widget.loop.name, "loopForwarding": true},
    ) as FriendsData;
    //= ModalRoute.of(context).settings.arguments as FriendsData;
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
    await Provider.of<UserDataProvider>(context, listen: false)
        .updateUserData();
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
