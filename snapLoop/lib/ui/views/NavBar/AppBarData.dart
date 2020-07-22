import 'package:SnapLoop/ui/views/NavBar/AppBarModel.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

import '../../../constants.dart';

class AppBarData extends StatelessWidget {
  const AppBarData({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder.reactive(
      viewModelBuilder: () => AppBarModel(),
      builder: (context, model, child) {
        return Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "Score: ${model.userScore.toString()}",
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
                  model.displayName,
                  style: kTextStyleHomeScreen,
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}
