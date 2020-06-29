import 'package:SnapLoop/Provider/UserDataProvider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../constants.dart';

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
        Text(
          "Snap∞Loop",
          style: kTextFormFieldStyle.copyWith(fontSize: 25),
        ),
        GestureDetector(
          onTap: () {},
          child: Container(
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
        ),
      ],
    );
  }
}
