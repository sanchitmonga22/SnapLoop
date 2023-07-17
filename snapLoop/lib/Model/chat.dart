import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

/// author: @sanchitmonga22

class Chat {
  String chatID;
  final List<ChatInfo> chat;
  Chat({required this.chatID, required this.chat});

  dynamic toJson() {
    return {'_id': this.chatID, 'messages': getMessagesData()};
  }

  dynamic getMessagesData() {
    var result = [];
    for (int i = 0; i < chat.length; i++) {
      result.add(chat[i].toJson());
    }
  }
}

class ChatInfo {
  final String senderID;
  //For now it is just text, and it will change as we move on
  final String content;
  final DateTime time;

  ChatInfo(
      {required this.senderID, required this.content, required this.time});

  dynamic toJson() {
    return {
      'content': content,
      'sender': senderID,
      'sentTime': time.toIso8601String()
    };
  }
}
