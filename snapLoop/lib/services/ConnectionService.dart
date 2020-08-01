import 'dart:io';

import 'package:connectivity/connectivity.dart';
import 'package:injectable/injectable.dart';
import 'package:stacked/stacked.dart';

@lazySingleton
class ConnectionStatusService with ReactiveServiceMixin {
  bool connected = false;

  Future<void> initialize() async {
    Connectivity()
        .onConnectivityChanged
        .listen((ConnectivityResult result) async {
      if (result == ConnectivityResult.mobile ||
          result == ConnectivityResult.wifi) {
        try {
          final result = await InternetAddress.lookup('google.com');
          if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
            connected = true;
            notifyListeners();
          }
        } on SocketException catch (_) {
          connected = false;
          notifyListeners();
        }
      } else {
        connected = false;
        notifyListeners();
      }
      print(connected);
      notifyListeners();
    });
  }
}
