import 'package:SnapLoop/Model/loop.dart';
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
  @override
  Widget build(BuildContext context) {
    return Container(
        padding: EdgeInsets.all(5),
        child: FlatButton(
          onPressed: () => {},
          child: CircleAvatar(
            backgroundColor: Theme.of(context).accentColor,
            radius: widget.radius,
            child: Column(
              children: [
                Text(
                  widget.text,
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
          ),
        ));
  }
}
