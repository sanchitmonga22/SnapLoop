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
                child: LoopWidgetContainer(maxRadius: (size.size.width) / 4)),
            Row(
              children: <Widget>[],
            ),
            Row(
              children: <Widget>[
                Expanded(
                  child: FlatButton(
                    //color: Theme.of(context).accentColor,
                    onPressed: () {
                      //TODO: Take to
                    },
                    child: Text(
                      "Existing Loops",
                      textAlign: TextAlign.center,
                    ),
                    padding: EdgeInsets.only(
                        right: size.size.width / 6, left: size.size.width / 6),
                  ),
                ),
                FlatButton(
                  //color: Theme.of(context).accentColor,
                  onPressed: () {
                    //TODO: Take to
                  },
                  child: Text(
                    "New Loops",
                    textAlign: TextAlign.center,
                  ),
                  padding: EdgeInsets.only(
                      right: size.size.width / 6, left: size.size.width / 6),
                ),
              ],
            )
          ],
        ));
  }
}
