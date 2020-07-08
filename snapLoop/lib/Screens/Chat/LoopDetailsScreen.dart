import 'package:SnapLoop/Model/loop.dart';
import 'package:SnapLoop/Screens/Home/LoopWidget/loopWidget.dart';
import 'package:SnapLoop/Screens/NavBar.dart';
import 'package:SnapLoop/constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

/// author: @sanchitmonga22
class LoopsDetailsScreen extends StatefulWidget {
  LoopsDetailsScreen(
      {Key key,
      this.loop,
      this.loopWidget,
      this.backgroundColor,
      this.chatWidget})
      : super(key: key);
  final LoopWidget loopWidget;
  final Loop loop;
  final Color backgroundColor;
  final Widget chatWidget;

  @override
  _LoopsDetailsScreenState createState() => _LoopsDetailsScreenState();
}

class _LoopsDetailsScreenState extends State<LoopsDetailsScreen> {
  bool details = false;
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        onWillPop: () {
          if (details) {
            setState(() {
              details = false;
            });
          } else if (Navigator.of(context).canPop()) {
            Navigator.of(context).pop();
          } else {
            Navigator.of(context).pushReplacementNamed(NavBar.routeName);
          }
        },
        child: SafeArea(
          child: Scaffold(
            body: Stack(children: [
              Container(
                color: Colors.black.withOpacity(0.7),
              ),
              Container(
                  alignment: Alignment.topCenter,
                  decoration: BoxDecoration(
                      color: widget.backgroundColor.withOpacity(0.4)),
                  child: Column(
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(top: 10),
                            child: CupertinoButton(
                              child: Icon(
                                Icons.arrow_back,
                                color: Colors.white,
                              ),
                              onPressed: () {
                                if (details) {
                                  setState(() {
                                    details = false;
                                  });
                                } else {
                                  if (Navigator.of(context).canPop())
                                    Navigator.of(context).pop();
                                  else
                                    Navigator.pushReplacementNamed(
                                        context, NavBar.routeName);
                                }
                              },
                            ),
                          ),
                          widget.loopWidget,
                          Padding(
                            padding: const EdgeInsets.only(top: 10),
                            child: CupertinoButton(
                              child: Icon(
                                CupertinoIcons.info,
                                color: Colors.white,
                              ),
                              onPressed: () {
                                setState(() {
                                  details = !details;
                                });
                              },
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                        "Number of Member:  ",
                        style: kTextFormFieldStyle,
                      ),
                    ],
                  )),
              if (!details)
                Container(
                    margin: EdgeInsets.only(
                        top: MediaQuery.of(context).size.width / 5),
                    decoration: BoxDecoration(color: Colors.white),
                    child: widget.chatWidget)
            ]),
          ),
        ));
  }
}
