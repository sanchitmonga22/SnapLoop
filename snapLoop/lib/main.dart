import 'package:SnapLoop/Helper/customRoute.dart';
import 'package:SnapLoop/Socket.io/appInitializer.dart';
import 'package:SnapLoop/Socket.io/dependencyInjection.dart';
import 'package:SnapLoop/app/locator.dart';
import 'package:SnapLoop/MainViewModel.dart';
import 'package:SnapLoop/services/Auth.dart';
import 'package:SnapLoop/ui/views/NavBar/NavBarView.dart';
import 'package:SnapLoop/ui/views/Auth/AuthView.dart';
import 'package:flutter/material.dart';
import 'package:flutter_simple_dependency_injection/injector.dart';
import 'package:stacked/stacked.dart';
import 'app/router.gr.dart';
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
      viewModelBuilder: () => MainViewModel(),
      builder: (context, model, child) {
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
          home: model.isAuth
              ? NavBarView()
              : FutureBuilder(
                  future: model.tryAutoLogin(),
                  builder: (context, authResultsnapshot) {
                    return authResultsnapshot.connectionState ==
                            ConnectionState.waiting
                        ? SplashScreen()
                        : AuthView();
                  },
                ),
          onGenerateRoute: Router(),
        );
      },
    );
  }
}

// use navigation service isntead of directly navigating in the app
