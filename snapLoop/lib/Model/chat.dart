import 'package:flutter/foundation.dart';

/// author: @sanchitmonga22

class Chat {
  final String chatID;
  final List<ChatInfo> chat;
  Chat({@required this.chatID, @required this.chat});
}

class ChatInfo {
  final String senderDisplayName;
  final String senderID;
  //For now it is just text, and it will change as we move on
  final String content;
  final DateTime time;

  ChatInfo(
      {@required this.senderDisplayName,
      @required this.senderID,
      @required this.content,
      @required this.time});
}
