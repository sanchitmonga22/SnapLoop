import 'package:SnapLoop/Screens/Home/createLoopDialog.dart';
import 'package:floating_action_bubble/floating_action_bubble.dart';
import 'package:flutter/material.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';
import 'package:provider/provider.dart';

import '../constants.dart';

class FloatingActionButtonData extends StatefulWidget {
  const FloatingActionButtonData({
    Key key,
    @required AnimationController animationController,
    @required Animation<double> animation,
  })  : _animationController = animationController,
        _animation = animation,
        super(key: key);

  final AnimationController _animationController;
  final Animation<double> _animation;

  @override
  _FloatingActionButtonDataState createState() =>
      _FloatingActionButtonDataState();
}

class _FloatingActionButtonDataState extends State<FloatingActionButtonData> {
  @override
  Widget build(BuildContext context) {
    final changes = Provider.of<FloatingActionButtonDataChanges>(context);
    return FloatingActionBubble(
        backGroundColor: Colors.black,
        items: <Bubble>[
          Bubble(
            title: "+",
            iconColor: Colors.white,
            bubbleColor: Colors.black,
            icon: CupertinoIcons.loop,
            titleStyle: kTextStyleHomeScreen.copyWith(
                fontSize: 20, fontWeight: FontWeight.w900),
            onPress: () {
              changes.toggleIsTapped();
              widget._animationController.reverse();
              showDialog(
                context: context,
                builder: (context) {
                  return CreateALoopDialog();
                },
              );
            },
          ),
          Bubble(
            title: "+",
            iconColor: Colors.white,
            bubbleColor: Colors.black,
            icon: CupertinoIcons.person_solid,
            titleStyle: kTextStyleHomeScreen.copyWith(
                fontSize: 20, fontWeight: FontWeight.w900),
            onPress: () {
              changes.toggleIsTapped();
              widget._animationController.reverse();
              //TODO: To add a new friend
            },
          ),
        ],
        animation: widget._animation,
        onPress: () {
          changes.toggleIsTapped();
          widget._animationController.isCompleted
              ? widget._animationController.reverse()
              : widget._animationController.forward();
        },
        iconColor: Colors.white,
        animatedIconData: AnimatedIcons.menu_home);
  }
}

class FloatingActionButtonDataChanges with ChangeNotifier {
  bool isTapped = false;

  void toggleIsTapped() {
    isTapped = !isTapped;

    notifyListeners();
  }
}
