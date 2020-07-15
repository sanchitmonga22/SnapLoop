import 'package:SnapLoop/Model/loop.dart';
import 'package:SnapLoop/Screens/Chat/ExistingLoopChatScreen.dart';
import 'package:SnapLoop/Screens/Home/LoopWidget/MemojiGenerator.dart';
import 'package:SnapLoop/constants.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flip_card/flip_card.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

///author: @sanchitmonga22
/// Will add the loop ID to this to differentiate between the loops
class LoopWidget extends StatefulWidget {
  final double radius;
  final bool isTappable;
  final bool flipOnTouch;
  final Loop loop;

  const LoopWidget(
      {Key key,
      this.radius,
      this.loop,
      this.isTappable,
      this.flipOnTouch = true})
      : super(key: key);

  @override
  _LoopWidgetState createState() => _LoopWidgetState();
}

class _LoopWidgetState extends State<LoopWidget>
    with AutomaticKeepAliveClientMixin<LoopWidget> {
  Widget memojiWidget;
  @override
  void initState() {
    super.initState();
    memojiWidget = MemojiGenerator(
      loop: widget.loop,
      loopType: widget.loop.type,
    );
  }

  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Container(
      padding: EdgeInsets.all(kAllLoopsPadding),
      decoration: BoxDecoration(shape: BoxShape.circle),
      child: Hero(
        tag: widget.loop.name,
        child: CircleAvatar(
            //backgroundColor: kLoopContentBackgroundColor,
            backgroundColor: determineLoopColor(widget.loop.type)
                .withOpacity(widget.isTappable ? 0.5 : 1),
            radius: widget.radius,
            //NOTE: FlipCard() changed, Line 174 and 195 modified to include the open till pressed functionality
            // Added a VoidCallBack function onTapNavigator to detect the tap, onTapNavigator
            //       var before = DateTime.now();
            //       return GestureDetector(
            //   onTapDown: (event) {
            //     before = DateTime.now();
            //     isFront ? toggleCard() : null;
            //   },
            //   onTapUp: (event) {
            //     var diff = DateTime.now().difference(before).inMilliseconds;
            //     if (diff < 100) {
            //       widget.onTapNavigator();
            //     } else {
            //       isFront ? null : toggleCard();
            //     }
            //   },
            //   onTapCancel: () {
            //     Timer(Duration(seconds: 1), () {
            //       isFront ? null : toggleCard();
            //     });
            //   },
            //   child: child,
            //   behavior: HitTestBehavior.translucent,
            // );
            child: FlipCard(
              flipOnTouch: widget.flipOnTouch,
              onTapNavigator: () {
                if (widget.isTappable)
                  Navigator.push(
                      context,
                      new MaterialPageRoute(
                          builder: (context) => ExistingLoopChatScreen(
                                key: widget.key,
                                loop: widget.loop,
                                radius: widget.radius,
                              )));
              },
              front: memojiWidget,
              back: Center(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Expanded(
                      child: Icon(
                        CupertinoIcons.loop,
                        color: Colors.black,
                        size: widget.loop.numberOfMembers > 12
                            ? kfixedRadiusFactor["MAX"] * 70
                            : kfixedRadiusFactor[widget.loop.numberOfMembers] *
                                70,
                      ),
                    ),
                    AutoSizeText(
                      "${widget.loop.name}",
                      maxLines: 1,
                      style: kLoopDetailsTextStyle.copyWith(fontSize: 15),
                      overflow: TextOverflow.ellipsis,
                    ),
                    Expanded(
                      child: AutoSizeText(
                        "👥 ${widget.loop.numberOfMembers}",
                        maxLines: 1,
                        style: kLoopDetailsTextStyle.copyWith(fontSize: 15),
                        textAlign: TextAlign.start,
                      ),
                    ),
                  ],
                ),
              ),
            )),
      ),
    );
  }
}
