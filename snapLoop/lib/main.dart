import 'package:SnapLoop/Provider/LoopsProvider.dart';
import 'package:SnapLoop/Screens/Authorization/authScreen.dart';
import 'package:SnapLoop/Screens/CompletedLoops/completedLoops.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import './Screens/Home/homeScreen.dart';

void main() {
  runApp(SnapLoop());
}

class SnapLoop extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [ChangeNotifierProvider.value(value: LoopsProvider())],
        child: MaterialApp(
            title: 'Flutter Demo',
            theme: ThemeData(
              primarySwatch: Colors.purple,
              accentColor: Colors.grey.shade600,
              visualDensity: VisualDensity.adaptivePlatformDensity,
            ),
            // home: AuthScreen(),
            home: HomeScreen(),
            routes: {
              HomeScreen.routeName: (context) => HomeScreen(),
              CompletedLoopsScreen.routeName: (context) =>
                  CompletedLoopsScreen()
            }));
  }
}
