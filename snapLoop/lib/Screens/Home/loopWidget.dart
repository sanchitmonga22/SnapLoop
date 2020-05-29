import 'package:flutter/material.dart';

// Represents a single loop used in the LoopWidgetContainer
class LoopWidget extends StatefulWidget {
  final radius;

  const LoopWidget({this.radius});

  @override
  _LoopWidgetState createState() => _LoopWidgetState();
}

class _LoopWidgetState extends State<LoopWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: CircleAvatar(
        radius: widget.radius,
      ),
    );
  }
}
