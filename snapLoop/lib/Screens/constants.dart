import 'package:flutter/material.dart';

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
