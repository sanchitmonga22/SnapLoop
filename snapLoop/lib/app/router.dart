import 'package:SnapLoop/main.dart';
import 'package:SnapLoop/ui/views/Auth/AuthView.dart';
import 'package:SnapLoop/ui/views/Chat/ExistingLoopChat/ExistingLoopChatView.dart';
import 'package:SnapLoop/ui/views/Chat/NewLoopChat/newLoopChatView.dart';
import 'package:SnapLoop/ui/views/Contacts/Friends/FriendsView.dart';
import 'package:SnapLoop/ui/views/Home/homeView.dart';
import 'package:SnapLoop/ui/views/NavBar/NavBarView.dart';
import 'package:SnapLoop/ui/views/Profile/UserProfileView.dart';
import 'package:auto_route/annotations.dart';

@MaterialAutoRouter(routes: <AutoRoute>[
  AdaptiveRoute(page: SnapLoop, initial: true),
  AdaptiveRoute(page: NavBarView, cupertinoPageTitle: 'navBar'),
  AdaptiveRoute(page: HomeView, cupertinoPageTitle: "Home"),
  AdaptiveRoute(page: FriendsView, cupertinoPageTitle: "friends"),
  AdaptiveRoute(page: ExistingLoopChatView, cupertinoPageTitle: "Chat"),
  AdaptiveRoute(page: AuthView, cupertinoPageTitle: "Login/SignUp"),
  AdaptiveRoute(page: NewLoopChatView, cupertinoPageTitle: "Chat"),
  AdaptiveRoute(page: UserProfileView, cupertinoPageTitle: "Profile"),
])
class $CustomRouter {}
