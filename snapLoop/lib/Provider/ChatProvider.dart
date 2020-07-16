import 'package:SnapLoop/Model/chat.dart';
import 'package:flutter/widgets.dart';

/// author: @sanchitmonga22

class ChatProvider with ChangeNotifier {
  List<Chat> chats = [];
  final String authToken;
  final String userId;

  ChatProvider(this.authToken, this.userId, this.chats);

  void addNewChat(Chat chat) {
    chats.add(chat);
    notifyListeners();
  }
}
