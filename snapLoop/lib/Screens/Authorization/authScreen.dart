import 'package:SnapLoop/Screens/Authorization/authCard.dart';
import 'package:SnapLoop/Screens/constants.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

enum AuthMode { Signup, Login }

/// author: @sanchitmonga22

class AuthScreen extends StatelessWidget {
  static const routeName = '/auth';
  //final SERVER_IP = "";

  //TODO List: Change the background!
  @override
  Widget build(BuildContext context) {
    MediaQueryData deviceData = MediaQuery.of(context);
    final deviceSize = deviceData.size;
    return Scaffold(
      body: Stack(
        children: <Widget>[
          SingleChildScrollView(
            child: Container(
              height: deviceSize.height,
              width: deviceSize.width,
              decoration: kHomeScreenDecoration,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Container(
                    padding: EdgeInsets.only(
                        bottom: 25, left: 10, right: 10, top: 10),
                    child: ColorizeAnimatedTextKit(
                      text: ["Snap∞Loop"],
                      textStyle: kLOGOTextStyle,
                      speed: Duration(milliseconds: 1000),
                      //isRepeatingAnimation: true,
                      colors: [
                        // Colors.purple,
                        Colors.white70,
                        Colors.yellow,
                        Colors.blueGrey,
                        CupertinoColors.activeOrange
                      ],
                      textAlign: TextAlign.center,
                      repeatForever: true,
                    ),
                  ),
                  AuthCard(),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
