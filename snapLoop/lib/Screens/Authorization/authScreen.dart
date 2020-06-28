import 'package:SnapLoop/Screens/Authorization/authCard.dart';
import 'package:SnapLoop/Screens/constants.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';

enum AuthMode { Signup, Login }

/**
 * author: @sanchitmonga22
 */
class AuthScreen extends StatelessWidget {
  static const routeName = '/auth';
  //final SERVER_IP = "";

  @override
  Widget build(BuildContext context) {
    MediaQueryData deviceData = MediaQuery.of(context);
    final deviceSize = deviceData.size;
    return Scaffold(
      body: Stack(
        children: <Widget>[
          Container(decoration: kBoxDecoration),
          SingleChildScrollView(
            child: Container(
              height: deviceSize.height,
              width: deviceSize.width,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Flexible(
                    flex: 3,
                    child: Container(
                      width: deviceSize.width * 0.65,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SizedBox(
                            child: ColorizeAnimatedTextKit(
                              text: ["Snap∞Loop"],
                              textStyle: TextStyle(
                                  fontSize: 40.0,
                                  fontFamily: "Open Sans",
                                  fontWeight: FontWeight.w900),
                              colors: [
                                // Colors.purple,
                                Colors.white70,
                                Colors.yellow,
                                Colors.blueGrey,
                              ],
                              textAlign: TextAlign.center,
                              repeatForever: true,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Container(
                    child: Flexible(
                      flex: 8,
                      child: AuthCard(),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
