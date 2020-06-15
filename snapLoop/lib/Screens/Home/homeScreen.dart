import 'package:SnapLoop/Provider/UserDataProvider.dart';
import 'package:SnapLoop/Screens/Home/bottomButtonsWidget.dart';
import 'package:SnapLoop/Screens/UserProfile/userProfile.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'loopWidgetContainer.dart';

class HomeScreen extends StatelessWidget {
  static const routeName = '/homeScreen';

  // TODO setup validation for the name of the loop and whether the user can start or not

  @override
  Widget build(BuildContext context) {
    final userDataProvider = Provider.of<UserDataProvider>(context);

    MediaQueryData size = MediaQuery.of(context);
    return Scaffold(
        resizeToAvoidBottomPadding:
            false, // to avoid bottom overflow in the alert dialog box
        appBar: AppBar(
          title: Row(
            children: [
              Text(
                "Score: ${userDataProvider.userScore.toString()}",
                textAlign: TextAlign.left,
                style: TextStyle(fontSize: 15),
              ),
              SizedBox(width: 40),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Snap",
                  ),
                  Icon(Icons.loop),
                  // FaIcon(
                  //   FontAwesomeIcons.infinity,
                  //   color: Colors.white70,
                  // ),
                  // Text(
                  //   "Loop",
                  // ),
                ],
              ),
            ],
          ),
          centerTitle: true,
          backgroundColor: Color.fromRGBO(74, 20, 140, 1).withOpacity(0.8),
          // leading: Container(
          //   child:
          // ),
          actions: [
            RaisedButton(
              color: Colors.transparent,
              textColor: Colors.white,
              child: Text(
                userDataProvider.displayName,
              ),
              // going to the user profile
              onPressed: () {
                Navigator.of(context).pushNamed(UserProfile.routeName);
              },
            )
          ],
        ),
        body: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Color.fromRGBO(94, 53, 177, 1).withOpacity(0.3),
                Color.fromRGBO(74, 20, 140, 1).withOpacity(0.8),
                // Color.fromRGBO(150, 200, 255, 1).withOpacity(0.5),
                // Color.fromRGBO(150, 255, 117, 1).withOpacity(0.9),
              ],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              stops: [0, 1],
            ),
          ),
          child: Column(
            children: <Widget>[
              Container(
                height: size.size.height * 0.75,
                child: LoopWidgetContainer(
                  maxRadius: (size.size.width) / 4,
                  isInactive: false,
                ),
              ),
              BottomButtonsWidget()
            ],
          ),
        ));
  }
}
