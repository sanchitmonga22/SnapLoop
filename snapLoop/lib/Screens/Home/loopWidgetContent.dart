import 'dart:math';

import 'package:SnapLoop/Model/loop.dart';
import 'package:SnapLoop/Screens/constants.dart';
import 'package:flutter/material.dart';

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
        // elevation: 8.0,
        shape: CircleBorder(),
        shadowColor: Colors.white24,
        child: Container(
            decoration: BoxDecoration(shape: BoxShape.circle),
            child: CircleAvatar(
                backgroundColor: Colors.black38,
                radius: radius,
                child: MemojiGenerator(
                    numberOfMembers: numberOfMembers, radius: radius))));
  }
}

class MemojiGenerator extends StatelessWidget {
  final int numberOfMembers;
  final double radius;
  const MemojiGenerator({
    this.radius,
    this.numberOfMembers,
    Key key,
  }) : super(key: key);
  int getRandomImageNumber() {
    return Random().nextInt(16);
  }

  @override
  Widget build(BuildContext context) {
    return Stack(children: [
      // Align(
      //     alignment: AlignmentDirectional(1, 1),
      //     child: CircleAvatar(
      //         child: Container(
      //       decoration: BoxDecoration(
      //           shape: BoxShape.circle,
      //           image: DecorationImage(
      //             fit: BoxFit.fill,
      //             image: AssetImage(
      //               'assets/memojis/m${getRandomImageNumber()}.jpg',
      //             ),
      //           )),
      //     ))),
      Align(
          alignment: AlignmentDirectional(1, 0),
          child: CircleAvatar(
              child: Container(
            decoration: BoxDecoration(
                shape: BoxShape.circle,
                image: DecorationImage(
                  fit: BoxFit.fill,
                  image: AssetImage(
                    'assets/memojis/m${getRandomImageNumber()}.jpg',
                  ),
                )),
          ))),
      Align(
          alignment: AlignmentDirectional(0, 1),
          child: CircleAvatar(
              child: Container(
            decoration: BoxDecoration(
                shape: BoxShape.circle,
                image: DecorationImage(
                  fit: BoxFit.fill,
                  image: AssetImage(
                    'assets/memojis/m${getRandomImageNumber()}.jpg',
                  ),
                )),
          ))),
      Align(
          alignment: AlignmentDirectional(0, -1),
          child: CircleAvatar(
              child: Container(
            decoration: BoxDecoration(
                shape: BoxShape.circle,
                image: DecorationImage(
                  fit: BoxFit.fill,
                  image: AssetImage(
                    'assets/memojis/m${getRandomImageNumber()}.jpg',
                  ),
                )),
          ))),
      Align(
          alignment: AlignmentDirectional(-1, 0),
          child: CircleAvatar(
              child: Container(
            decoration: BoxDecoration(
                shape: BoxShape.circle,
                image: DecorationImage(
                  fit: BoxFit.fill,
                  image: AssetImage(
                    'assets/memojis/m${getRandomImageNumber()}.jpg',
                  ),
                )),
          ))),
      Align(
          alignment: AlignmentDirectional(-1, -1),
          child: CircleAvatar(
              child: Container(
            decoration: BoxDecoration(
                shape: BoxShape.circle,
                image: DecorationImage(
                  fit: BoxFit.fill,
                  image: AssetImage(
                    'assets/memojis/m${getRandomImageNumber()}.jpg',
                  ),
                )),
          ))),
      // Align(
      //     alignment: AlignmentDirectional(0, 0),
      //     child: CircleAvatar(
      //         child: Container(
      //       decoration: BoxDecoration(
      //           shape: BoxShape.circle,
      //           image: DecorationImage(
      //             fit: BoxFit.fill,
      //             image: AssetImage(
      //               'assets/memojis/m${getRandomImageNumber()}.jpg',
      //             ),
      //           )),
      //     )))
    ]);
  }
}
