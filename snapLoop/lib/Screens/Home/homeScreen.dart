import 'package:SnapLoop/Screens/CompletedLoops/completedLoops.dart';
import 'package:flutter/material.dart';
import 'loopWidgetContainer.dart';

class HomeScreen extends StatelessWidget {
  static const routeName = '/homeScreen';
  @override
  Widget build(BuildContext context) {
    MediaQueryData size = MediaQuery.of(context);

    return Scaffold(
        appBar: AppBar(
          title: Text("SnapLoop"),
        ),
        body: Column(
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
                  Expanded(
                    child: FlatButton(
                      //color: Theme.of(context).accentColor,
                      onPressed: () {
                        //TODO:
                      },
                      child: Text("Start a Loop", textAlign: TextAlign.center),
                    ),
                  ),
                  Expanded(
                    child: FlatButton(
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
                  Expanded(
                    child: FlatButton(
                      //color: Theme.of(context).accentColor,
                      onPressed: () {
                        //TODO:
                      },
                      child: Text("Add Friends", textAlign: TextAlign.center),
                      padding: EdgeInsets.only(
                          right: size.size.width / 7,
                          left: size.size.width / 7),
                    ),
                  ),
                  Expanded(
                    child: FlatButton(
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
              child: FlatButton(
                //color: Theme.of(context).accentColor,
                onPressed: () {
                  Navigator.pushNamed(context, CompletedLoopsScreen.routeName);
                },
                child: Text("Completed Loops", textAlign: TextAlign.center),
                padding: EdgeInsets.only(
                    right: size.size.width / 7, left: size.size.width / 7),
              ),
            )
          ],
        ));
  }
}
