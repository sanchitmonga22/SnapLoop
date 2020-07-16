import 'package:SnapLoop/Model/chat.dart';
import 'package:SnapLoop/Model/loop.dart';
import 'package:SnapLoop/Model/user.dart';
import 'package:SnapLoop/Provider/ChatProvider.dart';
import 'package:SnapLoop/Provider/LoopsProvider.dart';
import 'package:SnapLoop/Provider/UserDataProvider.dart';
import 'package:SnapLoop/Screens/Chat/LoopDetailsScreen.dart';
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

  Future<bool> initializeScreen() async {
    myId = Provider.of<UserDataProvider>(context).userId;
    final args =
        ModalRoute.of(context).settings.arguments as Map<String, dynamic>;
    loopName = args["loopName"] as String;
    userData = args["friend"] as FriendsData;
    images =
        await Provider.of<LoopsProvider>(context).getRandomURL(userData.userID);
    print(images);
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
    print(enteredMessage);
    Map<String, String> result = await Provider.of<LoopsProvider>(context)
        .createLoop(loopName, userData.userID, enteredMessage,
            images['friendUrl'], images["myUrl"]);
    if (result != null) {
      loop.chatID = result["chatId"];
      loop.id = result['_id'];
      chat.chatID = result["chatId"];
      chat.chat.add(ChatInfo(
          senderDisplayName: Provider.of<UserDataProvider>(context).displayName,
          senderID: myId,
          content: enteredMessage,
          time: DateTime.parse(result["sentTime"])));
      Provider.of<LoopsProvider>(context).addNewLoop(loop);
      Provider.of<ChatProvider>(context).addNewChat(chat);
    } else {
      print("result not found");
    }
  }

  Widget getChatWidget(Color backgroundColor) {
    return Container(
      decoration: BoxDecoration(color: backgroundColor),
      child: Column(
        children: [
          Expanded(child: Container()),
          NewMessage(sendMessage: sendMessage),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    radius = MediaQuery.of(context).size.width * 0.25 * kfixedRadiusFactor[2];
    Color backgroundColor = determineLoopColor(LoopType.EXISTING_LOOP);
    return FutureBuilder(
        future: initializeScreen(),
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
