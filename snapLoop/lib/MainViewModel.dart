import 'package:SnapLoop/Model/responseParsingHelper.dart';
import 'package:SnapLoop/Model/user.dart';
import 'package:SnapLoop/services/Auth.dart';
import 'package:SnapLoop/services/ChatDataService.dart';
import 'package:SnapLoop/services/ConnectionService.dart';
import 'package:SnapLoop/services/LoopsDataService.dart';
import 'package:SnapLoop/services/StorageService.dart';
import 'package:SnapLoop/services/UserDataService.dart';
import 'package:SnapLoop/services/socketService.dart';
import 'package:stacked/stacked.dart';

import 'Model/chat.dart';
import 'app/locator.dart';

class MainViewModel extends ReactiveViewModel {
  final _auth = locator<Auth>();
  final _socket = locator<SocketService>();
  final _loopDataService = locator<LoopsDataService>();
  final _userDataService = locator<UserDataService>();
  final _chatDataService = locator<ChatDataService>();
  final _connectionService = locator<ConnectionStatusService>();
  StorageService _storageService = locator<StorageService>();

  final firstTime = true;

  void createSocketConnection() {
    _socket.createSocketConnection();
  }

  ConnectionStatusService get connectionService => _connectionService;

  bool get isAuth => _auth.isAuth;

  Future<bool> tryAutoLogin() async {
    setBusy(true);
    bool login = await _auth.tryAutoLogin();
    if (login && _connectionService.connected) {
      createSocketConnection();
    } else if (login && !_connectionService.connected) {
      await initializeAppState();
    }
    notifyListeners();
    setBusy(false);
    return login;
  }

  @override
  List<ReactiveServiceMixin> get reactiveServices => [_auth];

  // save the app state before leaving,
  Future<void> saveAppState() async {
    await _storageService.clearAll();
    await _storageService.addNewKeyValue(
        "userData", _userDataService.user.toJson());
    List<FriendsData> _frnds = _userDataService.friends;
    _frnds.forEach((frnd) async {
      await _storageService.addNewKeyValue(frnd.userID, frnd.toJson());
    });
    List<PublicUserData> _reqs = _userDataService.requests;
    _reqs.forEach((req) async {
      await _storageService.addNewKeyValue(req.userID, req.toJson());
    });
    List<Chat> _chats = _chatDataService.chats;
    _chats.forEach((chat) async {
      await _storageService.addNewKeyValue(chat.chatID, chat.toJson());
    });
  }

  Future<void> initializeAppState() async {
    _auth.user.value = ResponseParsingHelper.parseUser(
        await _storageService.getValueFromKey('userData'), _auth.userId);
    _loopDataService.initializeLoopsFromUserData();

    List<String> chatIds = _loopDataService.getAllChatIds();
    _chatDataService.setChats([]);
    List<Chat> chats = [];
    chatIds.forEach((element) async {
      chats.add(await ResponseParsingHelper.parseChat(
          _storageService.getValueFromKey(element)));
    });
    _chatDataService.setChats(chats);

    List<String> frndIds = _auth.user.value.friendsIds;
    List<FriendsData> frnds = [];
    frndIds.forEach((element) async {
      frnds.add(ResponseParsingHelper.parseFriend(
          await _storageService.getValueFromKey(element)));
    });
    _userDataService.setFriends(frnds);

    List<String> reqsIds = _auth.user.value.requestsReceived;
    List<PublicUserData> reqs = [];
    reqsIds.forEach((element) async {
      reqs.add(ResponseParsingHelper.parsePublicUserData(
          await _storageService.getValueFromKey(element)));
    });
    _userDataService.setRequests(reqs);
  }

  @override
  void dispose() async {
    // TODO: implement dispose
    super.dispose();
    await saveAppState();
  }
}
