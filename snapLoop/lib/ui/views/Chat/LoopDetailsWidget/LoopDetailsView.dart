import 'package:SnapLoop/Model/loop.dart';
import 'package:SnapLoop/ui/Widget/time/timer.dart';
import 'package:SnapLoop/app/router.gr.dart';
import 'package:SnapLoop/app/constants.dart';
import 'package:SnapLoop/ui/views/Chat/LoopDetailsWidget/UserDetailsInLoopDetailsView.dart';
import 'package:SnapLoop/ui/views/Home/LoopWidget/loopWidgetView.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

/// author: @sanchitmonga22
class LoopsDetailsView extends StatefulWidget {
  LoopsDetailsView({Key key, this.loop, this.loopWidget, this.chatWidget})
      : super(key: key);
  final LoopWidgetView loopWidget;
  final Loop loop;
  final Widget chatWidget;

  @override
  _LoopsDetailsViewState createState() => _LoopsDetailsViewState();
}

class _LoopsDetailsViewState extends State<LoopsDetailsView> {
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
            Navigator.of(context).pushReplacementNamed(Routes.navBarView);
          }
        },
        child: SafeArea(
          child: Scaffold(
            body: Stack(children: [
              Container(
                  alignment: Alignment.topCenter,
                  decoration: BoxDecoration(color: kChatViewDetailsColor),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
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
                                        context, Routes.navBarView);
                                }
                              },
                            ),
                          ),
                          // LOOP WIDGET here
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
                      Container(
                        width: double.infinity,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            SizedBox(
                              height: 10,
                            ),
                            if (widget.loop != null &&
                                widget.loop.atTimeEnding != null &&
                                kloopComplete(widget.loop.type) == false)
                              Padding(
                                padding: const EdgeInsets.only(bottom: 10),
                                child: LoopTimer(
                                    color: Colors.white,
                                    atTimeEnding: widget.loop.atTimeEnding),
                              ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(
                                  Icons.people,
                                  color: Colors.blue[300],
                                  size: 25,
                                ),
                                SizedBox(
                                  width: 5,
                                ),
                                Text(
                                  widget.loop.numberOfMembers.toString(),
                                  style: kTextFormFieldStyle.copyWith(
                                      fontSize: 15, color: Colors.white),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(
                                  CupertinoIcons.loop_thick,
                                  color: Colors.blue[300],
                                  size: 25,
                                ),
                                SizedBox(
                                  width: 5,
                                ),
                                AutoSizeText(
                                  widget.loop.name,
                                  style: kTextFormFieldStyle,
                                  textAlign: TextAlign.left,
                                  maxFontSize: 20,
                                  minFontSize: 16,
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      kloopComplete(widget.loop.type)
                          ? UserDetailsInLoopDetailsView(
                              loop: widget.loop,
                            )
                          : Container(),
                    ],
                  )),
              if (!details)
                Container(
                    margin: EdgeInsets.only(
                        top: MediaQuery.of(context).size.width / 5),
                    child: widget.chatWidget)
            ]),
          ),
        ));
  }
}
