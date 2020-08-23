// import 'dart:io';

// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_messaging/firebase_messaging.dart';
// import 'package:flutter/material.dart';

// class MessageHandler extends StatefulWidget {
//   MessageHandler({Key key}) : super(key: key);

//   @override
//   _MessageHandlerState createState() => _MessageHandlerState();
// }

// class _MessageHandlerState extends State<MessageHandler> {
//   final FirebaseFirestore _db = FirebaseFirestore.instance;
//   final FirebaseMessaging _fcm = FirebaseMessaging();

//   @override
//   void initState() {
//     super.initState();
//     if (Platform.isIOS) {
//       _fcm.onIosSettingsRegistered.listen((event) {
//         _saveDeviceToken();
//       });
//       _fcm.requestNotificationPermissions(IosNotificationSettings());
//     } else {
//       _saveDeviceToken();
//     }
//     _fcm.configure(
//       onMessage: (Map<String, dynamic> message) async {},
//       onResume: (Map<String, dynamic> message) async {},
//       onLaunch: (Map<String, dynamic> message) async {},
//     );
//   }

//   _saveDeviceToken() async {
//     String fcmToken = await _fcm.getToken();
//     //TODO: save this token in the node server!
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       child: child,
//     );
//   }
// }

// import 'package:flutter/material.dart';
// import 'package:flutter_local_notifications/flutter_local_notifications.dart';

// class LocalNotifications extends StatefulWidget {
//   LocalNotifications({Key key}) : super(key: key);

//   @override
//   _LocalNotificationsState createState() => _LocalNotificationsState();
// }

// class _LocalNotificationsState extends State<LocalNotifications> {
//   FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
//       FlutterLocalNotificationsPlugin();

//   @override
//   void initState() {
//     super.initState();
//     initialize();
//   }

//   void initialize() async {
//     // initialise the plugin. app_icon needs to be a added as a drawable resource to the Android head project
//     var initializationSettingsAndroid =
//         AndroidInitializationSettings('app_icon');
//     var initializationSettingsIOS = IOSInitializationSettings(
//         onDidReceiveLocalNotification: onDidReceiveLocalNotification);
//     var initializationSettings = InitializationSettings(
//         initializationSettingsAndroid, initializationSettingsIOS);
//     await flutterLocalNotificationsPlugin.initialize(initializationSettings,
//         onSelectNotification: onSelectNotification);
//   }

//   Future onSelectNotification(String payload) {
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       child: child,
//     );
//   }
// }
