import 'package:SnapLoop/Provider/LoopsProvider.dart';
import 'package:SnapLoop/Screens/Contacts/ContactsScreen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CreateALoopDialog extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final _formKey = GlobalKey<FormState>();
    String loopName = "";
    return AlertDialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
      content: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Container(
          height: 200,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Form(
                  key: _formKey,
                  child: Padding(
                    padding: EdgeInsets.all(8.0),
                    child: TextFormField(
                      decoration:
                          InputDecoration(labelText: 'Name of the loop'),
                      autocorrect: false,
                      textAlign: TextAlign.center,
                      autofocus: true,
                      // validating whether the user uses the same name for the loop
                      validator: (value) {
                        if (Provider.of<LoopsProvider>(context, listen: false)
                            .loopExistsWithName(value)) {
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
                    if (_formKey.currentState.validate()) {
                      _formKey.currentState.save();
                      Navigator.of(context).pushNamed(ContactScreen.routeName,
                          arguments: loopName);
                    }
                  },
                  child: Text(
                    "Create",
                    style: TextStyle(color: Colors.white),
                  ),
                  color: Theme.of(context).accentColor,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
