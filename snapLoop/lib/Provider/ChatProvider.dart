import 'package:SnapLoop/Model/chat.dart';
import 'package:flutter/widgets.dart';

/// author: @sanchitmonga22

class ChatProvider with ChangeNotifier {
  List<Chat> _chats = [];
  final String authToken;
  final String userId;

  ChatProvider(this.authToken, this.userId, this._chats);

  List<Chat> get chats {
    return [..._chats];
  }

  void addNewChat(Chat chat) {
    _chats.add(chat);
    notifyListeners();
  }

  Chat getChatById(String chatId) {
    print(chatId);
    return _chats.firstWhere((element) => element.chatID == chatId);
    // _chats.forEach((element) {
    //   if (element.chatID == chatId) {
    //     return element;
    //   }
    // });
    // return getChatByIdFromNetwork(chatId);
  }

  Chat getChatByIdFromNetwork(String chatId) {}

  // either get the chat from the server or get the chat from the
}
