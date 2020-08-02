import 'dart:io';

import 'package:connectivity/connectivity.dart';
import 'package:injectable/injectable.dart';
import 'package:stacked/stacked.dart';

@lazySingleton
class ConnectionStatusService with ReactiveServiceMixin {
  bool connected = false;

  Future<void> initialize() async {
    var connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.mobile ||
        ConnectivityResult.wifi == connectivityResult) connected = true;
    notifyListeners();
    listenToStream();
  }

  Future<void> listenToStream() async {
    Connectivity()
        .onConnectivityChanged
        .listen((ConnectivityResult result) async {
      setConnectivityStatus(result);
      print(connected);
      notifyListeners();
    });
  }

  Future<void> setConnectivityStatus(ConnectivityResult result) async {
    if (result == ConnectivityResult.mobile ||
        result == ConnectivityResult.wifi) {
      try {
        final result = await InternetAddress.lookup('google.com');
        if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
          connected = true;
        }
      } on SocketException catch (_) {
        connected = false;
      }
    } else {
      connected = false;
    }
  }
}
