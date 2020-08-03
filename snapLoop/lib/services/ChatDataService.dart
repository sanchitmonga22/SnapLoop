import 'dart:convert';

import 'package:SnapLoop/Model/HttpException.dart';
import 'package:SnapLoop/Model/chat.dart';
import 'package:SnapLoop/Model/responseParsingHelper.dart';
import 'package:SnapLoop/app/locator.dart';
import 'package:SnapLoop/services/Auth.dart';
import 'package:SnapLoop/services/ConnectionService.dart';
import 'package:http/http.dart' as http;
import 'package:injectable/injectable.dart';
import 'package:observable_ish/observable_ish.dart';
import 'package:stacked/stacked.dart';

import '../app/constants.dart';

/// author: @sanchitmonga22

@lazySingleton
class ChatDataService with ReactiveServiceMixin {
  ChatDataService() {
    listenToReactiveValues([_chats]);
  }

  final _connectionService = locator<ConnectionStatusService>();
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
    if (_connectionService.connected == false) {
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
        _chats.add(await ResponseParsingHelper.parseChat(response));
      } else {
        throw new HttpException("Could not get the chat from the server");
      }
    } catch (err) {
      throw new HttpException(err.toString());
    }
  }

  Future<List<dynamic>> getGifs(String search, bool getSticker) async {
    try {
      String searchType = getSticker ? 'stickers' : 'gifs';
      http.Response res = await http.get(
          'https://api.giphy.com/v1/$searchType/search?api_key=wSkieSvPYJ1G16q7rqsYGeQXaXI8B3nt&q=$search&limit=25');
      List<dynamic> urls = [];
      if (res.statusCode == 200) {
        final response = json.decode(res.body)['data'] as List<dynamic>;
        //print(response[0]['images']['original']['url']);, for the preview
        for (int i = 0; i < response.length; i++) {
          urls.add({
            'url': response[i]['images']['preview_gif']['url'],
            'id': response[i]['id'],
            'original': response[i]['images']['original']['url']
          });
        }
        return urls;
      } else {
        throw new HttpException("gifs not found");
      }
    } catch (err) {
      throw new HttpException(err.toString());
    }
  }
}
