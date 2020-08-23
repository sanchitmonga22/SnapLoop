import 'dart:io';

import 'package:SnapLoop/Model/CloudMessage.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:injectable/injectable.dart';
import 'package:stacked/stacked.dart';

@lazySingleton
class CloudMessagingService with ReactiveServiceMixin {
  final FirebaseMessaging _fcm = FirebaseMessaging();

  initialize() async {
    if (Platform.isIOS) {
      _fcm.onIosSettingsRegistered.listen((event) {
        _saveDeviceToken();
      });
      _fcm.requestNotificationPermissions(IosNotificationSettings());
    } else {
      _saveDeviceToken();
    }
    _fcm.configure(
      onMessage: (Map<String, dynamic> message) async {
        _handleMessage(_setMessage(message));
        print("onMessage $message");
      },
      onResume: (Map<String, dynamic> message) async {
        _handleMessage(_setMessage(message));
        print("onResume $message");
      },
      onLaunch: (Map<String, dynamic> message) async {
        _handleMessage(_setMessage(message));
        print("onLaunch $message");
      },
    );
  }

  _saveDeviceToken() async {
    String fcmToken = await _fcm.getToken();
    print(fcmToken);
    //TODO: save this token in the node server!
  }

  CloudMessage _setMessage(Map<String, dynamic> message) {
    return CloudMessage(
        body: message['notification']['body'],
        message: message['data']['message'],
        title: message['notification']['title']);
  }

  _handleMessage(CloudMessage message) {
    switch (message.title) {
      case "newMessage":
        break;
      case "requestReceived":
        break;
      case "requestAccepted":
        break;
      case "newLoop":
        break;
      case "canCreateNewLoop":
        break;
    }
  }
}
