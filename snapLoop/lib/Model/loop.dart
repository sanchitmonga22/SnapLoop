import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';

/// author: @sanchitmonga22

enum LoopType {
  NEW_LOOP,
  NEW_NOTIFICATION,
  EXISTING_LOOP,
  INACTIVE_LOOP_SUCCESSFUL,
  INACTIVE_LOOP_FAILED,
}

class Loop {
  String id;
  final String name;
  final String creatorId;
  String currentUserId;
  DateTime timeSent;
  int numberOfMembers;
  LoopType type;
  final List<String> userIDs; // will store the userIDs for all the loops
  String chatID;
  Map<String, String>
      avatars; // user id with their randomly generated avatar which is stored in the server

  Loop(
      {@required this.id,
      this.timeSent,
      @required this.currentUserId,
      @required this.chatID,
      @required this.creatorId,
      @required this.name,
      @required this.numberOfMembers,
      @required this.type,
      this.avatars,
      @required this.userIDs});
}
