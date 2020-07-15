import 'package:SnapLoop/Model/loop.dart';
import 'package:flutter/cupertino.dart';

class ResponseParsingHelper {
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
        name: loop['name'],
        type: getLoopsType(loop['type']),
        numberOfMembers: loopUsers.length,
        avatars: getImagesMap(loopUsers),
        chatID: loop['chat'] as String,
        creatorId: loop['creatorId'] as String,
        id: loop._id,
        userIDs: loop['users']);
  }

  static Map<String, Image> getImagesMap(dynamic users) {
    Map<String, Image> images = {};
    users = users;
    for (int i = 0; i < users.length; i++) {
      images[users[i]['user']] =
          // TODO:add an image returned when a image url is not correct
          Image(image: NetworkImage(users[i]['avatarLink']));
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
