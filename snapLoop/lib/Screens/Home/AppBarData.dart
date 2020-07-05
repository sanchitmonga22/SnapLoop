import 'package:SnapLoop/Provider/UserDataProvider.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../constants.dart';

class AppBarData extends StatelessWidget {
  const AppBarData({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final userDataProvider = Provider.of<UserDataProvider>(context);
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          "Score: ${userDataProvider.userScore.toString()}",
          textAlign: TextAlign.left,
          style: kTextStyleHomeScreen,
        ),
        SizedBox(
          child: ColorizeAnimatedTextKit(
            speed: Duration(seconds: 1),
            isRepeatingAnimation: false,
            text: ["Snap∞Loop"],
            textStyle: TextStyle(
                fontSize: 25.0,
                fontFamily: "Open Sans",
                fontWeight: FontWeight.w900),
            colors: [
              // Colors.purple,
              Colors.white70,
              Colors.yellow,
              Colors.blueGrey,
            ],
            textAlign: TextAlign.center,
            repeatForever: false,
          ),
        ),
        Container(
          foregroundDecoration: BoxDecoration(
              border: Border.all(style: BorderStyle.solid),
              borderRadius: BorderRadius.circular(10)),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              userDataProvider.displayName,
              style: kTextStyleHomeScreen,
            ),
          ),
        ),
      ],
    );
  }
}
