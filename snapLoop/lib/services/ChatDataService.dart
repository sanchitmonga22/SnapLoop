import 'dart:convert';

import 'package:SnapLoop/Model/HttpException.dart';
import 'package:SnapLoop/Model/chat.dart';
import 'package:SnapLoop/Model/responseParsingHelper.dart';
import 'package:SnapLoop/app/locator.dart';
import 'package:SnapLoop/services/Auth.dart';
import 'package:SnapLoop/services/ConnectionService.dart';
import 'package:SnapLoop/services/StorageService.dart';
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

  final _connectionService = locator<ConnectionStatusService>();
  final _storageSerice = locator<StorageService>();
  final _auth = locator<Auth>();

  RxList<Chat> _chats = RxList<Chat>();

  List<Chat> get chats {
    return [..._chats];
  }

  void setChats(List<Chat> chts) {
    _chats.addAll(chts);
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
    _chats.forEach((element) {
      if (chatId == element.chatID) {
        element.chat.add(info);
        return;
      }
    });
    notifyListeners();
  }

  Future<dynamic> sendNewGroupMessage(
      String chatId, String loopId, String message) async {
    try {
      http.Response res = await http.post(
        '$SERVER_IP/chats/newGroupMessage',
        headers: {
          "Authorization": "Bearer " + _auth.token,
          "Content-Type": "application/json",
        },
        body: jsonEncode(
            {"chatId": chatId, "content": message, 'loopId': loopId}),
      );
      final response = json.decode(res.body);
      if (res.statusCode == 200) {
        return response;
      } else {
        throw new HttpException("Could not get the chat from the server");
      }
    } catch (err) {
      throw new HttpException(err.toString());
    }
  }

  Future<void> initializeChatByIdFromNetwork(String chatId) async {
    if (!_connectionService.connected) {
      dynamic data = await _storageSerice.getValueFromKey(chatId);
      if (_chats.isNotEmpty) {
        _chats.removeWhere((element) => element.chatID == chatId);
      }
      _chats.add(await ResponseParsingHelper.parseChat(data));
      return;
    }
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
        await _storageSerice.addNewKeyValue(chatId, response);
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
