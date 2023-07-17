// **************************************************************************
// AutoRouteGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouteGenerator
// **************************************************************************
//
// ignore_for_file: type=lint

import 'package:auto_route/auto_route.dart' as _i9;
import 'package:flutter/material.dart' as _i10;

import '../main.dart' as _i1;
import '../Model/loop.dart' as _i11;
import '../Model/user.dart' as _i12;
import '../ui/views/Auth/AuthView.dart' as _i6;
import '../ui/views/Chat/ExistingLoopChat/ExistingLoopChatView.dart' as _i5;
import '../ui/views/Chat/NewLoopChat/newLoopChatView.dart' as _i7;
import '../ui/views/Contacts/Friends/FriendsView.dart' as _i4;
import '../ui/views/Home/homeView.dart' as _i3;
import '../ui/views/NavBar/NavBarView.dart' as _i2;
import '../ui/views/Profile/UserProfileView.dart' as _i8;

class CustomRouter extends _i9.RootStackRouter {
  CustomRouter([_i10.GlobalKey<_i10.NavigatorState> navigatorKey])
      : super(navigatorKey);

  @override
  final Map<String, _i9.PageFactory> pagesMap = {
    SnapLoopRoute.name: (routeData) {
      return _i9.AdaptivePage<dynamic>(
          routeData: routeData, child: _i1.SnapLoop());
    },
    NavBarViewRoute.name: (routeData) {
      final args = routeData.argsAs<NavBarViewRouteArgs>(
          orElse: () => const NavBarViewRouteArgs());
      return _i9.AdaptivePage<dynamic>(
          routeData: routeData,
          child: _i2.NavBarView(key: args.key),
          title: 'navBar');
    },
    HomeViewRoute.name: (routeData) {
      final args = routeData.argsAs<HomeViewRouteArgs>(
          orElse: () => const HomeViewRouteArgs());
      return _i9.AdaptivePage<dynamic>(
          routeData: routeData,
          child: _i3.HomeView(
              key: args.key, completedLoopsScreen: args.completedLoopsScreen),
          title: 'Home');
    },
    FriendsViewRoute.name: (routeData) {
      final args = routeData.argsAs<FriendsViewRouteArgs>(
          orElse: () => const FriendsViewRouteArgs());
      return _i9.AdaptivePage<dynamic>(
          routeData: routeData,
          child: _i4.FriendsView(
              key: args.key,
              loopName: args.loopName,
              loopForwarding: args.loopForwarding),
          title: 'friends');
    },
    ExistingLoopChatViewRoute.name: (routeData) {
      final args = routeData.argsAs<ExistingLoopChatViewRouteArgs>(
          orElse: () => const ExistingLoopChatViewRouteArgs());
      return _i9.AdaptivePage<dynamic>(
          routeData: routeData,
          child: _i5.ExistingLoopChatView(
              key: args.key, radius: args.radius, loop: args.loop),
          title: 'Chat');
    },
    AuthViewRoute.name: (routeData) {
      final args = routeData.argsAs<AuthViewRouteArgs>(
          orElse: () => const AuthViewRouteArgs());
      return _i9.AdaptivePage<dynamic>(
          routeData: routeData,
          child: _i6.AuthView(key: args.key),
          title: 'Login/SignUp');
    },
    NewLoopChatViewRoute.name: (routeData) {
      final args = routeData.argsAs<NewLoopChatViewRouteArgs>(
          orElse: () => const NewLoopChatViewRouteArgs());
      return _i9.AdaptivePage<dynamic>(
          routeData: routeData,
          child: _i7.NewLoopChatView(
              key: args.key, loopName: args.loopName, friend: args.friend),
          title: 'Chat');
    },
    UserProfileViewRoute.name: (routeData) {
      return _i9.AdaptivePage<dynamic>(
          routeData: routeData,
          child: const _i8.UserProfileView(),
          title: 'Profile');
    }
  };

  @override
  List<_i9.RouteConfig> get routes => [
        _i9.RouteConfig(SnapLoopRoute.name, path: '/'),
        _i9.RouteConfig(NavBarViewRoute.name, path: '/nav-bar-view'),
        _i9.RouteConfig(HomeViewRoute.name, path: '/home-view'),
        _i9.RouteConfig(FriendsViewRoute.name, path: '/friends-view'),
        _i9.RouteConfig(ExistingLoopChatViewRoute.name,
            path: '/existing-loop-chat-view'),
        _i9.RouteConfig(AuthViewRoute.name, path: '/auth-view'),
        _i9.RouteConfig(NewLoopChatViewRoute.name, path: '/new-loop-chat-view'),
        _i9.RouteConfig(UserProfileViewRoute.name, path: '/user-profile-view')
      ];
}

/// generated route for
/// [_i1.SnapLoop]
class SnapLoopRoute extends _i9.PageRouteInfo<void> {
  const SnapLoopRoute() : super(SnapLoopRoute.name, path: '/');

  static const String name = 'SnapLoopRoute';
}

/// generated route for
/// [_i2.NavBarView]
class NavBarViewRoute extends _i9.PageRouteInfo<NavBarViewRouteArgs> {
  NavBarViewRoute({_i10.Key key})
      : super(NavBarViewRoute.name,
            path: '/nav-bar-view', args: NavBarViewRouteArgs(key: key));

  static const String name = 'NavBarViewRoute';
}

class NavBarViewRouteArgs {
  const NavBarViewRouteArgs({this.key});

  final _i10.Key key;

  @override
  String toString() {
    return 'NavBarViewRouteArgs{key: $key}';
  }
}

/// generated route for
/// [_i3.HomeView]
class HomeViewRoute extends _i9.PageRouteInfo<HomeViewRouteArgs> {
  HomeViewRoute({_i10.Key key, bool completedLoopsScreen = false})
      : super(HomeViewRoute.name,
            path: '/home-view',
            args: HomeViewRouteArgs(
                key: key, completedLoopsScreen: completedLoopsScreen));

  static const String name = 'HomeViewRoute';
}

class HomeViewRouteArgs {
  const HomeViewRouteArgs({this.key, this.completedLoopsScreen = false});

  final _i10.Key key;

  final bool completedLoopsScreen;

  @override
  String toString() {
    return 'HomeViewRouteArgs{key: $key, completedLoopsScreen: $completedLoopsScreen}';
  }
}

/// generated route for
/// [_i4.FriendsView]
class FriendsViewRoute extends _i9.PageRouteInfo<FriendsViewRouteArgs> {
  FriendsViewRoute(
      {_i10.Key key, String loopName = "", bool loopForwarding = false})
      : super(FriendsViewRoute.name,
            path: '/friends-view',
            args: FriendsViewRouteArgs(
                key: key, loopName: loopName, loopForwarding: loopForwarding));

  static const String name = 'FriendsViewRoute';
}

class FriendsViewRouteArgs {
  const FriendsViewRouteArgs(
      {this.key, this.loopName = "", this.loopForwarding = false});

  final _i10.Key key;

  final String loopName;

  final bool loopForwarding;

  @override
  String toString() {
    return 'FriendsViewRouteArgs{key: $key, loopName: $loopName, loopForwarding: $loopForwarding}';
  }
}

/// generated route for
/// [_i5.ExistingLoopChatView]
class ExistingLoopChatViewRoute
    extends _i9.PageRouteInfo<ExistingLoopChatViewRouteArgs> {
  ExistingLoopChatViewRoute({_i10.Key key, double radius, _i11.Loop loop})
      : super(ExistingLoopChatViewRoute.name,
            path: '/existing-loop-chat-view',
            args: ExistingLoopChatViewRouteArgs(
                key: key, radius: radius, loop: loop));

  static const String name = 'ExistingLoopChatViewRoute';
}

class ExistingLoopChatViewRouteArgs {
  const ExistingLoopChatViewRouteArgs({this.key, this.radius, this.loop});

  final _i10.Key key;

  final double radius;

  final _i11.Loop loop;

  @override
  String toString() {
    return 'ExistingLoopChatViewRouteArgs{key: $key, radius: $radius, loop: $loop}';
  }
}

/// generated route for
/// [_i6.AuthView]
class AuthViewRoute extends _i9.PageRouteInfo<AuthViewRouteArgs> {
  AuthViewRoute({_i10.Key key})
      : super(AuthViewRoute.name,
            path: '/auth-view', args: AuthViewRouteArgs(key: key));

  static const String name = 'AuthViewRoute';
}

class AuthViewRouteArgs {
  const AuthViewRouteArgs({this.key});

  final _i10.Key key;

  @override
  String toString() {
    return 'AuthViewRouteArgs{key: $key}';
  }
}

/// generated route for
/// [_i7.NewLoopChatView]
class NewLoopChatViewRoute extends _i9.PageRouteInfo<NewLoopChatViewRouteArgs> {
  NewLoopChatViewRoute({_i10.Key key, String loopName, _i12.FriendsData friend})
      : super(NewLoopChatViewRoute.name,
            path: '/new-loop-chat-view',
            args: NewLoopChatViewRouteArgs(
                key: key, loopName: loopName, friend: friend));

  static const String name = 'NewLoopChatViewRoute';
}

class NewLoopChatViewRouteArgs {
  const NewLoopChatViewRouteArgs({this.key, this.loopName, this.friend});

  final _i10.Key key;

  final String loopName;

  final _i12.FriendsData friend;

  @override
  String toString() {
    return 'NewLoopChatViewRouteArgs{key: $key, loopName: $loopName, friend: $friend}';
  }
}

/// generated route for
/// [_i8.UserProfileView]
class UserProfileViewRoute extends _i9.PageRouteInfo<void> {
  const UserProfileViewRoute()
      : super(UserProfileViewRoute.name, path: '/user-profile-view');

  static const String name = 'UserProfileViewRoute';
}
