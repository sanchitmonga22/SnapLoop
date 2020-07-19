import 'package:SnapLoop/Helper/customRoute.dart';
import 'package:SnapLoop/Helper/users.dart';
import 'package:SnapLoop/Model/user.dart';
import 'package:SnapLoop/Provider/Auth.dart';
import 'package:SnapLoop/Provider/ChatProvider.dart';
import 'package:SnapLoop/Provider/LoopsProvider.dart';
import 'package:SnapLoop/Provider/UserDataProvider.dart';
import 'package:SnapLoop/Screens/Authorization/authScreen.dart';
import 'package:SnapLoop/Screens/Chat/ExistingLoopChatScreen.dart';
import 'package:SnapLoop/Screens/Chat/newLoopChatScreen.dart';
import 'package:SnapLoop/Screens/Contacts/FriendsScreen.dart';
import 'package:SnapLoop/Socket.io/appInitializer.dart';
import 'package:SnapLoop/Socket.io/dependencyInjection.dart';
import 'package:SnapLoop/Widget/FloatingActionButton.dart';
import 'package:SnapLoop/Screens/NavBar.dart';
import 'package:SnapLoop/Screens/UserProfile/userProfile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_simple_dependency_injection/injector.dart';
import 'package:provider/provider.dart';
import './Screens/Home/homeScreen.dart';
import 'Screens/splashScreen.dart';
import 'Socket.io/socketService.dart';

Injector injector;

/// author: @sanchitmonga22
void main() async {
  DependencyInjection().initialise(Injector.getInjector());
  injector = Injector.getInjector();
  await AppInitializer().initialise(injector);
  runApp(SnapLoop());
}

class SnapLoop extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final SocketService socketService = injector.get<SocketService>();
    socketService.createSocketConnection();
    return MultiProvider(
        providers: [
          // using with socket.io
          // StreamProvider(
          //   create: (context) {},
          //   builder: (context, child) {},
          // ),
          ChangeNotifierProvider(
            create: (context) => Auth(),
          ),
          ChangeNotifierProxyProvider<Auth, LoopsProvider>(create: (context) {
            return LoopsProvider(
                "",
                [],
                "",
                User(
                    numberOfLoopsRemaining: 5,
                    loopsData: [],
                    contacts: [],
                    userID: "",
                    username: "",
                    displayName: "",
                    email: "",
                    score: 0,
                    friendsIds: [],
                    requestsSent: [],
                    requestsReceived: []));
          }, update: (context, auth, previousLoopsProvider) {
            return LoopsProvider(
                auth.token,
                previousLoopsProvider.loops == null
                    ? []
                    : previousLoopsProvider.loops,
                auth.userId,
                auth.user);
          }),
          ChangeNotifierProxyProvider<Auth, UserDataProvider>(
              create: (context) {
            return UserDataProvider(
              User(
                  numberOfLoopsRemaining: 5,
                  loopsData: [],
                  contacts: [],
                  userID: "",
                  username: "",
                  displayName: "",
                  email: "",
                  score: 0,
                  friendsIds: [],
                  requestsSent: [],
                  requestsReceived: []),
              "",
              "",
            );
          }, update: (context, auth, previousUserDataProvider) {
            return UserDataProvider(
              auth.user,
              auth.userId,
              auth.token,
            );
          }),
          ChangeNotifierProxyProvider<Auth, ChatProvider>(
            create: (context) {
              return ChatProvider("", "", []);
            },
            update: (context, auth, previousChatProvider) {
              return ChatProvider(
                  auth.token,
                  auth.userId,
                  previousChatProvider.chats == null
                      ? []
                      : previousChatProvider.chats);
            },
          ),
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
              // home: AuthScreen(),
              home: authData.isAuth
                  ? NavBar()
                  : FutureBuilder(
                      future: authData.tryAutoLogin(),
                      builder: (context, authResultsnapshot) {
                        return authResultsnapshot.connectionState ==
                                ConnectionState.waiting
                            ? SplashScreen()
                            : AuthScreen();
                      },
                    ),
              routes: {
                FriendsScreen.routeName: (context) => FriendsScreen(),
                ExistingLoopChatScreen.routeName: (context) =>
                    ExistingLoopChatScreen(),
                NavBar.routeName: (context) => NavBar(),
                AuthScreen.routeName: (context) => AuthScreen(),
                HomeScreen.routeName: (context) => HomeScreen(),
                NewLoopChatScreen.routeName: (context) => NewLoopChatScreen(),
                UserProfile.routeName: (context) => UserProfile()
              });
        }));
  }
}
