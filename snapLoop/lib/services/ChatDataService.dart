import 'dart:convert';

import 'package:SnapLoop/Model/HttpException.dart';
import 'package:SnapLoop/Model/chat.dart';
import 'package:SnapLoop/Model/responseParsingHelper.dart';
import 'package:SnapLoop/app/locator.dart';
import 'package:SnapLoop/services/Auth.dart';
import 'package:http/http.dart' as http;
import 'package:injectable/injectable.dart';
import 'package:observable_ish/observable_ish.dart';
import 'package:stacked/stacked.dart';

import '../constants.dart';

/// author: @sanchitmonga22

@lazySingleton
class ChatDataService with ReactiveServiceMixin {
  ChatDataService() {
    listenToReactiveValues([_chats]);
  }
  final _auth = locator<Auth>();

  RxList<Chat> _chats = RxList<Chat>();

  List<Chat> get chats {
    return [..._chats];
  }

  void addNewChat(Chat chat) {
    _chats.add(chat);
  }

  Chat getChatById(String chatId) {
    return _chats.firstWhere((element) {
      return element.chatID == chatId;
    });
  }

  void addNewMessage(String chatId, ChatInfo info) {
    _chats.firstWhere((element) => chatId == element.chatID).chat.add(info);
    notifyListeners();
  }

  Future<void> initializeChatByIdFromNetwork(String chatId) async {
    try {
      http.Response res = await http.get(
        '$SERVER_IP/chats/getData',
        headers: {
          "Authorization": "Bearer " + _auth.token,
          "Content-Type": "application/json",
          "chatId": chatId,
        },
      );
      final response = json.decode(res.body);
      if (res.statusCode == 200) {
        if (_chats.isNotEmpty) {
          _chats.removeWhere(
              (element) => element.chatID == response['chatId'] as String);
        }
        _chats.add(await ResponseParsingHelper.parseChat(response));
      } else {
        throw new HttpException("Could not get the chat from the server");
      }
    } catch (err) {
      throw new HttpException(err.toString());
    }
  }

  // either get the chat from the server or get the chat from the
}
