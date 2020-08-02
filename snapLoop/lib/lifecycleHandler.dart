import 'package:flutter/widgets.dart';
import 'package:flutter/material.dart';

class LifeCycleEventHandler extends WidgetsBindingObserver {
  @override
  void didChangeAppLifecycleState(AppLifecycleState state) async {
    super.didChangeAppLifecycleState(state);
    print(state);
  }
}
