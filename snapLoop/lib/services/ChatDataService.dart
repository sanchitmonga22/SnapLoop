import 'dart:convert';

import 'package:SnapLoop/Model/HttpException.dart';
import 'package:SnapLoop/Model/chat.dart';
import 'package:SnapLoop/Model/responseParsingHelper.dart';
import 'package:SnapLoop/app/locator.dart';
import 'package:SnapLoop/services/Auth.dart';
import 'package:http/http.dart' as http;
import 'package:injectable/injectable.dart';

import '../constants.dart';

/// author: @sanchitmonga22

@lazySingleton
class ChatDataService {
  final _auth = locator<Auth>();
  List<Chat> _chats = [];

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
      throw new HttpException(err);
    }
  }

  // either get the chat from the server or get the chat from the
}
