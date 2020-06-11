import 'package:flutter/foundation.dart';

enum LoopType {
  NEW_LOOP,
  NEW_NOTIFICATION,
  EXISTING_LOOP,
  INACTIVE_LOOP_SUCCESSFUL,
  INACTIVE_LOOP_FAILED
}

class Loop {
  final String name;
  final int numberOfMembers;
  final LoopType type;
  List<Object> userIDs; // will store the userIDs for all the loops

  Loop(
      {@required this.name,
      @required this.numberOfMembers,
      @required this.type});
}
