import 'dart:convert';
import 'package:SnapLoop/Model/HttpException.dart';
import 'package:SnapLoop/Model/loop.dart';
import 'package:SnapLoop/Model/responseParsingHelper.dart';
import 'package:SnapLoop/app/locator.dart';
import 'package:SnapLoop/constants.dart';
import 'package:SnapLoop/services/Auth.dart';
import 'package:SnapLoop/services/UserDataService.dart';
import 'package:http/http.dart' as http;
import 'package:injectable/injectable.dart';
import 'package:observable_ish/set/set.dart';
import 'package:stacked/stacked.dart';

///author: @sanchitmonga22
@lazySingleton
class LoopsDataService with ReactiveServiceMixin {
  LoopsDataService() {
    listenToReactiveValues([_loops]);
  }
  final _auth = locator<Auth>();
  final _userDataService = locator<UserDataService>();
  RxSet<Loop> _loops = RxSet<Loop>();

  List<Loop> get loops {
    return [..._loops.toList()];
  }

// TODO: FIXME: weird behavior (maybe)
  void initializeLoopsFromUserData() {
    _loops.addAll(_auth.user.value.loopsData);
    _loops.toSet();
    if (_loops == null) {
      _loops = RxSet<Loop>();
    }
  }

  void addNewLoop(Loop loop) {
    _loops.add(loop);
  }

  int get loopCount {
    return _loops.length;
  }

  void updateLoopEndTimer(String loopId, DateTime atTimeEnding) {
    _loops.firstWhere((element) => element.id == loopId).atTimeEnding =
        atTimeEnding;
    notifyListeners();
  }

  Future<List<dynamic>> getRandomAvatarURL(int count) async {
    try {
      http.Response res =
          await http.get('$SERVER_IP/loops/getRandomUrls', headers: {
        "Authorization": "Bearer " + _auth.token,
        "Content-Type": "application/json",
        "count": count.toString(),
      });
      if (res.statusCode == 200) {
        final response = json.decode(res.body);
        return response;
      } else {
        throw new HttpException("could not generate random emojies");
      }
    } catch (err) {
      throw new HttpException(err);
    }
  }

  // updating the imageUrl to a number to get it from the assets
  void updateImageUrlToNumber(String loopId, String userId, int number) {
    _loops.firstWhere((element) => element.id == loopId).avatars[userId] =
        number.toString();
    // TODO: make an api call and tell the number to the network and update the image
  }

  Future<dynamic> forwardLoop(
      String friendId, String content, String chatId, String loopId) async {
    try {
      http.Response res = await http.post('$SERVER_IP/loops/forwardLoop',
          headers: {
            "Authorization": "Bearer " + _auth.token,
            "Content-Type": "application/json",
          },
          body: jsonEncode({
            "content": content,
            "forwardedToId": friendId,
            "chatId": chatId,
            "loopId": loopId
          }));
      final response = json.decode(res.body);
      if (res.statusCode == 200) {
        updateForwardedLoop(response, loopId, friendId);
        return response;
      } else {
        throw new HttpException(res.body);
      }
    } catch (err) {
      throw new HttpException(err);
    }
  }

  void updateForwardedLoop(
      dynamic result, String loopId, String friendId) async {
    _loops.forEach((loop) {
      if (loop.id == loopId) {
        loop.type = ResponseParsingHelper.getLoopsType(result['loopType']);
        loop.currentUserId = friendId;
        if (loop.type != LoopType.INACTIVE_LOOP_SUCCESSFUL) {
          loop.atTimeEnding =
              DateTime.fromMillisecondsSinceEpoch(result['sentTime'])
                  .add(Duration(days: 1));
          // adding the memoji for the new user added to the loop
          loop.avatars[friendId] = result['memoji'];
          loop.numberOfMembers++;
          loop.userIDs.add(friendId);
        }
      }
    });
  }

  void updateExistingLoop(dynamic result) {
    _loops.forEach((loop) {
      if (loop.id == result['loopId']) {
        loop.atTimeEnding =
            DateTime.fromMillisecondsSinceEpoch(result['atTimeEnding']);
        loop.type = ResponseParsingHelper.getLoopsType(result['loopType']);
        String newUserId = result['newUser']['user'];
        loop.userIDs.add(newUserId);
        loop.avatars[newUserId] = result['newUser']['avatarLink'];
        loop.currentUserId = newUserId;
        loop.numberOfMembers++;
        if (loop.type == LoopType.INACTIVE_LOOP_SUCCESSFUL) {
          //TODO:
          // do a lot of stuff
        }
      }
    });
    notifyListeners();
  }

  Future<Map<String, dynamic>> createLoop(String name, String friendId,
      String content, String friendAvatar, String myAvatar) async {
    try {
      http.Response res = await http.post('$SERVER_IP/loops/create',
          headers: {
            "Authorization": "Bearer " + _auth.token,
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
      if (res.statusCode == 200) {
        _userDataService.updateLoopsRemaining();
        return response;
      } else {
        return null;
      }
    } catch (err) {
      throw new HttpException("loop creation failed due to :$err");
    }
  }

  Loop findByName(String name) {
    return _loops.firstWhere((loop) => loop.name == name);
  }

  Loop findById(String id) {
    return _loops.firstWhere((element) => element.id == id);
  }

  List<Loop> getLoopInforByIds(List<String> id) {
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

  bool loopExistsWithName(String name) {
    bool exists = false;
    _loops.forEach((loop) {
      if (loop.name.toLowerCase() == name.trim().toLowerCase()) {
        exists = true;
      }
    });
    return exists;
  }
}
