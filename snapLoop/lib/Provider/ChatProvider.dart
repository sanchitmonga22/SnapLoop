import 'package:SnapLoop/Model/chat.dart';
import 'package:flutter/widgets.dart';

class ChatProvider with ChangeNotifier {
  // This list will be sorted in the cloud according to the time
  // the message was sent and then stored in the cloud according to that
  List<ChatInfo> getChatContentForLoop(String loopID) {
    // make an API call to get the chats for the loop
  }
}
