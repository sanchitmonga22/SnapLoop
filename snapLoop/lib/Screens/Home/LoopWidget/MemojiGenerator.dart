import 'dart:math';

import 'package:SnapLoop/Model/loop.dart';
import 'package:SnapLoop/Screens/Home/Bitmojis/bitmoji.dart';
import 'package:flutter/material.dart';
import '../../constants.dart';

///author: @sanchitmonga22
class MemojiGenerator extends StatefulWidget {
  final int numberOfMembers;
  final LoopType loopType;

  const MemojiGenerator({Key key, this.numberOfMembers, this.loopType})
      : super(key: key);

  @override
  _MemojiGeneratorState createState() => _MemojiGeneratorState();
}

// IMPORTANT: To keep each and every memoji image alive, we can use pageStorageBucket to store the values of each and every image along with a
//unique key and then we can get it back by using that key
class _MemojiGeneratorState extends State<MemojiGenerator> {
  List<Widget> getMemojis(int numberOfMembers) {
    if (numberOfMembers > kMaxMembersDisplayed) {
      numberOfMembers = kMaxMembersDisplayed;
    }
    List<Widget> memojis = [];
    for (int i = 0; i < numberOfMembers; i++) {
      memojis.add(Memoji(
        loopType: widget.loopType,
        position: kalignmentMap[kMaxMembersDisplayed][i],
      ));
    }
    return memojis;
  }

  @override
  Widget build(BuildContext context) {
    return Stack(children: [
      if (widget.numberOfMembers <= 13)
        ...kalignmentMap[widget.numberOfMembers].map((position) {
          return Memoji(
            loopType: widget.loopType,
            position: position,
          );
        }).toList()
      else
        ...getMemojis(widget.numberOfMembers).toList()
    ]);
  }
}

class Memoji extends StatefulWidget {
  final Position position;
  final loopType;
  const Memoji({this.loopType, Key key, this.position}) : super(key: key);

  @override
  _MemojiState createState() => _MemojiState();
}

class _MemojiState extends State<Memoji> {
  int getRandomImageNumber(int max) {
    return Random().nextInt(max);
  }

  NetworkImage getImage() {
    return NetworkImage(URLMemojis[getRandomImageNumber(URLMemojis.length - 1)]
        .replaceAll("%s", USERS[getRandomImageNumber(USERS.length - 1)]));
  }

  @override
  Widget build(BuildContext context) {
    return Align(
        alignment: AlignmentDirectional(widget.position.x, widget.position.y),
        child: CircleAvatar(
            child: Container(
          decoration: BoxDecoration(
              boxShadow: [
                BoxShadow(
                    blurRadius: 5, color: determineLoopColor(widget.loopType))
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
