import 'package:SnapLoop/Screens/Home/createLoopDialog.dart';
import 'package:floating_action_bubble/floating_action_bubble.dart';
import 'package:flutter/material.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';

import '../constants.dart';

class FloatingActionButtonData extends StatelessWidget {
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
  Widget build(BuildContext context) {
    return FloatingActionBubble(
        backGroundColor: Colors.black,
        items: <Bubble>[
          Bubble(
            title: "+",
            iconColor: Colors.white,
            bubbleColor: Colors.black,
            icon: CupertinoIcons.loop,
            titleStyle: kTextStyleHomeScreen,
            onPress: () {
              _animationController.reverse();
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
            icon: CupertinoIcons.person_add,
            titleStyle: kTextStyleHomeScreen,
            onPress: () {
              _animationController.reverse();
              //TODO: To add a new friend
            },
          ),
        ],
        animation: _animation,
        onPress: () {
          _animationController.isCompleted
              ? _animationController.reverse()
              : _animationController.forward();
        },
        iconColor: Colors.white,
        animatedIconData: AnimatedIcons.menu_home);
  }
}
