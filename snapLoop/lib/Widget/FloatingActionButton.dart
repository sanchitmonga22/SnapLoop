import 'package:SnapLoop/Provider/UserDataProvider.dart';
import 'package:SnapLoop/Widget/ErrorDialog.dart';
import 'package:SnapLoop/Widget/createLoopDialog.dart';
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
    int numberOfloops =
        Provider.of<UserDataProvider>(context).userData.numberOfLoopsRemaining;

    final changes = Provider.of<FloatingActionButtonDataChanges>(context);
    return FloatingActionBubble(
        circleAvatar: {
          0: CircleAvatar(
            backgroundColor: kSystemPrimaryColor,
            child: Text(
              numberOfloops.toString(),
              style:
                  kTextFormFieldStyle.copyWith(fontWeight: FontWeight.normal),
            ),
            radius: 15,
          ),
        },
        backGroundColor: Colors.black,
        items: <Bubble>[
          Bubble(
              title: "+",
              iconColor: Colors.white,
              bubbleColor: Colors.black,
              icon: CupertinoIcons.loop_thick,
              titleStyle: kTextStyleHomeScreen.copyWith(
                  fontSize: 20, fontWeight: FontWeight.w900),
              onPress: () {
                changes.toggleIsTapped();
                widget._animationController.reverse();
                showDialog(
                  context: context,
                  barrierDismissible: false,
                  useSafeArea: true,
                  builder: (context) {
                    if (numberOfloops > 0) {
                      return CreateALoopDialog();
                    } else {
                      return ErrorDialog(
                          message:
                              "You have used the maximum number of loops available for the day. It resets after every ");
                    }
                  },
                );
              }),
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
        onPress: () async {
          // Avoiding the double tap, when the user double taps this, the blur screen will still be updated!
          // FIXME: There still exists an issue if you tap is 4 times very fast, then it breaks!!!
          if (widget._animationController.isCompleted) {
            try {
              changes.toggleIsTapped();
              await widget._animationController.reverse().orCancel;
            } on TickerCanceled {
              changes.toggleIsTapped();
            }
          } else {
            try {
              changes.toggleIsTapped();
              await widget._animationController.forward().orCancel;
            } on TickerCanceled {
              changes.toggleIsTapped();
            }
          }
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

// IMPORTANT: Following is the changed version of the floating Action bubble which is a 3rd party package used in this app
// but modified according to our needs!
// import 'package:flutter/material.dart';

// class Bubble {
//   const Bubble(
//       {@required this.title,
//       @required this.titleStyle,
//       @required this.iconColor,
//       @required this.bubbleColor,
//       @required this.icon,
//       @required this.onPress});

//   final IconData icon;
//   final Color iconColor;
//   final Color bubbleColor;
//   final Function onPress;
//   final String title;
//   final TextStyle titleStyle;
// }

// class BubbleMenu extends StatelessWidget {
//   const BubbleMenu(this.item, {Key key}) : super(key: key);

//   final Bubble item;

//   @override
//   Widget build(BuildContext context) {
//     return MaterialButton(
//       shape: StadiumBorder(),
//       padding: EdgeInsets.only(top: 11, bottom: 13, left: 32, right: 32),
//       color: item.bubbleColor,
//       splashColor: Colors.grey.withOpacity(0.1),
//       highlightColor: Colors.grey.withOpacity(0.1),
//       elevation: 2,
//       highlightElevation: 2,
//       disabledColor: item.bubbleColor,
//       onPressed: item.onPress,
//       child: Row(
//         mainAxisSize: MainAxisSize.min,
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: <Widget>[
//           Icon(
//             item.icon,
//             size: 35,
//             color: item.iconColor,
//           ),
//           Text(
//             item.title,
//             style: item.titleStyle,
//           ),
//         ],
//       ),
//     );
//   }
// }

// class _DefaultHeroTag {
//   const _DefaultHeroTag();
//   @override
//   String toString() => '<default FloatingActionBubble tag>';
// }

// class FloatingActionBubble extends AnimatedWidget {
//   const FloatingActionBubble({
//     @required this.items,
//     @required this.onPress,
//     @required this.iconColor,
//     @required this.backGroundColor,
//     @required Animation animation,
//     this.herotag,
//     this.circleAvatar,
//     this.iconData,
//     this.animatedIconData,
//   })  : assert((iconData == null && animatedIconData != null) ||
//             (iconData != null && animatedIconData == null)),
//         super(listenable: animation);

//   final List<Bubble> items;
//   final Function onPress;
//   final AnimatedIconData animatedIconData;
//   final Object herotag;
//   final IconData iconData;
//   final Color iconColor;
//   final Color backGroundColor;
//   final Map<int, Widget> circleAvatar;

//   get _animation => listenable;

//   Widget buildItem(BuildContext context, int index) {
//     final screenWidth = MediaQuery.of(context).size.width;

//     final transform = Matrix4.translationValues(
//       -(screenWidth - _animation.value * screenWidth) *
//           ((items.length - index) / 4),
//       0.0,
//       0.0,
//     );

//     return Align(
//       alignment: Alignment.centerRight,
//       child: Transform(
//         transform: transform,
//         child: Opacity(
//             opacity: _animation.value,
//             child: Stack(children: [
//               Align(
//                 child: BubbleMenu(items[index]),
//                 alignment: Alignment.bottomRight,
//               ),
//               Align(
//                 child: circleAvatar[index] ?? Container(),
//                 alignment: Alignment.topRight,
//               )
//             ])),
//       ),
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       mainAxisSize: MainAxisSize.min,
//       crossAxisAlignment: CrossAxisAlignment.end,
//       children: [
//         IgnorePointer(
//             ignoring: _animation.value == 0,
//             child: ListView.separated(
//               shrinkWrap: true,
//               physics: NeverScrollableScrollPhysics(),
//               separatorBuilder: (_, __) => SizedBox(
//                 height: 10,
//               ),
//               padding: EdgeInsets.symmetric(vertical: 12),
//               itemCount: items.length,
//               itemBuilder: buildItem,
//             )),
//         FloatingActionButton(
//           heroTag: herotag == null ? const _DefaultHeroTag() : herotag,
//           backgroundColor: backGroundColor,
//           // iconData is mutually exclusive with animatedIconData
//           // only 1 can be null at the time
//           child: iconData == null
//               ? AnimatedIcon(
//                   icon: animatedIconData,
//                   progress: _animation,
//                 )
//               : Icon(
//                   iconData,
//                   color: iconColor,
//                 ),
//           onPressed: onPress,
//         ),
//       ],
//     );
//   }
// }
