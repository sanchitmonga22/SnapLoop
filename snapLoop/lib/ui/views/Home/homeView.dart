import 'package:SnapLoop/Model/loop.dart';
import 'package:SnapLoop/constants.dart';
import 'package:SnapLoop/ui/views/Home/homeViewModel.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

import 'LoopWidget/loopWidgetView.dart';

/// author: @sanchitmonga22
class HomeView extends StatefulWidget {
  final bool completedLoopsScreen;

  const HomeView({Key key, this.completedLoopsScreen = false})
      : super(key: key);
  @override
  _HomeViewState createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView>
    with TickerProviderStateMixin, AutomaticKeepAliveClientMixin<HomeView> {
  @override
  bool get wantKeepAlive => true;

  List<Widget> loopBuilderHelper(List<Loop> loops, List<double> radiis) {
    double deviceWidth = MediaQuery.of(context).size.width;
    List<Loop> deleted = [...loops];
    List<Widget> widgetsInEachRow = [];
    double currentWidth = 0;
    List<Widget> rows = [];
    while (radiis.isNotEmpty) {
      for (int i = 0; i < radiis.length; i++) {
        if (currentWidth + ((radiis[i] + kAllLoopsPadding) * 2) < deviceWidth) {
          widgetsInEachRow.add(LoopWidgetView(
            key: UniqueKey(),
            radius: radiis[i],
            loop: deleted[i],
            isTappable: true,
            flipOnTouch: true,
          ));
          currentWidth += (radiis[i] + kAllLoopsPadding) * 2;
          radiis.removeAt(i);
          deleted.removeAt(i);
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
  List<Widget> loopBuilder(HomeViewModel model) {
    // getting loops of different types
    final loopsWithNewNotifications =
        model.getLoopsType(LoopType.NEW_NOTIFICATION);
    final existingLoops = model.getLoopsType(LoopType.EXISTING_LOOP);
    final newLoops = model.getLoopsType(LoopType.NEW_LOOP);
    // adding all the loops into the list
    final loopsies = List<Loop>();
    loopsies.addAll(loopsWithNewNotifications);
    loopsies.addAll(existingLoops);
    loopsies.addAll(newLoops);

    // getting the radiis for all the different types of loops
    final radiies = List<double>();
    radiies.addAll(model.radiiLoop(loopsWithNewNotifications));
    radiies.addAll(model.radiiLoop(newLoops));
    radiies.addAll(model.radiiLoop(existingLoops));

    // returning the final widgets
    return loopBuilderHelper(loopsies, radiies);
  }

  List<Widget> completedLoopBuilder(HomeViewModel model) {
    // getting loops of different types
    final inactiveLoopsSuccessful =
        model.getLoopsType(LoopType.INACTIVE_LOOP_SUCCESSFUL);
    final inactiveLoopsFailed =
        model.getLoopsType(LoopType.INACTIVE_LOOP_FAILED);
    final unidentified = model.getLoopsType(LoopType.UNIDENTIFIED);

    // adding all the loops into the list
    final loopsies = List<Loop>();
    loopsies.addAll(inactiveLoopsFailed);
    loopsies.addAll(inactiveLoopsSuccessful);
    loopsies.addAll(unidentified);
    // getting the radiis for all the different types of loops
    final radiies = List<double>();
    radiies.addAll(model.radiiLoop(inactiveLoopsSuccessful));
    radiies.addAll(model.radiiLoop(inactiveLoopsFailed));
    radiies.addAll(model.radiiLoop(unidentified));

    // returning all the rows returned
    return loopBuilderHelper(loopsies, radiies);
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);

    return ViewModelBuilder.reactive(
      viewModelBuilder: () => HomeViewModel(),
      onModelReady: (model) => model.initializeLoops(),
      builder: (context, model, child) {
        return Container(
            decoration: kHomeScreenBoxDecoration,
            child: widget.completedLoopsScreen
                ? model.emptyCompletedLoopsScreen()
                    ? Center(
                        child: Padding(
                          padding: const EdgeInsets.all(20.0),
                          child: Text(
                            "There are no inactive loops available yet, \n once you are part of a successfully completed loop it will show up here!",
                            style: kTextStyleHomeScreen.copyWith(
                                color: Colors.black),
                          ),
                        ),
                      )
                    : ListView(children: [...completedLoopBuilder(model)])
                : model.emptyHomeScreen()
                    ? Center(
                        child: Padding(
                          padding: const EdgeInsets.all(20.0),
                          child: Text(
                            "There are currently no active loops, Please start new loops to show up here!",
                            style: kTextStyleHomeScreen.copyWith(
                                color: Colors.black),
                          ),
                        ),
                      )
                    : ListView(children: [...loopBuilder(model)]));
      },
    );
  }
}
