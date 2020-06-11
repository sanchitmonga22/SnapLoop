import 'package:SnapLoop/Model/loop.dart';
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
      return Colors.red[900];
    }
    if (widget.type == LoopType.NEW_NOTIFICATION) {
      return Colors.green[900];
    }
    return Colors.amber[900];
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: AvatarGlow(
          startDelay: Duration(milliseconds: 100),
          glowColor: determineLoopColor(),
          endRadius: widget.radius * 1.25,
          duration: Duration(milliseconds: 1000),
          repeat: true,
          showTwoGlows: true,
          repeatPauseDuration: Duration(milliseconds: 10),
          child: Material(
              elevation: 8.0,
              shape: CircleBorder(),
              child: CircleAvatar(
                  backgroundColor: Theme.of(context).accentColor,
                  radius: widget.radius,
                  child: RawMaterialButton(
                    //padding: EdgeInsets.symmetric(),
                    elevation: 2.0,
                    shape:
                        CircleBorder(side: BorderSide(width: double.infinity)),
                    onPressed: () {},
                    child: Column(
                      children: [
                        Text(
                          widget.text,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              backgroundColor: Theme.of(context).primaryColor),
                        ),
                        Text(
                          "Members: ${widget.numberOfMembers}",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              backgroundColor: Theme.of(context).primaryColor),
                        ),
                        Text(widget.type
                            .toString()
                            .substring(widget.type.toString().indexOf('.') + 1)
                            .toLowerCase())
                      ],
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                    ),
                  )))),
    );
  }
}
