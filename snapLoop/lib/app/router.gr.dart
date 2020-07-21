// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouteGenerator
// **************************************************************************

// ignore_for_file: public_member_api_docs

import 'package:auto_route/auto_route.dart';
import 'package:flutter/cupertino.dart';

import '../Model/loop.dart';
import '../Model/user.dart';
import '../ui/views/Auth/AuthView.dart';
import '../ui/views/Contacts/FriendsView.dart';
import '../ui/views/Home/homeView.dart';
import '../ui/views/NavBar/NavBar.dart';
import '../ui/views/Profile/UserProfileView.dart';
import '../ui/views/chat/ExistingLoopChatScreen.dart';
import '../ui/views/chat/newLoopChatScreen.dart';

class Routes {
  static const String navBar = '/';
  static const String homeScreen = '/home-screen';
  static const String friendsScreen = '/friends-screen';
  static const String existingLoopChatScreen = '/existing-loop-chat-screen';
  static const String authScreen = '/auth-screen';
  static const String newLoopChatScreen = '/new-loop-chat-screen';
  static const String userProfile = '/user-profile';
  static const all = <String>{
    navBar,
    homeScreen,
    friendsScreen,
    existingLoopChatScreen,
    authScreen,
    newLoopChatScreen,
    userProfile,
  };
}

class Router extends RouterBase {
  @override
  List<RouteDef> get routes => _routes;
  final _routes = <RouteDef>[
    RouteDef(Routes.navBar, page: NavBar),
    RouteDef(Routes.homeScreen, page: HomeScreen),
    RouteDef(Routes.friendsScreen, page: FriendsScreen),
    RouteDef(Routes.existingLoopChatScreen, page: ExistingLoopChatScreen),
    RouteDef(Routes.authScreen, page: AuthScreen),
    RouteDef(Routes.newLoopChatScreen, page: NewLoopChatScreen),
    RouteDef(Routes.userProfile, page: UserProfile),
  ];
  @override
  Map<Type, AutoRouteFactory> get pagesMap => _pagesMap;
  final _pagesMap = <Type, AutoRouteFactory>{
    NavBar: (data) {
      var args = data.getArgs<NavBarArguments>(
        orElse: () => NavBarArguments(),
      );
      return buildAdaptivePageRoute<dynamic>(
        builder: (context) => NavBar(key: args.key),
        settings: data,
      );
    },
    HomeScreen: (data) {
      var args = data.getArgs<HomeScreenArguments>(
        orElse: () => HomeScreenArguments(),
      );
      return buildAdaptivePageRoute<dynamic>(
        builder: (context) => HomeScreen(
          key: args.key,
          completedLoopsScreen: args.completedLoopsScreen,
        ),
        settings: data,
        cupertinoTitle: 'Home',
      );
    },
    FriendsScreen: (data) {
      var args = data.getArgs<FriendsScreenArguments>(
        orElse: () => FriendsScreenArguments(),
      );
      return buildAdaptivePageRoute<dynamic>(
        builder: (context) => FriendsScreen(
          key: args.key,
          loopName: args.loopName,
          loopForwarding: args.loopForwarding,
        ),
        settings: data,
        cupertinoTitle: 'friends',
      );
    },
    ExistingLoopChatScreen: (data) {
      var args = data.getArgs<ExistingLoopChatScreenArguments>(
        orElse: () => ExistingLoopChatScreenArguments(),
      );
      return buildAdaptivePageRoute<dynamic>(
        builder: (context) => ExistingLoopChatScreen(
          key: args.key,
          radius: args.radius,
          loop: args.loop,
        ),
        settings: data,
        cupertinoTitle: 'Chat',
      );
    },
    AuthScreen: (data) {
      var args = data.getArgs<AuthScreenArguments>(
        orElse: () => AuthScreenArguments(),
      );
      return buildAdaptivePageRoute<dynamic>(
        builder: (context) => AuthScreen(key: args.key),
        settings: data,
        cupertinoTitle: 'Login/SignUp',
      );
    },
    NewLoopChatScreen: (data) {
      var args = data.getArgs<NewLoopChatScreenArguments>(nullOk: false);
      return buildAdaptivePageRoute<dynamic>(
        builder: (context) => NewLoopChatScreen(
          key: args.key,
          loopName: args.loopName,
          userData: args.userData,
        ),
        settings: data,
        cupertinoTitle: 'Chat',
      );
    },
    UserProfile: (data) {
      return buildAdaptivePageRoute<dynamic>(
        builder: (context) => const UserProfile(),
        settings: data,
        cupertinoTitle: 'Profile',
      );
    },
  };
}

/// ************************************************************************
/// Arguments holder classes
/// *************************************************************************

/// NavBar arguments holder class
class NavBarArguments {
  final Key key;
  NavBarArguments({this.key});
}

/// HomeScreen arguments holder class
class HomeScreenArguments {
  final Key key;
  final bool completedLoopsScreen;
  HomeScreenArguments({this.key, this.completedLoopsScreen = false});
}

/// FriendsScreen arguments holder class
class FriendsScreenArguments {
  final Key key;
  final String loopName;
  final bool loopForwarding;
  FriendsScreenArguments(
      {this.key, this.loopName = "", this.loopForwarding = false});
}

/// ExistingLoopChatScreen arguments holder class
class ExistingLoopChatScreenArguments {
  final Key key;
  final double radius;
  final Loop loop;
  ExistingLoopChatScreenArguments({this.key, this.radius, this.loop});
}

/// AuthScreen arguments holder class
class AuthScreenArguments {
  final Key key;
  AuthScreenArguments({this.key});
}

/// NewLoopChatScreen arguments holder class
class NewLoopChatScreenArguments {
  final Key key;
  final String loopName;
  final FriendsData userData;
  NewLoopChatScreenArguments(
      {this.key, @required this.loopName, @required this.userData});
}
