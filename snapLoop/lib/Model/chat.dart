import 'package:flutter/foundation.dart';

class Chat {
  final String loopID;
  final Map<String, ChatInfo> chat;
  Chat({@required this.loopID, @required this.chat});
}

class ChatInfo {
  final String sender;
  //For now it is just text, and it will change as we move on
  final String content;
  final DateTime time;

  ChatInfo(
      {@required this.sender, @required this.content, @required this.time});
}
