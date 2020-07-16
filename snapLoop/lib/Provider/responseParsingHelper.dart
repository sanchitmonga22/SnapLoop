import 'package:SnapLoop/Model/loop.dart';
import 'package:SnapLoop/Model/user.dart';
import 'package:flutter/cupertino.dart';

class ResponseParsingHelper {
  static User parseUser(dynamic response, String email, String userId) {
    return User(
        numberOfLoopsRemaining: response['numberOfLoopsRemaining'],
        contacts: (response["contacts"] as List).cast<String>().toList(),
        userID: userId,
        username: response['username'] as String ?? "",
        displayName: response['displayName'] == ""
            ? response['username']
            : response['displayName'],
        email: email == "" ? response['email'] : email,
        loopsData:
            ResponseParsingHelper.getLoopsFromResponse(response['loopsData']),
        score: response['score'] as int,
        friendsIds: (response['friendsIds'] as List).cast<String>().toList(),
        requestsSent: response['requests']['sent'].cast<String>().toList(),
        requestsReceived:
            response['requests']['received'].cast<String>().toList());
  }

  static List<Loop> getLoopsFromResponse(dynamic response) {
    List<Loop> newLoops;
    response = response as List<dynamic>;
    for (int i = 0; i < response.length; i++) {
      newLoops.add(parseLoop(response[i]));
    }
    return newLoops;
  }

  static Loop parseLoop(dynamic loop) {
    List<dynamic> loopUsers = (loop['users'] as List).cast<dynamic>().toList();
    return Loop(
        currentUserId: loop['currentUserId'],
        name: loop['name'],
        type: getLoopsType(loop['type']),
        numberOfMembers: loopUsers.length,
        avatars: getImagesMap(loopUsers),
        chatID: loop['chat'] as String,
        creatorId: loop['creatorId'] as String,
        id: loop._id,
        userIDs: loop['users']);
  }

  static Map<String, String> getImagesMap(dynamic users) {
    Map<String, String> images = {};
    users = users;
    for (int i = 0; i < users.length; i++) {
      // TODO:add an image returned when a image url is not correct
      images[users[i]['user']] = users[i]['avatarLink'];
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
      return null;
    }
  }
}
