import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';

/// author: @sanchitmonga22

enum LoopType {
  // a loop that is new that has to be forwared within 24 hrs
  NEW_LOOP,
  // a loop with a new notification and is active
  NEW_NOTIFICATION,
  // Loop with no new notification but is still active
  EXISTING_LOOP,
  // Loop that has finished successfully
  INACTIVE_LOOP_SUCCESSFUL,
  // Loop that failed to finish
  INACTIVE_LOOP_FAILED,
  // dont know the loop type
  UNIDENTIFIED,
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
  DateTime atTimeEnding;
  Map<String, String>
      avatars; // user id with their randomly generated avatar which is stored in the server

  Loop(
      {@required this.id,
      this.timeSent,
      this.atTimeEnding,
      @required this.currentUserId,
      @required this.chatID,
      @required this.creatorId,
      @required this.name,
      @required this.numberOfMembers,
      @required this.type,
      this.avatars,
      @required this.userIDs});
}
