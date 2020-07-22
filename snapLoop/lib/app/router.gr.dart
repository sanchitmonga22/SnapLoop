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
import '../ui/views/Chat/ExistingLoopChat/ExistingLoopChatView.dart';
import '../ui/views/Chat/NewLoopChat/newLoopChatView.dart';
import '../ui/views/Contacts/Friends/FriendsView.dart';
import '../ui/views/Home/homeView.dart';
import '../ui/views/NavBar/NavBarView.dart';
import '../ui/views/Profile/UserProfileView.dart';

class Routes {
  static const String navBarView = '/';
  static const String homeView = '/home-view';
  static const String friendsView = '/friends-view';
  static const String existingLoopChatView = '/existing-loop-chat-view';
  static const String authView = '/auth-view';
  static const String newLoopChatView = '/new-loop-chat-view';
  static const String userProfileView = '/user-profile-view';
  static const all = <String>{
    navBarView,
    homeView,
    friendsView,
    existingLoopChatView,
    authView,
    newLoopChatView,
    userProfileView,
  };
}

class Router extends RouterBase {
  @override
  List<RouteDef> get routes => _routes;
  final _routes = <RouteDef>[
    RouteDef(Routes.navBarView, page: NavBarView),
    RouteDef(Routes.homeView, page: HomeView),
    RouteDef(Routes.friendsView, page: FriendsView),
    RouteDef(Routes.existingLoopChatView, page: ExistingLoopChatView),
    RouteDef(Routes.authView, page: AuthView),
    RouteDef(Routes.newLoopChatView, page: NewLoopChatView),
    RouteDef(Routes.userProfileView, page: UserProfileView),
  ];
  @override
  Map<Type, AutoRouteFactory> get pagesMap => _pagesMap;
  final _pagesMap = <Type, AutoRouteFactory>{
    NavBarView: (data) {
      var args = data.getArgs<NavBarViewArguments>(
        orElse: () => NavBarViewArguments(),
      );
      return buildAdaptivePageRoute<dynamic>(
        builder: (context) => NavBarView(key: args.key),
        settings: data,
      );
    },
    HomeView: (data) {
      var args = data.getArgs<HomeViewArguments>(
        orElse: () => HomeViewArguments(),
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
      var args = data.getArgs<FriendsViewArguments>(
        orElse: () => FriendsViewArguments(),
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
      var args = data.getArgs<ExistingLoopChatViewArguments>(
        orElse: () => ExistingLoopChatViewArguments(),
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
      var args = data.getArgs<AuthViewArguments>(
        orElse: () => AuthViewArguments(),
      );
      return buildAdaptivePageRoute<dynamic>(
        builder: (context) => AuthView(key: args.key),
        settings: data,
        cupertinoTitle: 'Login/SignUp',
      );
    },
    NewLoopChatView: (data) {
      var args = data.getArgs<NewLoopChatViewArguments>(nullOk: false);
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

/// NavBarView arguments holder class
class NavBarViewArguments {
  final Key key;
  NavBarViewArguments({this.key});
}

/// HomeView arguments holder class
class HomeViewArguments {
  final Key key;
  final bool completedLoopsScreen;
  HomeViewArguments({this.key, this.completedLoopsScreen = false});
}

/// FriendsView arguments holder class
class FriendsViewArguments {
  final Key key;
  final String loopName;
  final bool loopForwarding;
  FriendsViewArguments(
      {this.key, this.loopName = "", this.loopForwarding = false});
}

/// ExistingLoopChatView arguments holder class
class ExistingLoopChatViewArguments {
  final Key key;
  final double radius;
  final Loop loop;
  ExistingLoopChatViewArguments({this.key, this.radius, this.loop});
}

/// AuthView arguments holder class
class AuthViewArguments {
  final Key key;
  AuthViewArguments({this.key});
}

/// NewLoopChatView arguments holder class
class NewLoopChatViewArguments {
  final Key key;
  final String loopName;
  final FriendsData userData;
  NewLoopChatViewArguments(
      {this.key, @required this.loopName, @required this.userData});
}
