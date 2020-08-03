import 'dart:ui';
import 'package:SnapLoop/app/constants.dart';
import 'package:SnapLoop/ui/Widget/ChangeUsernameDialog.dart';
import 'package:SnapLoop/ui/Widget/ImagePickerDialog/ImagePickerDialog.dart';
import 'package:SnapLoop/ui/views/Contacts/Friends/FriendsView.dart';
import 'package:SnapLoop/ui/views/Home/homeView.dart';
import 'package:SnapLoop/ui/views/NavBar/NavBarViewModel.dart';
import 'package:SnapLoop/ui/views/Profile/UserProfileView.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';
import 'package:stacked/stacked.dart';
import '../../Widget/FloatingActionButton/FloatingActionButton.dart';

/// author:@sanchitmonga22
class NavBarView extends StatefulWidget {
  NavBarView({Key key}) : super(key: key);

  @override
  _NavBarViewState createState() => _NavBarViewState();
}

class _NavBarViewState extends State<NavBarView>
    with TickerProviderStateMixin, AutomaticKeepAliveClientMixin<NavBarView> {
  TabController _tabController;
  Animation<double> _floatingBubbleAnimation;
  AnimationController _floatingBubbleAnimationController;

  @override
  void initState() {
    super.initState();
    _floatingBubbleAnimationController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 260),
    );
    final curvedAnimation = CurvedAnimation(
        curve: Curves.easeInOut, parent: _floatingBubbleAnimationController);
    _floatingBubbleAnimation =
        Tween<double>(begin: 0, end: 1).animate(curvedAnimation);
    _tabController = TabController(
      vsync: this,
      length: 4,
      initialIndex: 0,
    );
  }

  List<Widget> getChildren() {
    return [
      HomeView(),
      HomeView(
        completedLoopsScreen: true,
      ),
      FriendsView(
        loopForwarding: false,
        loopName: "",
      ),
      UserProfileView()
    ];
  }

  List<PersistentBottomNavBarItem> _navBarsItems(NavBarViewModel model) {
    return [
      PersistentBottomNavBarItem(
        icon: Icon(CupertinoIcons.loop_thick),
        title: ("Home"),
        activeColor: kActiveNavBarIconColor,
        inactiveColor: kInactiveNavBarIconColor,
      ),
      PersistentBottomNavBarItem(
        icon: Icon(Icons.people),
        title: ("People"),
        activeColor: kActiveNavBarIconColor,
        inactiveColor: kInactiveNavBarIconColor,
      ),
      PersistentBottomNavBarItem(
        icon: model.myImage != null
            ? GestureDetector(
                onLongPress: () {
                  showDialog(
                    context: context,
                    builder: (context) => ImagePicketDialog(
                      remove: true,
                    ),
                  );
                },
                child: Container(
                  decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(color: kSystemPrimaryColor, width: 2)),
                  child: CircleAvatar(
                      radius: 20, backgroundImage: MemoryImage(model.myImage)),
                ),
              )
            : Icon(Icons.account_circle),
        title: model.myImage != null ? null : "Profile",
        activeColor: kActiveNavBarIconColor,
        inactiveColor: kInactiveNavBarIconColor,
      ),
    ];
  }

  @override
  void dispose() {
    super.dispose();
    _tabController.dispose();
    _floatingBubbleAnimationController.dispose();
  }

  void _toggleTab(int index) {
    _tabController.animateTo(index, curve: Curves.easeIn);
  }

  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return ViewModelBuilder.reactive(
        fireOnModelReadyOnce: true,
        viewModelBuilder: () => NavBarViewModel(),
        builder: (context, model, child) {
          return SafeArea(
              child: Scaffold(
                  backgroundColor: Colors.black,
                  resizeToAvoidBottomPadding:
                      false, // IMPORTANT: to avoid bottom overflow for the create a loop dialog
                  appBar: AppBar(
                    title: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        AutoSizeText(
                          "Score: ${model.userScore.toString()}",
                          textAlign: TextAlign.left,
                          style: kTextStyleHomeScreen,
                        ),
                        SizedBox(
                          child: ColorizeAnimatedTextKit(
                            speed: Duration(seconds: 1),
                            isRepeatingAnimation: false,
                            text: ["Snap∞Loop"],
                            textStyle: TextStyle(
                                fontSize: 25.0,
                                fontFamily: "Open Sans",
                                fontWeight: FontWeight.w900),
                            colors: [
                              // Colors.purple,
                              Colors.white70,
                              Colors.yellow,
                              Colors.blueGrey,
                            ],
                            textAlign: TextAlign.center,
                            repeatForever: false,
                          ),
                        ),
                        GestureDetector(
                          onLongPress: () {
                            showDialog(
                              context: context,
                              builder: (context) {
                                return ChangeItemValueDialog(
                                  initialText: model.displayName,
                                  itemName: "displayName",
                                );
                              },
                            );
                          },
                          child: ConstrainedBox(
                            constraints: BoxConstraints(maxWidth: 70),
                            child: AutoSizeText(
                              model.displayName,
                              style: kTextStyleHomeScreen,
                              maxFontSize: 15,
                            ),
                          ),
                        ),
                      ],
                    ),
                    centerTitle: true,
                    backgroundColor: kAppBarBackgroundColor,
                  ),
                  floatingActionButtonLocation:
                      FloatingActionButtonLocation.endFloat,
                  //NOTE FloatingActionBubble modified:
                  //Line 39 crossAxisAlignment: CrossAxisAlignment.start,
                  //Line 43 Size:35
                  floatingActionButton: FloatingActionButtonView(
                    animationController: _floatingBubbleAnimationController,
                    animation: _floatingBubbleAnimation,
                  ),
                  body: GestureDetector(
                      onHorizontalDragUpdate: (details) {
                        // swiping right
                        if (details.delta.dx < -kSwipeConstant &&
                            _tabController.index == 0) {
                          _toggleTab(1);
                        }
                        if (details.delta.dx > kSwipeConstant &&
                            _tabController.index == 1) {
                          _toggleTab(0);
                        }
                      },
                      onTap: () {
                        if (_floatingBubbleAnimationController.isCompleted) {
                          model.toggleIsTapped();
                          _floatingBubbleAnimationController.reverse();
                        }
                      },
                      child: Stack(
                        children: [
                          TabBarView(
                            physics: NeverScrollableScrollPhysics(),
                            children: getChildren(),
                            controller: _tabController,
                          ),
                          model.isTapped &&
                                  !_floatingBubbleAnimationController
                                      .isCompleted
                              ? Container(
                                  width: double.infinity,
                                  child: BackdropFilter(
                                    filter: ImageFilter.blur(
                                        sigmaX: ksigmaX, sigmaY: ksigmaY),
                                    child: Container(
                                      color: Colors.black.withOpacity(kopacity),
                                    ),
                                  ),
                                )
                              : Container(
                                  padding: EdgeInsets.zero,
                                  height: 0,
                                  width: 0,
                                )
                        ],
                      )),
                  bottomNavigationBar: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 5),
                    child: PersistentBottomNavBar(
                      confineToSafeArea: true,
                      itemAnimationProperties:
                          ItemAnimationProperties(curve: Curves.bounceIn),
                      decoration: NavBarDecoration(
                        adjustScreenBottomPaddingOnCurve: true,
                        border: Border.fromBorderSide(BorderSide(
                            style: BorderStyle.solid,
                            color: Colors.black,
                            width: 2)),
                        borderRadius: BorderRadius.only(
                            topRight: Radius.circular(20),
                            topLeft: Radius.circular(20)),
                      ),
                      items: _navBarsItems(model),
                      onItemSelected: (value) {
                        if (value > 0) {
                          value++;
                        }
                        setState(() {
                          if (_floatingBubbleAnimationController.isCompleted) {
                            model.toggleIsTapped();
                            _floatingBubbleAnimationController.reverse();
                          }
                          _toggleTab(value);
                        });
                      },
                      navBarHeight: 60,
                      navBarStyle: NavBarStyle.style2,
                      iconSize: 25,
                      selectedIndex: _tabController.index > 0
                          ? _tabController.index - 1
                          : 0,
                      backgroundColor: Colors.white.withOpacity(0.07),
                      popScreensOnTapOfSelectedTab: false,
                    ),
                  )));
        });
  }
}
