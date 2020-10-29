import 'dart:math';

import 'package:SnapLoop/Model/loop.dart';
import 'package:SnapLoop/ui/views/Home/LoopWidget/MemojiGeneratorView.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

///author: @sanchitmonga22

//SECTION: COMMON
const SERVER_IP = "http://192.168.1.12:3000";
//const SERVER_IP = "http://192.168.43.163:3000";
const kSystemPrimaryColor = CupertinoColors.activeBlue;
final kSwipeConstant = 5;
const double ksigmaX = 5.0; // from 0-10
const double ksigmaY = 5.0; // from 0-10
const double kopacity = 0.1;
const double kMaxRadius = 103;
const kTextFieldCursorColor = kSystemPrimaryColor;
const kChatViewColor = Colors.black;
final kChatViewDetailsColor = Colors.black.withOpacity(0.9);
String kMesagesplitCode = ":\n\n";

double kradiusCalculator(int numberOfMember) {
  if (numberOfMember < 13) {
    return kMaxRadius * kfixedRadiusFactor[numberOfMember];
  }
  return kMaxRadius * kfixedRadiusFactor["MAX"];
}

bool kloopComplete(LoopType type) {
  return (type == LoopType.INACTIVE_LOOP_FAILED ||
      type == LoopType.INACTIVE_LOOP_SUCCESSFUL ||
      type == LoopType.UNIDENTIFIED);
}

int kgetRandomImageNumber(int max) {
  return Random().nextInt(max - 1);
}

//SECTION: AUTH SCREEN
final kHomeScreenDecoration = BoxDecoration(
  image: DecorationImage(
      image: AssetImage(
        'assets/images/test5.PNG',
      ),
      fit: BoxFit.fill),
  //color: Colors.indigo[900]
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
        borderSide: BorderSide(color: kSystemPrimaryColor, width: 2),
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

//SECTION: NAV BAR
const kActiveNavBarIconColor = kSystemPrimaryColor;
const kInactiveNavBarIconColor = Colors.white;

//SECTION: SIGNUP WIDGET:
const double kminHeightSignUpWidget = 80;
const double kmaxHeightSignUpWidget = 250;

// SECTION: HOME SCREEN
final kAppBarBackgroundColor = Colors.white.withOpacity(0.15);
const kTextStyleHomeScreen =
    TextStyle(color: Colors.white, fontWeight: FontWeight.w600, fontSize: 15);

final kHomeScreenBoxDecoration = BoxDecoration(color: Colors.black);

// SECTION: LOOP CONTENT
// KEY: Number of Members, and Value Factor by which the maxRadius has to be reduced
// NOTE: DO NOT CHANGE THIS!!
const kfixedRadiusFactor = {
  2: 0.35,
  3: 0.36,
  4: 0.39,
  5: 0.46,
  6: 0.49,
  7: 0.52,
  8: 0.59,
  9: 0.65,
  10: 0.67,
  11: 0.70,
  12: 0.73,
  "MAX": 0.80
};
// maximum numbers of memebers that can be displayed once in a loop
const kMaxMembersDisplayed = 23;
// padding between each loop, in a row
const double kAllLoopsPadding = 20;
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
  6: [
    Position(1, 0.5),
    Position(-0.7, -1),
    Position(-1, 0.5),
    Position(0.7, -1),
    Position(0, 0),
    Position(0, 1.4)
  ],
  7: [
    Position(1, 0.5),
    Position(-0.85, -0.7),
    Position(-1, 0.5),
    Position(0.85, -0.7),
    Position(0, 0),
    Position(0, 1.2),
    Position(0, -1.4),
  ],
  8: [
    Position(0.75, 0.3),
    Position(-0.75, -0.65),
    Position(-0.75, 0.3),
    Position(0.65, -0.65),
    Position(0, 0),
    Position(0, 1),
    Position(0, -1.1),
    Position(0.9, 1.2),
  ],
  9: [
    Position(0.75, 0.2),
    Position(-0.55, -0.65),
    Position(-0.75, 0.2),
    Position(0.65, -0.65),
    Position(0, 0),
    Position(0.1, 1),
    Position(0, -1.1),
    Position(0.9, 1),
    Position(-0.65, 0.9),
  ],
  10: [
    Position(0.6, 0.35),
    Position(-0.4, -0.6),
    Position(-0.9, 0.45),
    Position(0.4, -0.6),
    Position(-0.1, 0.1),
    Position(-0.35, 0.9),
    Position(-1, -0.3),
    Position(1.1, -0.2),
    Position(0.4, 1.1),
    Position(0, -1.2)
  ],
  11: [
    Position(0.5, 0.5),
    Position(-0.5, -0.5),
    Position(-0.5, 0.5),
    Position(0.5, -0.5),
    Position(0, 0),
    Position(1.2, -0.4),
    Position(-1.2, -0.4),
    Position(0, -1),
    Position(1.2, 0.4),
    Position(-1.2, 0.4),
    Position(0, 1),
  ],
  12: [
    Position(0.5, 0.5),
    Position(-0.5, -0.5),
    Position(-0.5, 0.5),
    Position(0.5, -0.4),
    Position(0, 0),
    Position(1.2, -0.4),
    Position(-1.2, -0.4),
    Position(0, -1),
    Position(1.2, 0.4),
    Position(-1.2, 0.4),
    Position(0, 1),
    Position(0.8, -1),
  ],
  kMaxMembersDisplayed: [
    Position(0.5, 0.5),
    Position(-0.5, -0.5),
    Position(-0.5, 0.5),
    Position(0.5, -0.5),
    Position(0, 0),
    Position(0, -0.7),
    Position(0, 0.7),
    Position(1, 0),
    Position(-1, 0),
    Position(1, -1),
    Position(-1, -1),
    Position(1, 1),
    Position(-1, 1),
    Position(-0.5, 1.3),
    Position(-0.5, -1.3),
    Position(0.5, 1.3),
    Position(0.5, -1.3),
    Position(-1.2, -0.5),
    Position(1.2, -0.5),
    Position(-1.2, 0.5),
    Position(1.2, 0.5),
    Position(0, -1.3),
    Position(0, 1.3),
  ],
};

Color determineLoopColor(type) {
  if (type == LoopType.NEW_LOOP) {
    return Colors.redAccent[700];
  }
  if (type == LoopType.NEW_NOTIFICATION) {
    return Colors.lightBlueAccent[700];
  }
  if (type == LoopType.EXISTING_LOOP) {
    return CupertinoColors.systemIndigo;
  }
  if (type == LoopType.INACTIVE_LOOP_FAILED) {
    return Colors.blueGrey;
  }
  if (type == LoopType.INACTIVE_LOOP_SUCCESSFUL) {
    return Colors.tealAccent[700];
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
