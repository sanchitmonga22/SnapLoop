import 'package:SnapLoop/Model/loop.dart';
import 'package:SnapLoop/Screens/Home/LoopWidget/MemojiGenerator.dart';
import 'package:SnapLoop/Screens/constants.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flip_card/flip_card.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

///author: @sanchitmonga22
class LoopWidget extends StatelessWidget {
  final double radius;
  final String text;
  final int numberOfMembers;
  final LoopType type;
  LoopWidget({this.radius, this.text, this.numberOfMembers, this.type});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(kAllLoopsPadding),
      decoration: BoxDecoration(shape: BoxShape.circle),
      child: CircleAvatar(
          backgroundColor: kLoopContentBackgroundColor,
          radius: radius,
          //NOTE: FlipCard() changed, Line 170 and 186 modified to include the open till pressed functionality
          child: FlipCard(
            front: MemojiGenerator(
                loopType: type,
                numberOfMembers: numberOfMembers,
                radius: radius),
            back: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    CupertinoIcons.loop,
                    color: Colors.black,
                  ),
                  AutoSizeText(
                    "$text",
                    maxLines: 1,
                    style: kLoopDetailsTextStyle,
                    overflow: TextOverflow.ellipsis,
                  ),
                  AutoSizeText(
                    "👥 $numberOfMembers",
                    maxLines: 1,
                    style: kLoopDetailsTextStyle,
                    textAlign: TextAlign.start,
                  ),
                ],
              ),
            ),
          )),
    );
  }
}
