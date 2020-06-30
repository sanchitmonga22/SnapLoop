import 'dart:math';

import 'package:SnapLoop/Model/loop.dart';
import 'package:SnapLoop/Screens/Home/Bitmojis/bitmoji.dart';
import 'package:flutter/material.dart';
import '../../constants.dart';

///author: @sanchitmonga22
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

  List<Widget> getMemojis(int numberOfMembers) {
    if (numberOfMembers > 13) {
      numberOfMembers = 13;
    }
    List<Widget> memojis = [];
    for (int i = 0; i < numberOfMembers; i++) {
      memojis.add(Memoji(
        loopType: loopType,
        imageNumber: getRandomImageNumber(),
        position: kalignmentMap[13][i],
      ));
    }
    return memojis;
  }

  @override
  Widget build(BuildContext context) {
    return Stack(children: [
      if (numberOfMembers <= 5)
        ...kalignmentMap[numberOfMembers].map((position) {
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
  int getRandomImageNumber(int max) {
    return Random().nextInt(max);
  }

  // generating the random network image
  // TODO: To add this feature into the server and not here!!
  NetworkImage getImage() {
    NetworkImage image;
    while (image == null) {
      try {
        image = NetworkImage(
            URLMemojis[getRandomImageNumber(URLMemojis.length - 1)].replaceAll(
                "%s", USERS[getRandomImageNumber(USERS.length - 1)]));
      } catch (e) {
        print(e);
      }
    }
    return image;
  }

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
              image: DecorationImage(fit: BoxFit.fitHeight, image: getImage())),
        )));
  }
}

class Position {
  final double x;
  final double y;
  const Position(this.x, this.y);

  // distance formula in coordinate geometry
  double findDistance(Position position) {
    return sqrt(
        pow((position.x - this.x), 2) + (pow((position.y - this.y), 2)));
  }
}
