import 'dart:math';

import 'package:SnapLoop/Model/loop.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:SnapLoop/constants.dart';
import 'package:http/http.dart' as http;

///author: @sanchitmonga22
class MemojiGenerator extends StatefulWidget {
  final Loop loop;
  final LoopType loopType;

  const MemojiGenerator({Key key, this.loopType, this.loop}) : super(key: key);

  @override
  _MemojiGeneratorState createState() => _MemojiGeneratorState();
}

class _MemojiGeneratorState extends State<MemojiGenerator> {
  List<Widget> getMemojis(int numberOfMembers) {
    if (numberOfMembers > kMaxMembersDisplayed) {
      numberOfMembers = kMaxMembersDisplayed;
    }
    List<Widget> memojis = [];
    for (int i = 0; i < numberOfMembers; i++) {
      memojis.add(Memoji(
        loopType: widget.loopType,
        position: kalignmentMap[kMaxMembersDisplayed][i],
      ));
    }
    return memojis;
  }

  @override
  Widget build(BuildContext context) {
    List<String> images = widget.loop.avatars.values.toList();
    int i = 0;
    return Stack(children: [
      if (widget.loop.numberOfMembers < 13)
        ...kalignmentMap[widget.loop.numberOfMembers].map((position) {
          i++;
          return Memoji(
            imageUrl: images[i - 1],
            loopType: widget.loopType,
            position: position,
          );
        }).toList()
      else
        ...getMemojis(widget.loop.numberOfMembers).toList()
    ]);
  }
}

class Memoji extends StatefulWidget {
  final String imageUrl;
  final Position position;
  final loopType;
  const Memoji({this.loopType, Key key, this.position, this.imageUrl})
      : super(key: key);

  @override
  _MemojiState createState() => _MemojiState();
}

class _MemojiState extends State<Memoji> {
  Future future;
  DecorationImage image;
  @override
  void initState() {
    super.initState();
    future = getImage();
  }

  // checking whether the image throws an error
  Future<bool> getImage() async {
    http.Response res = await http.get(widget.imageUrl);
    if (res.statusCode >= 400) {
      image = DecorationImage(
          fit: BoxFit.fitHeight, image: AssetImage("assets/memojis/m10.jpg"));
    } else {
      image = DecorationImage(
          fit: BoxFit.fitHeight, image: NetworkImage(widget.imageUrl));
    }
    return true;
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: future,
      builder: (context, snapshot) {
        return snapshot.connectionState == ConnectionState.waiting
            ? Container()
            : Align(
                alignment:
                    AlignmentDirectional(widget.position.x, widget.position.y),
                child: CircleAvatar(
                    child: Container(
                        decoration: BoxDecoration(
                  boxShadow: [BoxShadow(blurRadius: 5, color: Colors.white)],
                  shape: BoxShape.circle,
                  image: image,
                ))));
      },
    );
  }
}

class Position {
  final double x;
  final double y;
  const Position(this.x, this.y);

  // distance formula in coordinate geometry
  double findDistance(Position position) {
    return sqrt(
        pow((position.x - this.x), 2) + (pow((position.y - this.y), 2)));
  }
}
