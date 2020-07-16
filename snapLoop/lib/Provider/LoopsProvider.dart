import 'dart:convert';
import 'package:SnapLoop/Helper/loops.dart' as loopsies;
import 'package:SnapLoop/Model/HttpException.dart';
import 'package:SnapLoop/Model/loop.dart';
import 'package:SnapLoop/Model/user.dart';
import 'package:SnapLoop/constants.dart';
import 'package:flutter/widgets.dart';
import 'package:http/http.dart' as http;

///author: @sanchitmonga22
class LoopsProvider with ChangeNotifier {
  final String authToken;
  final String userId;
  List<Loop> _loops = [];
  final user;

  LoopsProvider(this.authToken, this._loops, this.userId, this.user);

  List<Loop> get loops {
    return [..._loops];
  }

  void addNewLoop(Loop loop) {
    _loops.add(loop);
    notifyListeners();
  }

  int get loopCount {
    return _loops.length;
  }

  // Future<void> fetchAndSetProducts() async {
  //   //http.Response res = await http.get('$SERVER_IP//');
  // }

// This will create the loop and send the first message to the friend
  // void createLoop(String name, String friendID, Object content) {
  //   Loop loop = new Loop(
  //       currentUserId: null,
  //       id: null,
  //       chatID: null,
  //       creatorId: null,
  //       name: name,
  //       numberOfMembers: null,
  //       type: null,
  //       userIDs: null);
  // }

  Future<Map<String, String>> getRandomURL(String friendId) async {
    try {
      http.Response res =
          await http.get('$SERVER_IP/loops/getRandomUrls', headers: {
        "Authorization": "Bearer " + authToken,
        "Content-Type": "application/json",
      });
      if (res.statusCode == 200) {
        final response = json.decode(res.body);
        return {
          // TODO : add a predefined image if the network image fails
          "$userId": response['url1'],
          "$friendId": response['url2'],
        };
      } else {
        throw new HttpException("could not generate random emojies");
      }
    } catch (err) {
      print(err);
      throw new HttpException(err);
    }
  }

  Future<Map<String, String>> createLoop(String name, String friendId,
      String content, String friendAvatar, String myAvatar) async {
    try {
      http.Response res = await http.post('$SERVER_IP/loops/create',
          headers: {
            "Authorization": "Bearer " + authToken,
            "Content-Type": "application/json",
          },
          body: jsonEncode({
            "content": content,
            "name": name,
            "forwardedToId": friendId,
            "forwardedToAvatar": friendAvatar,
            "senderAvatar": myAvatar,
          }));
      final response = json.decode(res.body);
      print(response);
      if (res.statusCode == 200) {
        print("loop created successfully");
        notifyListeners();
        return response;
      } else {
        return null;
      }
    } catch (err) {
      print(err);
      throw new HttpException("loop creation failed due to :$err");
    }
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

  // TODO : make an API call
  bool loopExistsWithName(String name) {
    bool exists = false;
    // loops.forEach((loop) {
    //   if (loop.name.toLowerCase() == name.trim().toLowerCase()) {
    //     exists = true;
    //   }
    // });
    return exists;
  }
}
