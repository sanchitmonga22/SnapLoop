import 'dart:ui';

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
  final String id;
  final String name;
  final String creatorId;
  final int numberOfMembers;
  final LoopType type;
  final List<String> userIDs; // will store the userIDs for all the loops
  final String chatID;
  final Map<String, Image>
      avatars; // user id with their randomly generated avatar which is stored in the server

  Loop(
      {@required this.id,
      @required this.chatID,
      @required this.creatorId,
      @required this.name,
      @required this.numberOfMembers,
      @required this.type,
      this.avatars,
      @required this.userIDs});
}
