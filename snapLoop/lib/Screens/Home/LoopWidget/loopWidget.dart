import 'package:SnapLoop/Model/loop.dart';
import 'package:SnapLoop/Screens/Chat/ExistingLoopChatScreen.dart';
import 'package:SnapLoop/Screens/Home/LoopWidget/MemojiGenerator.dart';
import 'package:SnapLoop/Screens/constants.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flip_card/flip_card.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

///author: @sanchitmonga22
class LoopWidget extends StatefulWidget {
  final double radius;
  final String loopName;
  final int numberOfMembers;
  final LoopType type;
  LoopWidget({this.radius, this.loopName, this.numberOfMembers, this.type});

  @override
  _LoopWidgetState createState() => _LoopWidgetState();
}

class _LoopWidgetState extends State<LoopWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(kAllLoopsPadding),
      decoration: BoxDecoration(shape: BoxShape.circle),
      child: Hero(
        // to avoid pixel overflow
        flightShuttleBuilder: (
          BuildContext flightContext,
          Animation<double> animation,
          HeroFlightDirection flightDirection,
          BuildContext fromHeroContext,
          BuildContext toHeroContext,
        ) {
          return SingleChildScrollView(
            child: fromHeroContext.widget,
          );
        },
        tag: widget.loopName,
        child: GestureDetector(
          onTap: () {
            // Navigator.of(context).pushReplacementNamed(
            //   ExistingLoopChatScreen.routeName,
            //   //arguments: [type, loopName]
            // );
            Navigator.push(
                context,
                new MaterialPageRoute(
                    builder: (context) => ExistingLoopChatScreen(
                          loopID: "",
                          loopName: widget.loopName,
                          loopType: widget.type,
                        )));
          },
          child: CircleAvatar(
              //backgroundColor: kLoopContentBackgroundColor,
              backgroundColor: determineLoopColor(widget.type).withOpacity(0.5),
              radius: widget.radius,
              //NOTE: FlipCard() changed, Line 170 and 186 modified to include the open till pressed functionality
              // Replaced Gesture Detector with Listener
              //     return Listener(
              //   onPointerDown: (event) {
              //     isFront ? toggleCard() : null;
              //   },
              //   onPointerUp: (event) {
              //     isFront ? null : toggleCard();
              //   },
              //   child: child,
              //   behavior: HitTestBehavior.translucent,
              // );
              child: FlipCard(
                front: MemojiGenerator(
                    loopType: widget.type,
                    numberOfMembers: widget.numberOfMembers,
                    radius: widget.radius),
                back: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        CupertinoIcons.loop,
                        color: Colors.black,
                      ),
                      AutoSizeText(
                        "${widget.loopName}",
                        maxLines: 1,
                        style: kLoopDetailsTextStyle,
                        overflow: TextOverflow.ellipsis,
                      ),
                      AutoSizeText(
                        "👥 ${widget.numberOfMembers}",
                        maxLines: 1,
                        style: kLoopDetailsTextStyle,
                        textAlign: TextAlign.start,
                      ),
                    ],
                  ),
                ),
              )),
        ),
      ),
    );
  }
}
