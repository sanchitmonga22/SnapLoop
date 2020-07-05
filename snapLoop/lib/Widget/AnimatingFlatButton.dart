import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../constants.dart';

class AnimatingFlatButton extends StatefulWidget {
  AnimatingFlatButton(
      {Key key,
      this.labelText = "",
      this.onClicked,
      @required this.isAnimating,
      this.innerWidget})
      : super(key: key);
  final String labelText;
  final Function onClicked;
  final bool isAnimating;
  final Widget innerWidget;

  @override
  _AnimatingFlatButtonState createState() => _AnimatingFlatButtonState();
}

class _AnimatingFlatButtonState extends State<AnimatingFlatButton>
    with SingleTickerProviderStateMixin {
  AnimationController _resizableController;
  // static Color colorVariation(int note) {
  //   if (note <= 1) {
  //     // return Colors.greenAccent[50];
  //     return Colors.greenAccent[100];
  //   } else if (note > 1 && note <= 2) {
  //     // return Colors.greenAccent[100];
  //     return Colors.greenAccent;
  //   } else if (note > 2 && note <= 3) {
  //     // return Colors.greenAccent[200];
  //     return Colors.greenAccent;
  //   } else if (note > 3 && note <= 4) {
  //     return Colors.greenAccent[400];
  //   } else if (note > 4 && note <= 5) {
  //     return Colors.greenAccent[700];
  //   }
  //   // else if (note > 5 && note <= 6) {
  //   //   return Colors.greenAccent[400];
  //   // } else if (note > 6 && note <= 7) {
  //   //   return Colors.greenAccent[400];
  //   // } else if (note > 7 && note <= 8) {
  //   //   return Colors.greenAccent[700];
  //   // } else if (note > 8 && note <= 9) {
  //   //   return Colors.greenAccent[700];
  //   // } else if (note > 9 && note <= 10) {
  //   //   return Colors.greenAccent[700];
  //   // }
  //   return null;
  // }

  static Color colorVariation(int note) {
    if (note <= 1) {
      // return Colors.greenAccent[50];
      return Colors.greenAccent[100];
    } else if (note > 1 && note <= 2) {
      // return Colors.greenAccent[100];
      return Colors.greenAccent;
    } else if (note > 2 && note <= 3) {
      // return Colors.greenAccent[200];
      return Colors.greenAccent[400];
    } else if (note > 3 && note <= 4) {
      return Colors.greenAccent[700];
    } else if (note > 4 && note <= 5) {
      return Colors.greenAccent[700];
    }
    // else if (note > 5 && note <= 6) {
    //   return Colors.greenAccent[400];
    // } else if (note > 6 && note <= 7) {
    //   return Colors.greenAccent[400];
    // } else if (note > 7 && note <= 8) {
    //   return Colors.greenAccent[700];
    // } else if (note > 8 && note <= 9) {
    //   return Colors.greenAccent[700];
    // } else if (note > 9 && note <= 10) {
    //   return Colors.greenAccent[700];
    // }
    return null;
  }

  @override
  void initState() {
    _resizableController = new AnimationController(
      vsync: this,
      duration: new Duration(
        seconds: 2,
      ),
    );
    _resizableController.addStatusListener((animationStatus) {
      switch (animationStatus) {
        case AnimationStatus.completed:
          _resizableController.reverse();
          break;
        case AnimationStatus.dismissed:
          _resizableController.forward();
          break;
        case AnimationStatus.forward:
          break;
        case AnimationStatus.reverse:
          break;
      }
    });
    _resizableController.forward();
    super.initState();
  }

  Widget getInnerWidget({GlobalKey<FormState> formkey}) {
    return OutlineButton(
      padding: EdgeInsets.symmetric(vertical: 15),
      focusColor: CupertinoColors.activeOrange,
      textTheme: ButtonTextTheme.primary,
      onPressed: widget.onClicked,
      child: Text(
        widget.labelText,
        style: kTextFormFieldStyle,
      ),
    );
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _resizableController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Widget innerWidget = widget.innerWidget;
    if (widget.innerWidget == null) {
      innerWidget = getInnerWidget();
    }
    return widget.isAnimating
        ? AnimatedBuilder(
            animation: _resizableController,
            builder: (context, child) {
              return Container(
                padding: EdgeInsets.zero,
                child: innerWidget,
                decoration: BoxDecoration(
                  shape: BoxShape.rectangle,
                  borderRadius: BorderRadius.all(Radius.circular(12)),
                  border: Border.all(
                      color: colorVariation(
                          (_resizableController.value * 5).round()),
                      width: 5),
                ),
              );
            })
        : innerWidget;
  }
}
