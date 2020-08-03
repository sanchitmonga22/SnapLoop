import 'dart:ui';

import 'package:SnapLoop/app/constants.dart';
import 'package:SnapLoop/app/locator.dart';
import 'package:SnapLoop/services/UserDataService.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'AnimatingFlatButton/AnimatingFlatButton.dart';
import 'CreateANewLoopDialog/createLoopDialog.dart';

class ChangeItemValueDialog extends StatefulWidget {
  final String initialText;
  final String itemName;

  ChangeItemValueDialog({Key key, this.initialText, this.itemName})
      : super(key: key);

  @override
  _ChangeItemValueDialogState createState() => _ChangeItemValueDialogState();
}

class _ChangeItemValueDialogState extends State<ChangeItemValueDialog> {
  TextEditingController _controller = TextEditingController();
  bool startAnimation = false;
  bool isSubmitted = false;
  bool errorOccured = false;
  final _formKey = GlobalKey<FormState>();
  String enteredValue = "";
  final _userDataService = locator<UserDataService>();

  // The form field to enter the loop name
  Widget getTextFormField(BuildContext context) {
    return TextFormField(
      textInputAction: TextInputAction.next,
      controller: _controller..text = widget.initialText,
      cursorColor: kTextFieldCursorColor,
      focusNode: isSubmitted ? AlwaysDisabledFocusNode() : null,
      autofocus: true,
      decoration: !startAnimation
          ? kgetDecoration(widget.itemName).copyWith(
              errorMaxLines: 3,
              hintStyle: kTextFormFieldStyle.copyWith(
                fontSize: 15,
                fontWeight: FontWeight.w500,
              ),
            )
          : kgetDecoration("").copyWith(
              hintStyle: kTextFormFieldStyle.copyWith(
                  fontSize: 15, fontWeight: FontWeight.w500),
            ),
      style: kTextFormFieldStyle,
      autocorrect: false,
      textAlign: TextAlign.center,
      // validating whether the user uses the same name for the loop
      onChanged: (value) {
        enteredValue = value;
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return BackdropFilter(
      filter: ImageFilter.blur(sigmaX: ksigmaX, sigmaY: ksigmaY),
      child: AlertDialog(
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
        backgroundColor: Colors.white.withOpacity(0.1),
        content: Container(
          child: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Form(
                    key: _formKey,
                    child: Padding(
                        padding: EdgeInsets.symmetric(vertical: 10),
                        child: Container(
                          height: startAnimation ? 60 : 100,
                          width: double.infinity,
                          child: AnimatingFlatButton(
                            isAnimating: startAnimation,
                            innerWidget: getTextFormField(context),
                          ),
                        ))),
                if (errorOccured)
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      "${widget.itemName} is taken, please try with a different value",
                      style: kTextFormFieldStyle.copyWith(
                          fontSize: 10, color: Colors.red),
                    ),
                  ),
                if (isSubmitted)
                  SizedBox(
                    height: 10,
                  ),
                SizedBox(
                    width: double.infinity,
                    height: 30,
                    child: FlatButton(
                      disabledColor: kSystemPrimaryColor.withOpacity(0.5),
                      color: Colors.blueAccent[400],
                      textTheme: ButtonTextTheme.primary,
                      onPressed: isSubmitted
                          ? null
                          : () async {
                              if (_formKey.currentState.validate()) {
                                _formKey.currentState.save();
                                enteredValue = _controller.text;
                                // to remove the focus
                                FocusScope.of(context)
                                    .requestFocus(new FocusNode());
                                setState(() {
                                  errorOccured = false;
                                  isSubmitted = true;
                                  startAnimation = !startAnimation;
                                });
                                bool result = await _userDataService.update(
                                    widget.itemName, enteredValue);
                                if (result)
                                  Navigator.of(context).pop();
                                else
                                  setState(() {
                                    errorOccured = true;
                                    isSubmitted = false;
                                    startAnimation = !startAnimation;
                                  });
                              }
                            },
                      child: Text(
                        "Change",
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
