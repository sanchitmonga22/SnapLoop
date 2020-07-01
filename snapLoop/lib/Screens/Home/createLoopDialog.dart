import 'dart:ui';

import 'package:SnapLoop/Provider/LoopsProvider.dart';

import 'package:SnapLoop/Widget/AnimatingFlatButton.dart';
import 'package:SnapLoop/Screens/constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

/// author: @sanchitmonga22

class CreateALoopDialog extends StatefulWidget {
  @override
  _CreateALoopDialogState createState() => _CreateALoopDialogState();
}

class _CreateALoopDialogState extends State<CreateALoopDialog> {
  TextEditingController _controller = TextEditingController();
  bool startAnimation = false;
  Widget getTextFormField(String loopName, BuildContext context) {
    return TextFormField(
      strutStyle: StrutStyle(
        fontSize: 15,
        fontWeight: FontWeight.w600,
      ),
      controller: _controller,
      cursorColor: CupertinoColors.activeOrange,
      decoration: InputDecoration(
        prefixIcon: Icon(CupertinoIcons.loop_thick),
        hintText: "Enter here",
        hintStyle: kTextFormFieldStyle.copyWith(
            fontSize: 15, fontWeight: FontWeight.w500),
        labelStyle: kTextFormFieldStyle,
        counterStyle: kTextFormFieldStyle,
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15.0),
          borderSide: BorderSide(
            color: startAnimation
                ? Colors.transparent
                : CupertinoColors.activeOrange,
          ),
        ),
        // enabledBorder: OutlineInputBorder(
        //   borderRadius: BorderRadius.circular(25.0),
        //   borderSide: BorderSide(
        //     color: Colors.amberAccent,
        //     width: 2.0,
        //   ),
        // ),
      ),
      style: kTextFormFieldStyle,
      autocorrect: false,
      textAlign: TextAlign.center,
      autofocus: true,
      // validating whether the user uses the same name for the loop
      validator: (value) {
        if (Provider.of<LoopsProvider>(context, listen: false)
            .loopExistsWithName(value)) {
          return "There exists a loop with the same name";
        } else if (value.isEmpty) {
          return "Please enter the name to ";
        }
        // storing the name of the loop to pass it onto the next screen
        loopName = value.trim();
        return null;
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final _formKey = GlobalKey<FormState>();
    String loopName = "";
    return BackdropFilter(
      filter: ImageFilter.blur(sigmaX: ksigmaX, sigmaY: ksigmaY),
      child: AlertDialog(
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
        backgroundColor: Colors.black45,
        content: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Container(
            height: 170,
            padding: EdgeInsets.all(10),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Name of the loop",
                  style: kTextFormFieldStyle.copyWith(
                      fontWeight: FontWeight.w400, fontFamily: 'Mono'),
                  textAlign: TextAlign.left,
                ),
                Form(
                    key: _formKey,
                    child: Padding(
                        padding: EdgeInsets.symmetric(vertical: 10),
                        child: Container(
                          height: 60,
                          width: double.infinity,
                          child: AnimatingFlatButton(
                            isAnimating: startAnimation,
                            innerWidget: getTextFormField(loopName, context),
                          ),
                        ))),
                SizedBox(
                    width: double.infinity,
                    height: 30,
                    child: FlatButton(
                      color: CupertinoColors.destructiveRed,
                      focusColor: CupertinoColors.systemOrange,
                      textTheme: ButtonTextTheme.primary,
                      onPressed: () {
                        if (_formKey.currentState.validate()) {
                          _formKey.currentState.save();
                          setState(() {
                            startAnimation = !startAnimation;
                          });
                          // Navigator.of(context).pushNamed(
                          //     ContactScreen.routeName,
                          //     arguments: loopName);
                        }
                      },
                      child: Text(
                        "Create",
                        style: kTextFormFieldStyle,
                      ),
                    ))
              ],
            ),
          ),
        ),
      ),
    );
  }
}
