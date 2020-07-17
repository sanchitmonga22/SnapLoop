import 'package:SnapLoop/Model/loop.dart';
import 'package:SnapLoop/Provider/LoopsProvider.dart';
import 'package:SnapLoop/Provider/UserDataProvider.dart';
import 'package:SnapLoop/constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';
import 'package:provider/provider.dart';

import 'LoopWidget/loopWidget.dart';

/// author: @sanchitmonga22
class HomeScreen extends StatefulWidget {
  static const routeName = '/homeScreen';
  final bool completedLoopsScreen;

  const HomeScreen({Key key, this.completedLoopsScreen = false})
      : super(key: key);
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>
    with TickerProviderStateMixin, AutomaticKeepAliveClientMixin<HomeScreen> {
  @override
  bool get wantKeepAlive => true;
  List<Loop> loops = [];

  List<double> radiiLoop(double maxRadius, List<Loop> loopsies) {
    List<double> loopRadii = [];
    loopsies.forEach((loop) {
      loopRadii.add(kradiusCalculator(loop.numberOfMembers, maxRadius));
    });
    return loopRadii;
  }

  List<Loop> getLoopsType(LoopType type) {
    List<Loop> loopsWithType = [];
    loops.forEach((loop) {
      if (loop.type == type) {
        loopsWithType.add(loop);
      }
    });
    return loopsWithType;
  }

  List<Widget> loopBuilderHelper(
      List<Loop> loopTypes, double maxRadius, List<double> radiis) {
    List<Loop> deleted = [...loopTypes];
    double deviceWidth = maxRadius * 4;
    List<Widget> widgetsInEachRow = [];
    double currentWidth = 0;
    List<Widget> rows = [];
    while (radiis.isNotEmpty) {
      for (int i = 0; i < radiis.length; i++) {
        if (currentWidth + ((radiis[i] + kAllLoopsPadding) * 2) < deviceWidth) {
          widgetsInEachRow.add(LoopWidget(
            radius: radiis[i],
            loop: deleted[i],
            isTappable: true,
            flipOnTouch: true,
          ));
          currentWidth += (radiis[i] + kAllLoopsPadding) * 2;
          deleted.removeAt(i);
          radiis.removeAt(i);
          if (radiis.isNotEmpty) {
            i = i - 1;
          }
        }
      }
      rows.add(Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [...widgetsInEachRow],
      ));
      currentWidth = 0;
      widgetsInEachRow = [];
    }
    return rows;
  }

  // width is 4*maxRadius of the device
  List<Widget> loopBuilder(double maxRadius) {
    final loopsWithNewNotifications = getLoopsType(LoopType.NEW_NOTIFICATION);
    final existingLoops = getLoopsType(LoopType.EXISTING_LOOP);
    final newLoops = getLoopsType(LoopType.NEW_LOOP);
    final loopsWithNewNotificationsRadii =
        radiiLoop(maxRadius, loopsWithNewNotifications);
    final newLoopsRadii = radiiLoop(maxRadius, newLoops);
    final existingLoopsRadii = radiiLoop(maxRadius, existingLoops);

    List<Widget> rows = [];
    rows.addAll(loopBuilderHelper(newLoops, maxRadius, newLoopsRadii));
    rows.addAll(loopBuilderHelper(
        loopsWithNewNotifications, maxRadius, loopsWithNewNotificationsRadii));
    rows.addAll(
        loopBuilderHelper(existingLoops, maxRadius, existingLoopsRadii));
    return rows;
  }

  List<Widget> completedLoopBuilder(double maxRadius) {
    final inactiveLoopsSuccessful =
        getLoopsType(LoopType.INACTIVE_LOOP_SUCCESSFUL);
    final inactiveLoopsFailed = getLoopsType(LoopType.INACTIVE_LOOP_FAILED);
    final inactiveLoopsSuccessfulRadii =
        radiiLoop(maxRadius, inactiveLoopsSuccessful);
    final inactiveLoopsFailedRadii = radiiLoop(maxRadius, inactiveLoopsFailed);

    List<Widget> rows = [];
    rows.addAll(loopBuilderHelper(
        inactiveLoopsSuccessful, maxRadius, inactiveLoopsSuccessfulRadii));
    rows.addAll(loopBuilderHelper(
        inactiveLoopsFailed, maxRadius, inactiveLoopsFailedRadii));
    return rows;
  }

  @override
  Widget build(BuildContext context) {
    Provider.of<LoopsProvider>(context, listen: false)
        .initializeLoopsFromUserData();
    super.build(context);
    MediaQueryData size = MediaQuery.of(context);
    // getting the loops from the provider
    loops = Provider.of<LoopsProvider>(context).loops;

    final List<Widget> loopWidgets = widget.completedLoopsScreen
        ? completedLoopBuilder((size.size.width) * 0.25)
        : loopBuilder((size.size.width) * 0.25);

    return Container(
        decoration: kHomeScreenBoxDecoration,
        child: Stack(children: [
          loopWidgets == null || loopWidgets.length == 0
              ? Center(
                  child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Text(
                      widget.completedLoopsScreen
                          ? "There are no inactive loops available yet, \n once you are part of a successfully completed loop it will show up here!"
                          : "There are currently no active loops, Please start new loops to show up here!",
                      style: kTextStyleHomeScreen.copyWith(color: Colors.black),
                    ),
                  ),
                )
              : ListView.builder(
                  itemBuilder: (_, index) {
                    return loopWidgets[index];
                  },
                  itemCount: loopWidgets.length)
        ]));
  }
}
