import 'package:SnapLoop/Model/loop.dart';
import 'package:SnapLoop/app/router.gr.dart';
import 'package:SnapLoop/ui/Widget/time/timer.dart';
import 'package:SnapLoop/app/constants.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flip_card/flip_card.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:stacked/stacked.dart';

import 'MemojiGeneratorView.dart';
import 'loopWidgetViewModel.dart';

///author: @sanchitmonga22
/// Will add the loop ID to this to differentiate between the loops
class LoopWidgetView extends StatefulWidget {
  final double radius;
  final bool isTappable;
  final bool flipOnTouch;
  final Loop loop;
  final Key key;

  const LoopWidgetView(
      {this.key,
      this.radius,
      this.loop,
      this.isTappable,
      this.flipOnTouch = true})
      : super(key: key);

  @override
  _LoopWidgetViewState createState() => _LoopWidgetViewState();
}

class _LoopWidgetViewState extends State<LoopWidgetView>
    with AutomaticKeepAliveClientMixin<LoopWidgetView> {
  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return ViewModelBuilder.reactive(
      viewModelBuilder: () => LoopWidgetViewModel(),
      builder: (context, model, child) {
        return Container(
          padding: EdgeInsets.all(kAllLoopsPadding),
          decoration: BoxDecoration(shape: BoxShape.circle),
          child: Hero(
            tag: widget.loop.id,
            child: CircleAvatar(
                //backgroundColor: kLoopContentBackgroundColor,
                backgroundColor: determineLoopColor(widget.loop.type)
                //.withOpacity(widget.isTappable ? 0.5 : 1),
                ,
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
                      Navigator.pushNamed(context, Routes.existingLoopChatView,
                          arguments: ExistingLoopChatViewArguments(
                            key: widget.key,
                            loop: widget.loop,
                            radius: widget.radius,
                          ));
                  },
                  front: MemojiGenerator(
                    loop: widget.loop,
                    loopType: widget.loop.type,
                  ),
                  back: Center(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Expanded(
                          child: widget.loop.atTimeEnding != null &&
                                  !kloopComplete(widget.loop.type)
                              ? LoopTimer(
                                  color: Colors.white,
                                  atTimeEnding: widget.loop.atTimeEnding,
                                )
                              : Icon(
                                  CupertinoIcons.loop_thick,
                                  color: Colors.white,
                                  size: widget.loop.numberOfMembers > 12
                                      ? kfixedRadiusFactor["MAX"] * 70
                                      : kfixedRadiusFactor[
                                              widget.loop.numberOfMembers] *
                                          70,
                                ),
                        ),
                        AutoSizeText(
                          "${widget.loop.name}",
                          maxLines: 1,
                          style: kLoopDetailsTextStyle.copyWith(
                              fontSize: 15, color: Colors.white),
                          overflow: TextOverflow.ellipsis,
                        ),
                        Expanded(
                          child: AutoSizeText(
                            "👥 ${widget.loop.numberOfMembers}",
                            maxLines: 1,
                            style: kLoopDetailsTextStyle.copyWith(
                                fontSize: 15, color: Colors.white),
                            textAlign: TextAlign.start,
                          ),
                        ),
                      ],
                    ),
                  ),
                )),
          ),
        );
      },
    );
  }
}
