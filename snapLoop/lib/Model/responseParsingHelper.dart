import 'dart:convert';

import 'package:SnapLoop/Model/chat.dart';
import 'package:SnapLoop/Model/loop.dart';
import 'package:SnapLoop/Model/user.dart';
import 'package:SnapLoop/app/locator.dart';
import 'package:SnapLoop/services/UserDataService.dart';
import 'package:SnapLoop/ui/Widget/time/timezones.dart';

//1595734836562
class ResponseParsingHelper {
  static Future<Chat> parseChat(dynamic response) async {
    List<ChatInfo> messages = [];
    String chatId = response['_id'];
    List<dynamic> res = response['messages'];
    for (int i = 0; i < res.length; i++) {
      var message = res[i];
      messages.add(await (parseChatInfo(message)));
    }
    return Chat(chat: messages, chatID: chatId);
  }

  static Future<ChatInfo> parseChatInfo(dynamic message) async {
    return ChatInfo(
      content: message['content'],
      senderID: message['sender'],
      time: await TimeHelperService.convertToLocal(
          DateTime.parse(message['sentTime'])),
    );
  }

  static FriendsData parseFriend(dynamic response) {
    return FriendsData(
        avatar: response['myImage'] == "" || response['myImage'] == null
            ? null
            : base64Decode(response['myImage']),
        username: response['username'],
        displayName: (response['displayName'] ?? "") == ""
            ? response['username']
            : response['displayName'],
        email: response['email'],
        userID: response['_id'],
        score: response['score'] as int,
        status: response['status'],
        commonLoops: response['commonLoops'].cast<String>().toList() ?? [],
        mutualFriendsIDs:
            response['mutualFriends'].cast<String>().toList() ?? []);
  }

  static PublicUserData parsePublicUserData(dynamic response) {
    final _userDataService = locator<UserDataService>();
    return PublicUserData(
        sentRequest: _userDataService.requestStatusById(response['_id']),
        avatar: response['myImage'] == "" || response['myImage'] == null
            ? null
            : base64Decode(response['myImage']),
        email: response['email'],
        userID: response['_id'],
        username: response['username']);
  }

  static User parseUser(dynamic response, String userId) {
    return User(
        status: response['status'],
        myAvatar: response['myImage'] == "" || response['myImage'] == null
            ? null
            : base64Decode(response['myImage']),
        numberOfLoopsRemaining: response['numberOfLoopsRemaining'],
        contacts: response["contacts"].cast<String>().toList(),
        userID: userId,
        username: response['username'] as String ?? "",
        displayName: response['displayName'] == ""
            ? response['username']
            : response['displayName'],
        email: response['email'] ?? "",
        loopsData:
            ResponseParsingHelper.getLoopsFromResponse(response['loopsData']),
        score: response['score'] as int,
        friendsIds: response['friendsIds'].cast<String>().toList(),
        requestsSent: response['requests']['sent'].cast<String>().toList(),
        requestsReceived:
            response['requests']['received'].cast<String>().toList());
  }

  static List<Loop> getLoopsFromResponse(dynamic response) {
    List<Loop> newLoops = [];
    response = response as List<dynamic>;
    for (int i = 0; i < response.length; i++) {
      Loop loop =
          parseLoop(response[i]['loop'], getLoopsType(response[i]['loopType']));
      newLoops.add(loop);
    }
    return newLoops;
  }

  static Loop parseLoop(dynamic loop, LoopType type) {
    List<dynamic> loopUsers = (loop['users'] as List).cast<dynamic>().toList();
    return Loop(
        atTimeEnding: DateTime.parse(loop['atTimeEnding']),
        currentUserId: loop['currentUserId'],
        name: loop['name'],
        type: type,
        numberOfMembers: loopUsers.length,
        avatars: getImagesMap(loopUsers),
        chatID: loop['chat'] as String,
        creatorId: loop['creatorId'] as String,
        id: loop['_id'],
        userIDs: parseLoopUsers(loopUsers));
  }

  static List<String> parseLoopUsers(dynamic users) {
    List<String> loopUsers = [];
    for (int i = 0; i < users.length; i++) {
      loopUsers.add(users[i]['user'] as String);
    }
    return loopUsers;
  }

  static Map<String, String> getImagesMap(dynamic users) {
    Map<String, String> images = {};
    for (int i = 0; i < users.length; i++) {
      images[users[i]['user']] = users[i]['avatarLink'] as String;
    }
    return images;
  }

  static LoopType getLoopsType(String type) {
    if (type == "NEW_LOOP") {
      return LoopType.NEW_LOOP;
    } else if (type == "NEW_NOTIFICATION") {
      return LoopType.NEW_NOTIFICATION;
    } else if (type == "EXISTING_LOOP") {
      return LoopType.EXISTING_LOOP;
    } else if (type == "INACTIVE_LOOP_SUCCESSFUL") {
      return LoopType.INACTIVE_LOOP_SUCCESSFUL;
    } else if (type == "INACTIVE_LOOP_FAILED") {
      return LoopType.INACTIVE_LOOP_FAILED;
    } else {
      return LoopType.NEW_LOOP;
    }
  }
}
