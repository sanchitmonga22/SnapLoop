import 'dart:ui';
import 'package:SnapLoop/Model/user.dart';
import 'package:SnapLoop/ui/Widget/AnimatingFlatButton/AnimatingFlatButton.dart';
import 'package:SnapLoop/app/locator.dart';
import 'package:SnapLoop/app/router.gr.dart';
import 'package:SnapLoop/constants.dart';
import 'package:SnapLoop/services/LoopsDataService.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

/// author: @sanchitmonga22

class CreateALoopDialog extends StatefulWidget {
  final FriendsData friend;

  const CreateALoopDialog({Key key, this.friend}) : super(key: key);
  @override
  _CreateALoopDialogState createState() => _CreateALoopDialogState();
}

class _CreateALoopDialogState extends State<CreateALoopDialog> {
  TextEditingController _controller = TextEditingController();
  bool startAnimation = false;
  bool isSubmitted = false;
  final _formKey = GlobalKey<FormState>();
  String loopName = "";

  // The form field to enter the loop name
  Widget getTextFormField(String loopName, BuildContext context) {
    return TextFormField(
      textInputAction: TextInputAction.next,
      controller: _controller,
      cursorColor: kTextFieldCursorColor,
      focusNode: isSubmitted ? AlwaysDisabledFocusNode() : null,
      autofocus: true,
      decoration: !startAnimation
          ? kgetDecoration("Loop name").copyWith(
              hintText: "Enter here",
              errorMaxLines: 3,
              hintStyle: kTextFormFieldStyle.copyWith(
                fontSize: 15,
                fontWeight: FontWeight.w500,
              ),
            )
          : kgetDecoration("").copyWith(
              hintText: "",
              hintStyle: kTextFormFieldStyle.copyWith(
                  fontSize: 15, fontWeight: FontWeight.w500),
            ),
      style: kTextFormFieldStyle,
      autocorrect: false,
      textAlign: TextAlign.center,
      // validating whether the user uses the same name for the loop
      validator: (value) {
        // TODO: make a create a loop dialog VIEW MODEL AND MODEL
        final _loopDataService = locator<LoopsDataService>();
        if (_loopDataService.loopExistsWithName(value)) {
          return "Please choose a different name, a loop with this name already exists";
        } else if (value.isEmpty) {
          return "Empty field!";
        }
        // storing the name of the loop to pass it onto the next screen
      },
      onChanged: (value) {
        loopName = value;
      },
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
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
                Form(
                    key: _formKey,
                    child: Padding(
                        padding: EdgeInsets.symmetric(vertical: 10),
                        child: Container(
                          height: startAnimation ? 60 : 100,
                          width: double.infinity,
                          child: AnimatingFlatButton(
                            isAnimating: startAnimation,
                            innerWidget: getTextFormField(loopName, context),
                          ),
                        ))),
                if (isSubmitted)
                  SizedBox(
                    height: 20,
                  ),
                SizedBox(
                    width: double.infinity,
                    height: 30,
                    child: FlatButton(
                      disabledColor: kSystemPrimaryColor.withOpacity(0.5),
                      color: Colors.blueAccent[400],
                      focusColor: CupertinoColors.systemOrange,
                      textTheme: ButtonTextTheme.primary,
                      onPressed: isSubmitted
                          ? null
                          : () {
                              if (_formKey.currentState.validate()) {
                                _formKey.currentState.save();
                                loopName = _controller.text;
                                // to remove the focus
                                FocusScope.of(context)
                                    .requestFocus(new FocusNode());
                                setState(() {
                                  isSubmitted = true;
                                  startAnimation = !startAnimation;
                                });
                                if (widget.friend == null) {
                                  // going to the contacts screen and then selecting a friend
                                  Navigator.of(context).pushReplacementNamed(
                                      Routes.friendsView,
                                      arguments: FriendsViewArguments(
                                          loopName: loopName,
                                          loopForwarding: false));
                                } else {
                                  //going to the chat screen directly
                                  Navigator.of(context).pushReplacementNamed(
                                      Routes.newLoopChatView,
                                      arguments: NewLoopChatViewArguments(
                                          loopName: loopName,
                                          friend: widget.friend));
                                }
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

class AlwaysDisabledFocusNode extends FocusNode {
  @override
  bool get hasFocus => false;
}
