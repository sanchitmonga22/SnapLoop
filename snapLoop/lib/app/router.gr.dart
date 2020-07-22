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
import '../ui/views/Contacts/Friends/FriendsView.dart';
import '../ui/views/Home/homeView.dart';
import '../ui/views/NavBar/NavBarView.dart';
import '../ui/views/Profile/UserProfileView.dart';
import '../ui/views/chat/ExistingLoopChat/ExistingLoopChatView.dart';
import '../ui/views/chat/NewLoopChat/newLoopChatView.dart';

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
    RouteDef(Routes.homeScreen, page: HomeView),
    RouteDef(Routes.friendsScreen, page: FriendsView),
    RouteDef(Routes.existingLoopChatScreen, page: ExistingLoopChatView),
    RouteDef(Routes.authScreen, page: AuthView),
    RouteDef(Routes.newLoopChatScreen, page: NewLoopChatView),
    RouteDef(Routes.userProfile, page: UserProfileView),
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
    HomeView: (data) {
      var args = data.getArgs<HomeScreenArguments>(
        orElse: () => HomeScreenArguments(),
      );
      return buildAdaptivePageRoute<dynamic>(
        builder: (context) => HomeView(
          key: args.key,
          completedLoopsScreen: args.completedLoopsScreen,
        ),
        settings: data,
        cupertinoTitle: 'Home',
      );
    },
    FriendsView: (data) {
      var args = data.getArgs<FriendsScreenArguments>(
        orElse: () => FriendsScreenArguments(),
      );
      return buildAdaptivePageRoute<dynamic>(
        builder: (context) => FriendsView(
          key: args.key,
          loopName: args.loopName,
          loopForwarding: args.loopForwarding,
        ),
        settings: data,
        cupertinoTitle: 'friends',
      );
    },
    ExistingLoopChatView: (data) {
      var args = data.getArgs<ExistingLoopChatScreenArguments>(
        orElse: () => ExistingLoopChatScreenArguments(),
      );
      return buildAdaptivePageRoute<dynamic>(
        builder: (context) => ExistingLoopChatView(
          key: args.key,
          radius: args.radius,
          loop: args.loop,
        ),
        settings: data,
        cupertinoTitle: 'Chat',
      );
    },
    AuthView: (data) {
      var args = data.getArgs<AuthScreenArguments>(
        orElse: () => AuthScreenArguments(),
      );
      return buildAdaptivePageRoute<dynamic>(
        builder: (context) => AuthView(key: args.key),
        settings: data,
        cupertinoTitle: 'Login/SignUp',
      );
    },
    NewLoopChatView: (data) {
      var args = data.getArgs<NewLoopChatScreenArguments>(nullOk: false);
      return buildAdaptivePageRoute<dynamic>(
        builder: (context) => NewLoopChatView(
          key: args.key,
          loopName: args.loopName,
          userData: args.userData,
        ),
        settings: data,
        cupertinoTitle: 'Chat',
      );
    },
    UserProfileView: (data) {
      return buildAdaptivePageRoute<dynamic>(
        builder: (context) => const UserProfileView(),
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
