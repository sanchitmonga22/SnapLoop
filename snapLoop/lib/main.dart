import 'package:SnapLoop/Helper/customRoute.dart';
import 'package:SnapLoop/Provider/ChatProvider.dart';
import 'package:SnapLoop/Provider/LoopsProvider.dart';
import 'package:SnapLoop/Provider/UserDataProvider.dart';
import 'package:SnapLoop/Socket.io/appInitializer.dart';
import 'package:SnapLoop/Socket.io/dependencyInjection.dart';
import 'package:SnapLoop/Widget/FloatingActionButton.dart';
import 'package:SnapLoop/app/locator.dart';
import 'package:SnapLoop/app/router.gr.dart';
import 'package:SnapLoop/mainModel.dart';
import 'package:SnapLoop/services/Auth.dart';
import 'package:SnapLoop/ui/views/NavBar/NavBar.dart';
import 'package:SnapLoop/ui/views/Auth/AuthView.dart';
import 'package:flutter/material.dart';
import 'package:flutter_simple_dependency_injection/injector.dart';
import 'package:provider/provider.dart';
import 'package:stacked/stacked.dart';
import 'ui/splashScreen.dart';
import 'Socket.io/socketService.dart';

Injector injector;

/// author: @sanchitmonga22
void main() async {
  setupLocator();
  DependencyInjection().initialise(Injector.getInjector());
  injector = Injector.getInjector();
  await AppInitializer().initialise(injector);
  // device preview
  runApp(SnapLoop());
}

class SnapLoop extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final SocketService socketService = injector.get<SocketService>();
    socketService.createSocketConnection();
    var _auth = locator<Auth>();

    return ViewModelBuilder.reactive(
      viewModelBuilder: () => MainModel(),
      builder: (context, model, child) {
        return MultiProvider(
            providers: [
              ChangeNotifierProvider<LoopsProvider>(create: (context) {
                return LoopsProvider(
                  _auth.token,
                  _auth.user,
                );
              }),
              ChangeNotifierProvider<ChatProvider>(
                create: (context) {
                  return ChatProvider(_auth.token, _auth.userId);
                },
              ),
              ChangeNotifierProvider(
                create: (context) => FloatingActionButtonDataChanges(),
              ),
            ],
            child: MaterialApp(
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
              home: model.isAuth
                  ? NavBar()
                  : FutureBuilder(
                      future: model.tryAutoLogin(),
                      builder: (context, authResultsnapshot) {
                        return authResultsnapshot.connectionState ==
                                ConnectionState.waiting
                            ? SplashScreen()
                            : AuthScreen();
                      },
                    ),
              onGenerateRoute: Router(),
            ));
      },
    );
  }
}

// use navigation service isntead of directly navigating in the app
