import 'package:SnapLoop/Helper/customRoute.dart';
import 'package:SnapLoop/Provider/Auth.dart';
import 'package:SnapLoop/Provider/LoopsProvider.dart';
import 'package:SnapLoop/Provider/UserDataProvider.dart';
import 'package:SnapLoop/Screens/Authorization/authScreen.dart';
import 'package:SnapLoop/Screens/Chat/ExistingLoopChatScreen.dart';
import 'package:SnapLoop/Screens/Chat/newLoopChatScreen.dart';
import 'package:SnapLoop/Screens/Contacts/ContactsScreen.dart';
import 'package:SnapLoop/Screens/FloatingActionButton.dart';
import 'package:SnapLoop/Screens/NavBar.dart';
import 'package:SnapLoop/Screens/UserProfile/userProfile.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import './Screens/Home/homeScreen.dart';

/// author: @sanchitmonga22
void main() {
  runApp(SnapLoop());
}

class SnapLoop extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
          ChangeNotifierProvider(
            create: (context) => Auth(),
          ),
          ChangeNotifierProxyProvider<Auth, LoopsProvider>(create: (context) {
            return LoopsProvider();
          }, update: (context, auth, previousLoopsProvider) {
            return LoopsProvider();
          }),
          ChangeNotifierProxyProvider<Auth, UserDataProvider>(
              create: (context) {
            return UserDataProvider();
          }, update: (context, auth, previousLoopsProvider) {
            return UserDataProvider();
          }),
          ChangeNotifierProvider(
            create: (context) => FloatingActionButtonDataChanges(),
          ),
        ],
        child: Consumer<Auth>(builder: (context, authData, child) {
          return MaterialApp(
              title: 'SnapLoop',
              theme: ThemeData(
                  fontFamily: 'Open Sans',
                  // appBarTheme:
                  //     AppBarTheme(color: Color.fromRGBO(74, 20, 140, 0.7)),
                  // primarySwatch: Colors.deepPurple,
                  // accentColor: Colors.grey.shade600,
                  // textTheme:
                  //     TextTheme(button: TextStyle(color: Colors.white70)),
                  visualDensity: VisualDensity.adaptivePlatformDensity,
                  pageTransitionsTheme: PageTransitionsTheme(builders: {
                    TargetPlatform.android: CustomPageTransitionBuilder(),
                    TargetPlatform.iOS: CustomPageTransitionBuilder()
                  })),
              // darkTheme: ThemeData(
              //   brightness: Brightness.dark,
              // ),
              home: AuthScreen(),
              // home: authData.isAuth
              //     ? HomeScreen()
              //     : FutureBuilder(
              //         future: authData.tryAutoLogin(),
              //         builder: (context, authResultsnapshot) {
              //           return authResultsnapshot.connectionState ==
              //                   ConnectionState.waiting
              //               ? SplashScreen()
              //               : AuthScreen();
              //         },
              //       ),
              routes: {
                ExistingLoopChatScreen.routeName: (context) =>
                    ExistingLoopChatScreen(),
                NavBar.routeName: (context) => NavBar(),
                AuthScreen.routeName: (context) => AuthScreen(),
                HomeScreen.routeName: (context) => HomeScreen(),
                ContactScreen.routeName: (context) => ContactScreen(),
                NewLoopChatScreen.routeName: (context) => NewLoopChatScreen(),
                UserProfile.routeName: (context) => UserProfile()
              });
        }));
  }
}
