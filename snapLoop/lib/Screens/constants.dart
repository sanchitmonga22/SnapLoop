import 'package:SnapLoop/Model/loop.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

///author: @sanchitmonga22

//COMMON
final kSwipeConstant = 5;

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

const kLoopContentBackgroundColor = CupertinoColors.extraLightBackgroundGray;

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
