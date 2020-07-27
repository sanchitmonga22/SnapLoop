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

  List<Widget> loopBuilderHelper(
      List<Loop> loops, double maxRadius, List<double> radiis) {
    double deviceWidth = maxRadius * 4;
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
  List<Widget> loopBuilder(double maxRadius, HomeViewModel model) {
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
    radiies.addAll(model.radiiLoop(maxRadius, loopsWithNewNotifications));
    radiies.addAll(model.radiiLoop(maxRadius, newLoops));
    radiies.addAll(model.radiiLoop(maxRadius, existingLoops));

    // returning the final widgets
    return loopBuilderHelper(loopsies, maxRadius, radiies);
  }

  List<Widget> completedLoopBuilder(double maxRadius, HomeViewModel model) {
    // getting loops of different types
    final inactiveLoopsSuccessful =
        model.getLoopsType(LoopType.INACTIVE_LOOP_SUCCESSFUL);
    final inactiveLoopsFailed =
        model.getLoopsType(LoopType.INACTIVE_LOOP_FAILED);

    // adding all the loops into the list
    final loopsies = List<Loop>();
    loopsies.addAll(inactiveLoopsFailed);
    loopsies.addAll(inactiveLoopsSuccessful);
    // getting the radiis for all the different types of loops
    final radiies = List<double>();
    radiies.addAll(model.radiiLoop(maxRadius, inactiveLoopsSuccessful));
    radiies.addAll(model.radiiLoop(maxRadius, inactiveLoopsFailed));

    // returning all the rows returned
    return loopBuilderHelper(loopsies, maxRadius, radiies);
  }

  @override
  Widget build(BuildContext context) {
    double maxR = MediaQuery.of(context).size.width * 0.25;
    super.build(context);

    return ViewModelBuilder.reactive(
      viewModelBuilder: () => HomeViewModel(),
      onModelReady: (model) => model.initializeLoops(),
      builder: (context, model, child) {
        return Container(
            decoration: kHomeScreenBoxDecoration,
            child: model.loops == null || model.loops.length == 0
                ? Center(
                    child: Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Text(
                        widget.completedLoopsScreen
                            ? "There are no inactive loops available yet, \n once you are part of a successfully completed loop it will show up here!"
                            : "There are currently no active loops, Please start new loops to show up here!",
                        style:
                            kTextStyleHomeScreen.copyWith(color: Colors.black),
                      ),
                    ),
                  )
                : ListView(children: [
                    ...widget.completedLoopsScreen
                        ? completedLoopBuilder(maxR, model)
                        : loopBuilder(maxR, model)
                  ]));
      },
    );
  }
}
