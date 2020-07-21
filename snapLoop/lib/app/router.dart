import 'package:SnapLoop/ui/views/Auth/AuthView.dart';
import 'package:SnapLoop/ui/views/Contacts/FriendsView.dart';
import 'package:SnapLoop/ui/views/Home/homeView.dart';
import 'package:SnapLoop/ui/views/NavBar/NavBar.dart';
import 'package:SnapLoop/ui/views/Profile/UserProfileView.dart';
import 'package:SnapLoop/ui/views/chat/ExistingLoopChatScreen.dart';
import 'package:SnapLoop/ui/views/chat/newLoopChatScreen.dart';
import 'package:auto_route/auto_route_annotations.dart';

@MaterialAutoRouter(routes: <AutoRoute>[
  AdaptiveRoute(page: NavBar, initial: true),
  AdaptiveRoute(page: HomeScreen, cupertinoPageTitle: "Home"),
  AdaptiveRoute(page: FriendsScreen, cupertinoPageTitle: "friends"),
  AdaptiveRoute(page: ExistingLoopChatScreen, cupertinoPageTitle: "Chat"),
  AdaptiveRoute(page: AuthScreen, cupertinoPageTitle: "Login/SignUp"),
  AdaptiveRoute(page: NewLoopChatScreen, cupertinoPageTitle: "Chat"),
  AdaptiveRoute(page: UserProfile, cupertinoPageTitle: "Profile"),
])
class $Router {}
