import 'package:SnapLoop/Screens/Authorization/authScreen.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(SnapLoop());
}

class SnapLoop extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.green,
        accentColor: Colors.green.shade500,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: AuthScreen(),
    );
  }
}
