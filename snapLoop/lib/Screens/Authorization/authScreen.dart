import 'dart:math';
import 'package:SnapLoop/Screens/Authorization/authCard.dart';
import 'package:SnapLoop/Screens/constants.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

enum AuthMode { Signup, Login }

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
                      margin: EdgeInsets.only(
                          bottom:
                              15.0), // padding between the SnapLoop Logo and the Text Form
                      padding: EdgeInsets.symmetric(
                          vertical: 10.0,
                          horizontal:
                              20.0), // Padding in the text container containing snapLoop
                      decoration: kBoxDecorationLOGO,
                      // Contains the text
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text('Snap', style: kFontStyleLOGO),
                          FaIcon(
                            FontAwesomeIcons.infinity,
                            color: Colors.white70,
                            size: 30,
                          ),
                          Text('Loop', style: kFontStyleLOGO),
                        ],
                      ),
                    ),
                  ),
                  // Form Field
                  Container(
                    child: Flexible(
                      flex: 4,
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
