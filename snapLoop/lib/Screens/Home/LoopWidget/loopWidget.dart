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
  final String loopName;
  final int numberOfMembers;
  final LoopType type;
  final isTappable;

  const LoopWidget(
      {Key key,
      this.radius,
      this.loopName,
      this.numberOfMembers,
      this.type,
      this.isTappable})
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
      loopType: widget.type,
      numberOfMembers: widget.numberOfMembers,
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
        tag: widget.loopName,
        child: CircleAvatar(
            //backgroundColor: kLoopContentBackgroundColor,
            backgroundColor: determineLoopColor(widget.type)
                .withOpacity(widget.isTappable ? 0.5 : 1),
            radius: widget.radius,
            //NOTE: FlipCard() changed, Line 174 and 195 modified to include the open till pressed functionality
            // Added a VoidCallBack function onTapNavigator to detect the tap, onTapNavigator
            //       var before = DateTime.now();
            // return GestureDetector(
            //   onTapDown: (event) {
            //     if (DateTime.now().difference(before).inMilliseconds > 150)
            //       isFront ? toggleCard() : null;
            //   },
            //   onTapUp: (event) {
            //     isFront ? null : toggleCard();
            //   },
            //   onTap: () {
            //     if (DateTime.now().difference(before).inMilliseconds < 150) {
            //       widget.onTapNavigator();
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
              onTapNavigator: () {
                if (widget.isTappable)
                  Navigator.push(
                      context,
                      new MaterialPageRoute(
                          builder: (context) => ExistingLoopChatScreen(
                                key: widget.key,
                                loopID: "",
                                loopName: widget.loopName,
                                loopType: widget.type,
                                numberOfMembers: widget.numberOfMembers,
                                radius: widget.radius,
                              )));
              },
              front: memojiWidget,
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
    );
  }
}
