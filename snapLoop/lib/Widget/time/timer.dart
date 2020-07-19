import 'dart:async';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../constants.dart';

class LoopTimer extends StatefulWidget {
  final DateTime atTimeEnding;
  LoopTimer({Key key, this.atTimeEnding}) : super(key: key);

  @override
  _LoopTimerState createState() => _LoopTimerState();
}

class _LoopTimerState extends State<LoopTimer> {
  @override
  Widget build(BuildContext context) {
    int timeEnding = widget.atTimeEnding.millisecondsSinceEpoch;
    return StreamBuilder(
      stream: Stream.periodic(Duration(seconds: 1), (i) => i),
      builder: (context, snapshot) {
        DateFormat format = DateFormat('mm:ss');
        int now = DateTime.now().millisecondsSinceEpoch;
        Duration remaining = Duration(milliseconds: timeEnding - now);
        var dateString =
            '${remaining.inHours}:${format.format(DateTime.fromMillisecondsSinceEpoch(remaining.inMilliseconds))}';
        return AutoSizeText(
          dateString,
          maxLines: 1,
          style: kLoopDetailsTextStyle.copyWith(fontSize: 15),
          overflow: TextOverflow.ellipsis,
        );
      },
    );
  }
}
