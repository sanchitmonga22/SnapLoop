import 'package:SnapLoop/Model/loop.dart';
import 'package:flutter/material.dart';

class LoopWidgetContent extends StatelessWidget {
  final double radius;
  final String text;
  final int numberOfMembers;
  final LoopType type;

  const LoopWidgetContent(
      {this.radius, this.text, this.numberOfMembers, this.type});

  @override
  Widget build(BuildContext context) {
    return Material(
        elevation: 8.0,
        shape: CircleBorder(),
        child: Container(
          child: CircleAvatar(
              backgroundColor: Theme.of(context).accentColor,
              radius: radius,
              child: RawMaterialButton(
                //padding: EdgeInsets.symmetric(),
                //elevation: 2.0,
                shape: CircleBorder(side: BorderSide(width: double.infinity)),
                onPressed: () {
                  //TODO:
                },
                child: Column(
                  children: [
                    Text(
                      text,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          backgroundColor: Theme.of(context).primaryColor),
                    ),
                    Text(
                      "Members: $numberOfMembers",
                      overflow: TextOverflow.fade,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          backgroundColor: Theme.of(context).primaryColor),
                    ),
                    Text(
                        type
                            .toString()
                            .substring(type.toString().indexOf('.') + 1)
                            .toLowerCase(),
                        overflow: TextOverflow.fade)
                  ],
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                ),
              )),
        ));
  }
}
