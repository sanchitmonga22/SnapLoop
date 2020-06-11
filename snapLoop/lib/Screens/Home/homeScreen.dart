import 'package:SnapLoop/Screens/CompletedLoops/completedLoops.dart';
import 'package:flutter/material.dart';
import 'loopWidgetContainer.dart';

class HomeScreen extends StatelessWidget {
  static const routeName = '/homeScreen';
  final _formKey = GlobalKey<FormState>();
  // TODO setup validation for the name of the loop and whether the user can start or not

  @override
  Widget build(BuildContext context) {
    MediaQueryData size = MediaQuery.of(context);

    return Scaffold(
        resizeToAvoidBottomPadding:
            false, // to avoid bottom overflow in the alert dialog box
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
                  FlatButton(
                    //color: Theme.of(context).accentColor,
                    onPressed: () {
                      showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return AlertDialog(
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20.0)),
                              content: SingleChildScrollView(
                                scrollDirection: Axis.vertical,
                                child: Container(
                                  height: 200,
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Form(
                                          key: _formKey,
                                          child: Padding(
                                            padding: EdgeInsets.all(8.0),
                                            child: TextFormField(
                                              decoration: InputDecoration(
                                                  labelText:
                                                      'Name of the loop'),
                                              autocorrect: false,
                                              autofocus: true,
                                            ),
                                          )),
                                      // TextField(
                                      //   decoration: InputDecoration(
                                      //       border: InputBorder.none,
                                      //       hintText:
                                      //           'Enter the name of the loop'),
                                      // ),
                                      SizedBox(
                                        width: double.infinity,
                                        child: RaisedButton(
                                          onPressed: () {
                                            //TODO
                                            // if (_formKey.currentState
                                            //     .validate()) {
                                            //   _formKey.currentState.save();
                                            // }
                                          },
                                          child: Text(
                                            "Create",
                                            style:
                                                TextStyle(color: Colors.white),
                                          ),
                                          color: Theme.of(context).accentColor,
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            );
                          });
                    },
                    child: Text("Start a Loop", textAlign: TextAlign.center),
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
