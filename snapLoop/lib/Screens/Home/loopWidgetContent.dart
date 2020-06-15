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
        color: Colors.transparent,
        elevation: 8.0,
        shape: CircleBorder(),
        shadowColor: Colors.white24,
        child: Container(
          decoration: BoxDecoration(shape: BoxShape.circle),
          child: CircleAvatar(
              backgroundColor: Colors.transparent,
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
                        color: Colors.black87,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text("Members: $numberOfMembers",
                        overflow: TextOverflow.fade,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Colors.black87,
                          fontWeight: FontWeight.bold,
                        )),
                    Text(
                        type
                            .toString()
                            .substring(type.toString().indexOf('.') + 1)
                            .toLowerCase(),
                        overflow: TextOverflow.fade,
                        style: TextStyle(
                          color: Colors.black87,
                          fontWeight: FontWeight.bold,
                        ))
                  ],
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                ),
              )),
        ));
  }
}
