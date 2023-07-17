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
  int numberOfMembers;
  LoopType type;
  final List<String> userIDs; // will store the userIDs for all the loops
  String chatID;
  DateTime atTimeEnding;
  Map<String, String>
      avatars; // user id with their randomly generated avatar which is stored in the server

  Loop(
      {required this.id,
      required this.atTimeEnding,
      required this.currentUserId,
      required this.chatID,
      required this.creatorId,
      required this.name,
      required this.numberOfMembers,
      required this.type,
      required this.avatars,
      required this.userIDs});

  dynamic toJson() {
    return {
      'loop': {
        "atTimeEnding": this.atTimeEnding.toIso8601String(),
        'name': this.name,
        "chat": this.chatID,
        'creatorId': this.creatorId,
        '_id': this.id,
        'currentUserId': this.currentUserId,
        'users': loopUsersToJson()
      },
      'loopType': this.type.toString()
    };
  }

  dynamic loopUsersToJson() {
    var result = [];
    for (int i = 0; i < userIDs.length; i++) {
      result.add({'user': userIDs[i], 'avatarLink': avatars[userIDs[i]]});
    }
    return result;
  }

  @override
  bool operator ==(other) {
    // Dart ensures that operator== isn't called with null
    // if(other == null) {
    //   return false;
    // }
    if (other is! Loop) {
      return false;
    }
    return id == (other).id;
  }

  int _hashCode = 0;

  @override
  int get hashCode {
    return _hashCode;
  }
}
