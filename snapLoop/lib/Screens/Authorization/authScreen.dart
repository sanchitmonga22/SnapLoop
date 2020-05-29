import 'dart:math';
import 'package:SnapLoop/Screens/Authorization/authCard.dart';
import 'package:flutter/material.dart';

enum AuthMode { Signup, Login }

class AuthScreen extends StatelessWidget {
  static const routeName = '/auth';

  @override
  Widget build(BuildContext context) {
    MediaQueryData deviceData = MediaQuery.of(context);
    final deviceSize = deviceData.size;
    // final transformConfig = Matrix4.rotationZ(-8 * pi / 180);
    // transformConfig.translate(-10.0);
    return Scaffold(
      // resizeToAvoidBottomInset: false,
      body: Stack(
        children: <Widget>[
          // used for the background color

          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Color.fromRGBO(150, 200, 255, 1).withOpacity(0.5),
                  Color.fromRGBO(150, 255, 117, 1).withOpacity(0.9),
                ],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                stops: [0, 1],
              ),
            ),
          ),
          // The body of snapLoop complete page

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
                      margin: EdgeInsets.only(
                          bottom:
                              20.0), // padding between the SnapLoop Logo and the Text Form
                      padding: EdgeInsets.symmetric(
                          vertical: 8.0,
                          horizontal:
                              50.0), // Padding in the text container containing snapLoop
                      transform: Matrix4.rotationZ(
                          -8 * pi / 180) // for turning the text container
                        ..translate(-10.0),
                      // ..translate(-10.0),
                      // decoration for the text in the background

                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: Colors.green.shade400,
                        boxShadow: [
                          BoxShadow(
                            blurRadius: 8,
                            color: Colors.black26,
                            offset: Offset(0, 2),
                          )
                        ],
                      ),

                      // Contains the text
                      child: Text(
                        'SnapLoop',
                        style: TextStyle(
                          color: Theme.of(context).accentTextTheme.title.color,
                          fontSize: 40,
                          fontFamily: 'Anton',
                          fontWeight: FontWeight.normal,
                        ),
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
