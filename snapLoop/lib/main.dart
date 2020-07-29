import 'package:SnapLoop/app/customRoute.dart';
import 'package:SnapLoop/app/locator.dart';
import 'package:SnapLoop/MainViewModel.dart';
import 'package:SnapLoop/ui/views/NavBar/NavBarView.dart';
import 'package:SnapLoop/ui/views/Auth/AuthView.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'app/router.gr.dart';
import 'ui/splashScreen.dart';

/// author: @sanchitmonga22
void main() async {
  setupLocator();
  // device preview
  runApp(SnapLoop());
}

class SnapLoop extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<MainViewModel>.reactive(
      viewModelBuilder: () => MainViewModel(),
      onModelReady: (model) {
        if (!model.isAuth) {
          model.tryAutoLogin();
        }
      },
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
              : model.isBusy ? SplashScreen() : AuthView(),
          onGenerateRoute: Router(),
        );
      },
    );
  }
}
