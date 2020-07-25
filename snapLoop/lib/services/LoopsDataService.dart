import 'dart:convert';
import 'package:SnapLoop/Model/HttpException.dart';
import 'package:SnapLoop/Model/loop.dart';
import 'package:SnapLoop/app/locator.dart';
import 'package:SnapLoop/constants.dart';
import 'package:SnapLoop/services/Auth.dart';
import 'package:http/http.dart' as http;
import 'package:injectable/injectable.dart';
import 'package:observable_ish/value/value.dart';
import 'package:stacked/stacked.dart';

///author: @sanchitmonga22
@lazySingleton
class LoopsDataService with ReactiveServiceMixin {
  LoopsDataService() {
    listenToReactiveValues([]);
  }
  final _auth = locator<Auth>();
  RxValue<List<Loop>> _loops = RxValue<List<Loop>>(initial: []);

  List<Loop> get loops {
    return [..._loops.value];
  }

  void initializeLoopsFromUserData() {
    _loops = _auth.user.loopsData;
    if (_loops == null) {
      _loops.value = [];
    }
  }

  void addNewLoop(Loop loop) {
    _loops.value.add(loop);
  }

  int get loopCount {
    return _loops.value.length;
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

  Future<void> forwardLoop(String friendId, String content, String friendAvatar,
      String chatId, String loopId) async {
    try {
      http.Response res = await http.post('$SERVER_IP/loops/forwardLoop',
          headers: {
            "Authorization": "Bearer " + _auth.token,
            "Content-Type": "application/json",
          },
          body: jsonEncode({
            "content": content,
            "forwardedToId": friendId,
            "forwardedToAvatar": friendAvatar,
            "chatId": chatId,
            "loopId": loopId
          }));
      if (res.statusCode == 200) {
        return;
      } else {
        throw new HttpException(res.body);
      }
    } catch (err) {
      throw new HttpException(err.toString());
    }
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
        return response;
      } else {
        return null;
      }
    } catch (err) {
      throw new HttpException("loop creation failed due to :$err");
    }
  }

  Loop findByName(String name) {
    return _loops.value.firstWhere((loop) => loop.name == name);
  }

  Loop findById(String id) {
    return _loops.value.firstWhere((element) => element.id == id);
  }

  List<Loop> getLoopInforByIds(List<String> id) {
    List<Loop> friendsLoops = [];
    id.forEach((e) {
      _loops.value.forEach((element) {
        if (e == element.id) {
          friendsLoops.add(element);
        }
      });
    });
    return friendsLoops;
  }

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
