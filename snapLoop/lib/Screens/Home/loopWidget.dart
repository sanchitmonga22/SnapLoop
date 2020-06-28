import 'package:SnapLoop/Model/loop.dart';
import 'package:SnapLoop/Screens/Home/loopWidgetContent.dart';
import 'package:avatar_glow/avatar_glow.dart';
import 'package:flutter/material.dart';

// Represents a single loop used in the LoopWidgetContainer
class LoopWidget extends StatefulWidget {
  final numberOfMembers;
  final text;
  final LoopType type;
  final radius;
  const LoopWidget({this.numberOfMembers, this.text, this.type, this.radius});
  @override
  _LoopWidgetState createState() => _LoopWidgetState();
}

class _LoopWidgetState extends State<LoopWidget> {
  Color determineLoopColor() {
    if (widget.type == LoopType.NEW_LOOP) {
      return Colors.pink;
    }
    if (widget.type == LoopType.NEW_NOTIFICATION) {
      return Colors.green;
    }
    return Colors.yellowAccent;
  }

  bool isInactive() {
    if (widget.type == LoopType.INACTIVE_LOOP_FAILED ||
        widget.type == LoopType.INACTIVE_LOOP_SUCCESSFUL) {
      return true;
    }
    return false;
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
        child: Container(
            padding: isInactive() ? EdgeInsets.all(5) : null,
            child: isInactive()
                ? LoopWidgetContent(
                    numberOfMembers: widget.numberOfMembers,
                    radius: widget.radius,
                    text: widget.text,
                    type: widget.type,
                  )
                : AvatarGlow(
                    startDelay: Duration(milliseconds: 100),
                    glowColor: determineLoopColor(),
                    endRadius: widget.radius * 1.25,
                    shape: BoxShape.circle,
                    duration: Duration(milliseconds: 1000),
                    repeat: true,
                    animate: true,
                    repeatPauseDuration: Duration(milliseconds: 1),
                    child: LoopWidgetContent(
                      numberOfMembers: widget.numberOfMembers,
                      radius: widget.radius,
                      text: widget.text,
                      type: widget.type,
                    ))));
  }
}
