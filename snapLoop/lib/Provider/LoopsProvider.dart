import 'package:SnapLoop/Helper/loops.dart' as loopsies;
import 'package:SnapLoop/Model/loop.dart';
import 'package:SnapLoop/constants.dart';
import 'package:flutter/widgets.dart';
import 'package:http/http.dart' as http;

///author: @sanchitmonga22
class LoopsProvider with ChangeNotifier {
  final String authToken;
  final String userId;
  List<Loop> _loops = [];

  LoopsProvider(this.authToken, this._loops, this.userId);

  List<Loop> get loops {
    return [..._loops];
  }

  int get loopCount {
    return _loops.length;
  }

  Future<void> fetchAndSetProducts() async {
    http.Response res = await http.get('$SERVER_IP//');
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

  List<Loop> getLoopInforById(List<String> id) {
    List<Loop> friendsLoops = [];
    id.forEach((e) {
      _loops.forEach((element) {
        if (e == element.id) {
          friendsLoops.add(element);
        }
      });
    });
    return friendsLoops;
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
