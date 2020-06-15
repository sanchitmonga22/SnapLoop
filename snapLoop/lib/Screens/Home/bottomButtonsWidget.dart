import 'package:SnapLoop/Screens/CompletedLoops/completedLoops.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'createLoopDialog.dart';

class BottomButtonsWidget extends StatelessWidget {
  const BottomButtonsWidget({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        decoration: BoxDecoration(
            color: Color.fromRGBO(74, 20, 140, 1).withOpacity(0.8)),
        child: Column(
          children: [
            Row(
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
                      Icon(Icons.loop)
                      // FaIcon(
                      //   FontAwesomeIcons.infinity,
                      //   size: 15,
                      //   color: Colors.white70,
                      // ),
                    ],
                  ),
                ),
                Expanded(
                  child: OutlineButton(
                    textColor: Colors.white70,
                    onPressed: () {
                      //TODO:
                    },
                    child: Text(
                      "Loops Remaining: 5",
                      textAlign: TextAlign.left,
                    ),
                  ),
                ),
              ],
            ),
            Expanded(
              child: Row(
                children: <Widget>[
                  Expanded(
                    child: OutlineButton(
                      textColor: Colors.white70,
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
                    ),
                  ),
                  Expanded(
                      child: OutlineButton(
                    textColor: Colors.white70,
                    onPressed: () {
                      //TODO:
                    },
                    child: Text(
                      "Friends",
                      textAlign: TextAlign.left,
                    ),
                  )),
                ],
              ),
            ),
            Expanded(
              child: OutlineButton(
                textColor: Colors.white70,
                onPressed: () {
                  Navigator.of(context)
                      .pushNamed(CompletedLoopsScreen.routeName);
                },
                child: Text("Completed Loops", textAlign: TextAlign.center),
              ),
            )
          ],
        ),
      ),
    );
  }
}
