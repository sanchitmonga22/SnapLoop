import 'package:SnapLoop/Model/chat.dart';
import 'package:SnapLoop/Model/loop.dart';
import 'package:SnapLoop/Model/user.dart';
import 'package:SnapLoop/Provider/ChatProvider.dart';
import 'package:SnapLoop/Provider/LoopsProvider.dart';
import 'package:SnapLoop/Provider/UserDataProvider.dart';
import 'package:SnapLoop/Screens/Chat/LoopDetailsScreen.dart';
import 'package:SnapLoop/Screens/Chat/messages.dart';
import 'package:SnapLoop/Screens/Chat/newMessage.dart';
import 'package:SnapLoop/Screens/Home/LoopWidget/loopWidget.dart';
import 'package:SnapLoop/constants.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

/// author: @sanchitmonga22

class NewLoopChatScreen extends StatefulWidget {
  NewLoopChatScreen({Key key}) : super(key: key);
  static const routeName = "/NewLoopChatScreen";
  @override
  _NewLoopChatScreenState createState() => _NewLoopChatScreenState();
}

class _NewLoopChatScreenState extends State<NewLoopChatScreen> {
  double radius = 0;
  Loop loop;
  LoopWidget loopWidget;
  Chat chat;
  String myId;
  String loopName;
  FriendsData userData;
  Map<String, dynamic> images;
  Future future;
  bool first = true;
  String loopId = "";

  Future<bool> initializeScreen() async {
    myId = Provider.of<UserDataProvider>(context).userData.userID;
    final args =
        ModalRoute.of(context).settings.arguments as Map<String, dynamic>;
    loopName = args["loopName"] as String;
    userData = args["friend"] as FriendsData;
    images =
        await Provider.of<LoopsProvider>(context).getRandomURL(userData.userID);
    loop = new Loop(
        currentUserId: userData.userID,
        chatID: "",
        creatorId: myId,
        id: "",
        avatars: {myId: images[myId], userData.userID: images[userData.userID]},
        name: loopName,
        numberOfMembers: 2,
        type: LoopType.NEW_LOOP,
        userIDs: [myId, userData.userID]);
    chat = new Chat(chatID: "", chat: []);
    loopWidget = LoopWidget(
      isTappable: false,
      radius: radius,
      flipOnTouch: false,
      loop: loop,
    );
    return true;
  }

  Future<void> sendMessage(String enteredMessage) async {
    var result = await Provider.of<LoopsProvider>(context, listen: false)
        .createLoop(loopName, userData.userID, enteredMessage,
            images[userData.userID], images[myId]);
    if (result != null) {
      loop.chatID = result["chatId"];
      loop.id = result['_id'];
      chat.chatID = result['chatId'];
      chat.chat.add(ChatInfo(
          senderID: myId,
          content: enteredMessage,
          time:
              DateTime.fromMicrosecondsSinceEpoch(result["sentTime"] as int)));
      Provider.of<LoopsProvider>(context, listen: false).addNewLoop(loop);
      await Provider.of<ChatProvider>(context, listen: false)
          .initializeChatByIdFromNetwork(loop.chatID);
      // rebuilding the widget once the chat has been saved in the chats array in the chat provider
      setState(() {
        loopId = result['_id'];
      });
    } else {
      print("result not found and loop not created");
    }
  }

  Widget getChatWidget(Color backgroundColor) {
    return Container(
      decoration: BoxDecoration(color: backgroundColor),
      child: Column(
        children: [
          Messages(
            loopId: loopId,
            newLoop: true,
          ),
          NewMessage(sendMessage: sendMessage),
        ],
      ),
    );
  }

  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
    if (first) {
      future = initializeScreen();
      first = false;
    }
  }

  @override
  Widget build(BuildContext context) {
    radius = MediaQuery.of(context).size.width * 0.25 * kfixedRadiusFactor[2];
    Color backgroundColor = determineLoopColor(LoopType.EXISTING_LOOP);
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
                  backgroundColor: backgroundColor,
                  chatWidget: getChatWidget(backgroundColor),
                  loopWidget: loopWidget,
                );
        });
  }
}
