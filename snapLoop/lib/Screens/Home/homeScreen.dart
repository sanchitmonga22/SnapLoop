import 'package:SnapLoop/Provider/LoopsProvider.dart';
import 'package:SnapLoop/Provider/UserDataProvider.dart';
import 'package:SnapLoop/Screens/CompletedLoops/completedLoops.dart';
import 'package:SnapLoop/Screens/Contacts/ContactsScreen.dart';
import 'package:SnapLoop/Screens/UserProfile/userProfile.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'loopWidgetContainer.dart';

class HomeScreen extends StatelessWidget {
  static const routeName = '/homeScreen';
  final _formKey = GlobalKey<FormState>();
  // TODO setup validation for the name of the loop and whether the user can start or not

  @override
  Widget build(BuildContext context) {
    final userDataProvider = Provider.of<UserDataProvider>(context);
    String loopName = "";
    MediaQueryData size = MediaQuery.of(context);
    return Scaffold(
        resizeToAvoidBottomPadding:
            false, // to avoid bottom overflow in the alert dialog box
        appBar: AppBar(
          title: Text(
            "SnapLoop",
            textAlign: TextAlign.center,
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
                                              textAlign: TextAlign.center,
                                              autofocus: true,
                                              // validating whether the user uses the same name for the loop
                                              validator: (value) {
                                                if (Provider.of<LoopsProvider>(
                                                        context,
                                                        listen: false)
                                                    .loopExistsWithName(
                                                        value)) {
                                                  return "There exists a loop with the same name";
                                                }
                                                // storing the name of the loop to pass it onto the next screen
                                                loopName = value.trim();
                                                return null;
                                              },
                                            ),
                                          )),
                                      SizedBox(
                                        width: double.infinity,
                                        child: RaisedButton(
                                          onPressed: () {
                                            if (_formKey.currentState
                                                .validate()) {
                                              _formKey.currentState.save();
                                              Navigator.of(context).pushNamed(
                                                  ContactScreen.routeName,
                                                  arguments: loopName);
                                            }
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
                  Navigator.of(context)
                      .pushNamed(CompletedLoopsScreen.routeName);
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
