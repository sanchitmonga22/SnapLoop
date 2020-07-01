import 'package:SnapLoop/Model/loop.dart';
import 'package:SnapLoop/Screens/Home/LoopWidget/MemojiGenerator.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

///author: @sanchitmonga22

//SECTION: COMMON
final kSwipeConstant = 5;
const double ksigmaX = 5.0; // from 0-10
const double ksigmaY = 5.0; // from 0-10
const double kopacity = 0.1;

//SECTION: AUTH SCREEN
final kHomeScreenDecoration = BoxDecoration(
  image: DecorationImage(
      image: AssetImage(
        'assets/images/test5.PNG',
      ),
      fit: BoxFit.fill),
);

final kLOGOTextStyle = TextStyle(
    fontSize: 50.0, fontFamily: "Open Sans", fontWeight: FontWeight.w900);

final kBoxDecorationLOGO = BoxDecoration(
  borderRadius: BorderRadius.circular(15),
  color: Color.fromRGBO(74, 20, 140, 0.9),
  boxShadow: [
    BoxShadow(
      blurRadius: 2,
      color: Colors.black26,
      offset: Offset(0, 2),
    )
  ],
);

//SECTION: AUTH CARD

const double kMinHeightSignUp = 550;
const double kMinHeightLogin = 370;

const kTextFormFieldStyle =
    TextStyle(color: Colors.white, fontWeight: FontWeight.w600);

InputDecoration kgetDecoration(String labelText) {
  return InputDecoration(
      labelText: labelText,
      labelStyle: kTextFormFieldStyle,
      focusColor: Colors.white,
      contentPadding: EdgeInsets.all(15),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(25.0),
        borderSide: BorderSide(color: CupertinoColors.activeOrange, width: 2),
      ),
      errorMaxLines: 1,
      //helperText: , for the Phone number input
      // icon: Icon(
      //   Icons.email,
      //   color: CupertinoColors.activeOrange,
      // ),
      helperStyle: kTextFormFieldStyle,
      //errorText: ,
      // counter: FOR THE PASSWORD
      focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(25.0),
          borderSide: BorderSide(
            color: Colors.red,
            width: 4.0,
          )),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(25.0),
        borderSide: BorderSide(
          color: Colors.red,
          width: 4.0,
        ),
      ),
      errorStyle: TextStyle(
          color: CupertinoColors.extraLightBackgroundGray,
          fontWeight: FontWeight.w600));
}

//SECTION: SIGNUP WIDGET:
const double kminHeightSignUpWidget = 80;
const double kmaxHeightSignUpWidget = 250;

// SECTION: HOME SCREEN
const kAppBarBackgroundColor = Colors.black;
const kTextStyleHomeScreen =
    TextStyle(color: Colors.white, fontWeight: FontWeight.w600, fontSize: 15);

final kHomeScreenBoxDecoration =
    BoxDecoration(color: CupertinoColors.systemGrey2);

//: LOOP CONTENT
// KEY: Number of Members, and Value Factor by which the maxRadius has to be reduced
// NOTE: DO NOT CHANGE THIS!!
const kfixedRadiusFactor = {2: 0.35, 3: 0.36, 4: 0.39, 5: 0.46, "MORE": 0.65};

const double kAllLoopsPadding = 15;
const kalignmentMap = {
  2: [Position(1, 1), Position(-1, -1)],
  3: [
    Position(0, -1),
    Position(-2 / (1.732), 1),
    Position(2 / (1.732), 1),
  ],
  4: [Position(1, 1), Position(-1, -1), Position(-1, 1), Position(1, -1)],
  5: [
    Position(1, 1),
    Position(-1, -1),
    Position(-1, 1),
    Position(1, -1),
    Position(0, 0)
  ],
  13: [
    Position(0.5, 0.5),
    Position(-0.5, -0.5),
    Position(-0.5, 0.5),
    Position(0.5, -0.5),
    Position(0, 0),
    Position(1, -1),
    Position(-1, -1),
    Position(0, -1.3),
    Position(1, 1),
    Position(-1, 1),
    Position(0, 1.3),
    Position(1.3, 0),
    Position(-1.3, 0),
  ]
};

Color determineLoopColor(type) {
  if (type == LoopType.NEW_LOOP) {
    return Colors.red;
  }
  if (type == LoopType.NEW_NOTIFICATION) {
    return Colors.yellowAccent;
  }
  if (type == LoopType.EXISTING_LOOP) {
    return Colors.greenAccent;
  }
  if (type == LoopType.INACTIVE_LOOP_FAILED) {
    return Colors.indigoAccent;
  }
  if (type == LoopType.INACTIVE_LOOP_SUCCESSFUL) {
    return Colors.tealAccent;
  }
  return null;
}

const kLoopContentBackgroundColor = CupertinoColors.white;

const kTextStyleLoopContent = TextStyle(
    color: CupertinoColors.white, fontWeight: FontWeight.w300, fontSize: 15);
const kLoopDetailsTextStyle = TextStyle(
  color: CupertinoColors.darkBackgroundGray,
  fontFamily: 'Open Sans',
  fontWeight: FontWeight.bold,
);

//SECTION:BOTTOM CONTAINER
final kBottomContainerDecoration = BoxDecoration(
  color: CupertinoColors.white,
);
