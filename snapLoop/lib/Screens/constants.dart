import 'package:flutter/material.dart';

// AUTH SCREEN
final kBoxDecoration = BoxDecoration(
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
  borderRadius: BorderRadius.circular(50),
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
  color: Colors.white70,
  fontSize: 40,
  fontFamily: 'Anton',
  fontWeight: FontWeight.normal,
);

//AUTH CARD
InputDecoration kgetDecoration(String text) {
  return InputDecoration(
      labelText: text,
      labelStyle: TextStyle(color: Colors.white70),
      focusColor: Colors.white70,
      errorStyle:
          TextStyle(color: Colors.white70, fontWeight: FontWeight.bold));
}

const kTextFormFieldStyle = TextStyle(color: Colors.white70);

// HOME SCREEN
