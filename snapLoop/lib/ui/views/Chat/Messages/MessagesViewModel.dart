import 'package:SnapLoop/Model/chat.dart';
import 'package:SnapLoop/Model/loop.dart';
import 'package:SnapLoop/app/locator.dart';
import 'package:SnapLoop/services/ChatDataService.dart';
import 'package:SnapLoop/services/LoopsDataService.dart';
import 'package:SnapLoop/services/UserDataService.dart';
import 'package:stacked/stacked.dart';

class MessagesViewModel extends ReactiveViewModel {
  final _chatDataService = locator<ChatDataService>();
  final _loopDataService = locator<LoopsDataService>();
  final _userDataService = locator<UserDataService>();

  Loop _loop;
  Loop get loop => _loop;

  String _myId;
  String get myId => _myId;

  List<ChatInfo> _chat;
  List<ChatInfo> get chat => _chat;

  void initialize(String loopId) {
    if (loopId != "") {
      _loop = _loopDataService.findById(loopId);
      _myId = _userDataService.userId;
      _chat = _chatDataService.getChatById(_loop.chatID).chat.reversed.toList();
    }
  }

  @override
  List<ReactiveServiceMixin> get reactiveServices => [_chatDataService];
}
