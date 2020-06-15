import 'package:SnapLoop/Provider/UserDataProvider.dart';
import 'package:SnapLoop/Screens/CompletedLoops/completedLoops.dart';
import 'package:SnapLoop/Screens/UserProfile/userProfile.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'createLoopDialog.dart';
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
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "Snap",
                textAlign: TextAlign.center,
              ),
              FaIcon(
                FontAwesomeIcons.infinity,
                color: Colors.white70,
              ),
              Text(
                "Loop",
                textAlign: TextAlign.center,
              ),
            ],
          ),
          centerTitle: true,
          leading: Padding(
            padding: EdgeInsets.only(left: 20, top: 10),
            child: Text(
              "Score: ${userDataProvider.userScore.toString()}",
              textAlign: TextAlign.center,
            ),
          ),
          actions: [
            Padding(
              padding: const EdgeInsets.only(top: 10, right: 30),
              child: FlatButton(
                textColor: Colors.white,
                child: Text(
                  userDataProvider.displayName,
                ),
                // going to the user profile
                onPressed: () {
                  Navigator.of(context).pushNamed(UserProfile.routeName);
                },
              ),
            ),
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
              Expanded(
                child: Row(
                  children: <Widget>[
                    OutlineButton(
                      focusColor: Colors.transparent,
                      textColor: Colors.white70,
                      //color: Theme.of(context).accentColor,
                      onPressed: () {
                        showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return CreateALoopDialog();
                            });
                      },
                      child: Row(
                        children: [
                          Text(
                            "Start a Loop",
                            textAlign: TextAlign.center,
                          ),
                          SizedBox(
                            width: 4,
                          ),
                          FaIcon(
                            FontAwesomeIcons.infinity,
                            size: 15,
                            color: Colors.white70,
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      child: OutlineButton(
                        //color: Theme.of(context).accentColor,
                        onPressed: () {
                          //TODO:
                        },
                        child: Text(
                          "Loops Remaining:5",
                          textAlign: TextAlign.left,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: Row(
                  children: <Widget>[
                    // Expanded(
                    //   child:
                    // ),
                    Expanded(
                      child: OutlineButton(
                        //color: Theme.of(context).accentColor,
                        onPressed: () {
                          //TODO:
                        },
                        child: Row(
                          children: [
                            Text("Add Friends", textAlign: TextAlign.center),
                            Icon(
                              Icons.add,
                            ),
                          ],
                        ),
                        // padding: EdgeInsets.only(
                        //     right: size.size.width / 7,
                        //     left: size.size.width / 7),
                      ),
                    ),
                    Expanded(
                      child: OutlineButton(
                          //color: Theme.of(context).accentColor,
                          onPressed: () {
                            //TODO:
                          },
                          child: Text(
                            "Friends",
                            textAlign: TextAlign.left,
                          ),
                          padding: EdgeInsets.only(
                              right: size.size.width / 8,
                              left: size.size.width / 8)),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: OutlineButton(
                  //color: Theme.of(context).accentColor,
                  onPressed: () {
                    Navigator.of(context)
                        .pushNamed(CompletedLoopsScreen.routeName);
                  },
                  child: Text("Completed Loops", textAlign: TextAlign.center),
                  padding: EdgeInsets.only(
                      right: size.size.width / 7, left: size.size.width / 7),
                ),
              )
            ],
          ),
        ));
  }
}
