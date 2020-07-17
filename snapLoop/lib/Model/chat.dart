import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

/// author: @sanchitmonga22

class Chat {
  String chatID;
  final List<ChatInfo> chat;
  Chat({@required this.chatID, @required this.chat});
}

class ChatInfo {
  final String senderID;
  //For now it is just text, and it will change as we move on
  final String content;
  final DateTime time;

  ChatInfo(
      {@required this.senderID, @required this.content, @required this.time});
}
