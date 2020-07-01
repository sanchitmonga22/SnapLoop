import 'package:SnapLoop/Model/loop.dart';
import 'package:SnapLoop/Screens/Home/LoopWidget/MemojiGenerator.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

///author: @sanchitmonga22

//COMMON
final kSwipeConstant = 5;
const double ksigmaX = 5.0; // from 0-10
const double ksigmaY = 5.0; // from 0-10
const double kopacity = 0.1;

// AUTH SCREEN
final kBoxDecoration = BoxDecoration(
  image: DecorationImage(
      image: AssetImage(
        'assets/images/test5.PNG',
      ),
      fit: BoxFit.fill),
  gradient: LinearGradient(
    colors: [
      Color.fromRGBO(94, 53, 177, 1).withOpacity(0.5),
      Color.fromRGBO(74, 20, 140, 1).withOpacity(0.9),
      // Color.fromRGBO(150, 200, 255, 1).withOpacity(0.5),
      // Color.fromRGBO(150, 255, 117, 1).withOpacity(0.9),
    ],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    stops: [0, 1],
  ),
);

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

final kFontStyleLOGO = TextStyle(
  color: Colors.white,
  fontSize: 30,
  fontFamily: 'Anton',
  fontWeight: FontWeight.bold,
);

//AUTH CARD
InputDecoration kgetDecoration(String text) {
  return InputDecoration(
      labelText: text,
      labelStyle: TextStyle(color: Colors.white, fontWeight: FontWeight.w600),
      focusColor: Colors.white,
      errorStyle: TextStyle(color: Colors.white, fontWeight: FontWeight.bold));
}

const kTextFormFieldStyle =
    TextStyle(color: Colors.white, fontWeight: FontWeight.w600);

// HOME SCREEN
const kAppBarBackgroundColor = Colors.black;
const kTextStyleHomeScreen =
    TextStyle(color: Colors.white, fontWeight: FontWeight.w600, fontSize: 15);

final kHomeScreenBoxDecoration = BoxDecoration(
    // gradient: LinearGradient(
    //   colors: [
    //     Color.fromRGBO(94, 53, 177, 1).withOpacity(0.3),
    //     Color.fromRGBO(74, 20, 140, 1).withOpacity(0.8),
    //     // Color.fromRGBO(150, 200, 255, 1).withOpacity(0.5),
    //     // Color.fromRGBO(150, 255, 117, 1).withOpacity(0.9),
    //   ],
    //   begin: Alignment.topLeft,
    //   end: Alignment.bottomRight,
    //   stops: [0, 1],
    // ),
    color: CupertinoColors.systemGrey2);

//LOOP CONTENT

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

//BOTTOM CONTAINER
final kBottomContainerDecoration = BoxDecoration(
  color: CupertinoColors.white,
);
