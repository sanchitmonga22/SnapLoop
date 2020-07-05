import 'package:SnapLoop/Helper/loops.dart' as loopsies;
import 'package:SnapLoop/Model/loop.dart';
import 'package:flutter/widgets.dart';

///author: @sanchitmonga22
class LoopsProvider with ChangeNotifier {
  List<Loop> _loops = loopsies.loops;

  List<Loop> get loops {
    return [..._loops];
  }

  int get loopCount {
    return _loops.length;
  }

// This will create the loop and send the first message to the friend
  void createLoop(String name, String friendID, Object content) {
    Loop loop = new Loop(
        id: null,
        chatID: null,
        creatorId: null,
        name: name,
        numberOfMembers: null,
        type: null,
        userIDs: null);
  }

  Loop findByName(String name) {
    return _loops.firstWhere((loop) => loop.name == name);
  }

  // if there is already a loop with the same name in the database
  bool loopExistsWithName(String name) {
    bool exists = false;
    loops.forEach((loop) {
      if (loop.name.toLowerCase() == name.trim().toLowerCase()) {
        exists = true;
      }
    });
    return exists;
  }
}
