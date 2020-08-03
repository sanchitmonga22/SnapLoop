import 'dart:ui';

import 'package:SnapLoop/app/constants.dart';
import 'package:flutter/material.dart';

class CreateADialogWidgetView extends StatelessWidget {
  final Widget child;
  const CreateADialogWidgetView({Key key, this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BackdropFilter(
        filter: ImageFilter.blur(sigmaX: ksigmaX, sigmaY: ksigmaY),
        child: AlertDialog(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20.0)),
            backgroundColor: Colors.white.withOpacity(0.1),
            content: Container(
                decoration: BoxDecoration(
                    border: Border.all(
                        color: Colors.white,
                        style: BorderStyle.solid,
                        width: 2)),
                child: child)));
  }
}
