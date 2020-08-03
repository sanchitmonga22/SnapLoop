import 'package:SnapLoop/services/Auth.dart';
import 'package:SnapLoop/services/ChatDataService.dart';
import 'package:SnapLoop/services/ConnectionService.dart';
import 'package:SnapLoop/services/LoopsDataService.dart';
import 'package:SnapLoop/services/StorageService.dart';
import 'package:SnapLoop/services/UserDataService.dart';
import 'package:SnapLoop/services/socketService.dart';
import 'package:flutter/cupertino.dart';
import 'package:stacked/stacked.dart';
import 'Model/chat.dart';
import 'Model/responseParsingHelper.dart';
import 'Model/user.dart';
import 'app/locator.dart';

class MainViewModel extends ReactiveViewModel with WidgetsBindingObserver {
  final _auth = locator<Auth>();
  final _socket = locator<SocketService>();
  final _connectionService = locator<ConnectionStatusService>();
  final _loopDataService = locator<LoopsDataService>();
  final _chatDataService = locator<ChatDataService>();
  final _storageService = locator<StorageService>();
  final _userDataService = locator<UserDataService>();

  void createSocketConnection() {
    _socket.createSocketConnection();
  }

  ConnectionStatusService get connectionService => _connectionService;

  bool get isAuth => _auth.isAuth;

  Future<bool> tryAutoLogin() async {
    setBusy(true);
    WidgetsBinding.instance.addObserver(this);
    final _connectionService = locator<ConnectionStatusService>();
    await _connectionService.initialize();
    bool login = await _auth.tryAutoLogin();
    if (login && _connectionService.connected) {
      createSocketConnection();
    } else if (login && _connectionService.connected == false) {
      await initializeAppState();
    }
    notifyListeners();
    setBusy(false);
    return login;
  }

  @override
  List<ReactiveServiceMixin> get reactiveServices => [_auth];

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) async {
    switch (state) {
      case AppLifecycleState.paused:
        print(state);
        await saveAppState();
        break;
      case AppLifecycleState.detached:
        print(state);
        await saveAppState();
        break;
      default:
        break;
    }
  }

  @override
  void dispose() async {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  // save the app state before closing the app
  Future<void> saveAppState() async {
    await _storageService.clearAll();

    await _userDataService.updateUserData();
    await _userDataService.updateFriends();
    await _userDataService.updateRequests();
    _loopDataService.initializeLoopsFromUserData();

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

  // initializing the app state on startup
  Future<void> initializeAppState() async {
    dynamic userData = await _storageService.getValueFromKey('userData');
    _auth.user.value = ResponseParsingHelper.parseUser(userData, _auth.userId);
    _loopDataService.initializeLoopsFromUserData();

    List<String> chatIds = _loopDataService.getAllChatIds();
    _chatDataService.setChats([]);
    List<Chat> chats = [];
    chatIds.forEach((element) async {
      chats.add(await ResponseParsingHelper.parseChat(
          _storageService.getValueFromKey(element)));
    });
    _chatDataService.setChats(chats);

    List<String> frndIds = [];
    frndIds = _auth.user.value.friendsIds;
    List<FriendsData> frnds = [];
    for (int i = 0; i < frndIds.length; i++) {
      dynamic v = await _storageService.getValueFromKey(frndIds[i]);
      frnds.add(ResponseParsingHelper.parseFriend(v));
    }
    _userDataService.setFriends(frnds);

    List<String> reqsIds = [];
    reqsIds = _auth.user.value.requestsReceived;
    List<PublicUserData> reqs = [];
    reqsIds.forEach((element) async {
      reqs.add(ResponseParsingHelper.parsePublicUserData(
          await _storageService.getValueFromKey(element)));
    });
    _userDataService.setRequests(reqs);
  }
}
