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
  RxValue<List<Chat>> _chats = RxValue<List<Chat>>(initial: []);

  List<Chat> get chats {
    return [..._chats.value];
  }

  void addNewChat(Chat chat) {
    _chats.value.add(chat);
  }

  Chat getChatById(String chatId) {
    return _chats.value.firstWhere((element) {
      return element.chatID == chatId;
    });
  }

  void addNewMessage(String chatId, ChatInfo info) {
    _chats.value
        .firstWhere((element) => chatId == element.chatID)
        .chat
        .add(info);
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
        if (_chats.value.isNotEmpty) {
          _chats.value.removeWhere(
              (element) => element.chatID == response['chatId'] as String);
        }
        _chats.value.add(await ResponseParsingHelper.parseChat(response));
      } else {
        throw new HttpException("Could not get the chat from the server");
      }
    } catch (err) {
      throw new HttpException(err);
    }
  }

  // either get the chat from the server or get the chat from the
}
