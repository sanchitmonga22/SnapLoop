import 'dart:math';

import 'package:SnapLoop/Model/loop.dart';
import 'package:SnapLoop/Screens/constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

///author: @sanchitmonga22
class LoopWidgetContent extends StatelessWidget {
  final double radius;
  final String text;
  final int numberOfMembers;
  final LoopType type;
  const LoopWidgetContent(
      {this.radius, this.text, this.numberOfMembers, this.type});

  @override
  Widget build(BuildContext context) {
    return Material(
        color: Colors.transparent,
        shape: CircleBorder(),
        shadowColor: Colors.white24,
        child: Container(
            decoration: BoxDecoration(
              shape: BoxShape.circle,
            ),
            child: CircleAvatar(
                backgroundColor: kLoopContentBackgroundColor,
                radius: radius,
                child: MemojiGenerator(
                    loopType: type,
                    numberOfMembers: numberOfMembers,
                    radius: radius))));
  }
}

class MemojiGenerator extends StatelessWidget {
  final int numberOfMembers;
  final double radius;
  final LoopType loopType;
  MemojiGenerator({
    this.loopType,
    this.radius,
    this.numberOfMembers,
  });
  int getRandomImageNumber() {
    return Random().nextInt(16);
  }

  final Map<dynamic, dynamic> alignmentMap = {
    2: [Position(1, 1), Position(-1, -1)],
    3: [
      Position(0, -1),
      Position(-2 / sqrt(3), 1),
      Position(2 / sqrt(3), 1),
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

  List<Widget> getMemojis(int numberOfMembers) {
    if (numberOfMembers > 13) {
      numberOfMembers = 13;
    }
    List<Widget> memojis = [];
    for (int i = 0; i < numberOfMembers; i++) {
      memojis.add(Memoji(
        loopType: loopType,
        imageNumber: getRandomImageNumber(),
        position: alignmentMap[13][i],
      ));
    }
    return memojis;
  }

  @override
  Widget build(BuildContext context) {
    return Stack(children: [
      if (numberOfMembers <= 5)
        ...alignmentMap[numberOfMembers].map((position) {
          return Memoji(
            loopType: loopType,
            imageNumber: getRandomImageNumber(),
            position: position,
          );
        }).toList()
      else
        ...getMemojis(numberOfMembers).toList()
    ]);
  }
}

class Memoji extends StatelessWidget {
  final Position position;
  final imageNumber;
  final loopType;
  const Memoji({this.loopType, this.imageNumber, Key key, this.position})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Align(
        alignment: AlignmentDirectional(position.x, position.y),
        child: CircleAvatar(
            child: Container(
          decoration: BoxDecoration(
              boxShadow: [
                BoxShadow(blurRadius: 5, color: determineLoopColor(loopType))
              ],
              shape: BoxShape.circle,
              image: DecorationImage(
                fit: BoxFit.fitHeight,
                image: AssetImage(
                  'assets/memojis/m$imageNumber.jpg',
                ),
              )),
        )));
  }
}

class Position {
  final double x;
  final double y;
  Position(this.x, this.y);

  // distance formula in coordinate geometry
  double findDistance(Position position) {
    return sqrt(
        pow((position.x - this.x), 2) + (pow((position.y - this.y), 2)));
  }
}
