import 'package:SnapLoop/Helper/loops.dart' as loopsies;
import 'package:SnapLoop/Model/chat.dart';
import 'package:SnapLoop/Model/loop.dart';
import 'package:SnapLoop/Screens/Home/loopWidget.dart';
import 'package:flutter/widgets.dart';

///author: @sanchitmonga22
class LoopsProvider with ChangeNotifier {
  List<Loop> _loops = loopsies.loops;

  List<Loop> get loops {
    return [..._loops];
  }

  int get loopCount {
    return _loops.length;
  }

// This will create the loop and send the first message to the friend
  void createLoop(String name, String friendID, Object content) {
    Loop loop = new Loop(
        id: null,
        chatID: null,
        creatorId: null,
        name: name,
        numberOfMembers: null,
        type: null,
        userIDs: null);
  }

  Loop findByName(String name) {
    return _loops.firstWhere((loop) => loop.name == name);
  }

  List<double> radiiLoop(double maxRadius, List<Loop> loopsies) {
    List<double> loopRadii = [];
    loopsies.forEach((loop) {
      loopRadii.add(radiusCalculator(loop.numberOfMembers, maxRadius));
    });
    return loopRadii;
  }

  double radiusCalculator(int numberOfMember, double maxRadius) {
    // KEY: Number of Members, and Value Factor by which the maxRadius has to be reduced
    const fixedRadiusFactor = {2: 0.34, 3: 0.37, 4: 0.43, 5: 0.46};

    // NOTE: DO NOT CHANGE THIS!!
    if (numberOfMember <= 5) {
      return maxRadius * fixedRadiusFactor[numberOfMember];
    }
    return maxRadius * 0.74;
  }

  List<Loop> getLoopsType(LoopType type) {
    List<Loop> loopsWithType = [];
    _loops.forEach((loop) {
      if (loop.type == type) {
        loopsWithType.add(loop);
      }
    });
    return loopsWithType;
  }

  List<Widget> loopBuilderHelper(
      List<Loop> loopTypes, double maxRadius, List<double> radiis) {
    List<Loop> deleted = [...loopTypes];
    double deviceWidth = maxRadius * 4 - maxRadius * 0.25;
    List<Widget> widgetsInEachRow = [];
    double currentWidth = 0;
    List<Widget> rows = [];
    while (radiis.isNotEmpty) {
      for (int i = 0; i < radiis.length; i++) {
        if (currentWidth + (radiis[i] * 2) < deviceWidth) {
          widgetsInEachRow.add(LoopWidget(
            radius: radiis[i],
            numberOfMembers: deleted[i].numberOfMembers,
            text: deleted[i].name,
            type: deleted[i].type,
          ));
          // TODO add the paddig information if possible
          currentWidth += radiis[i] * 2;
          deleted.removeAt(i);
          radiis.removeAt(i);
          if (radiis.isNotEmpty) {
            i = i - 1;
          }
        }
      }
      rows.add(Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [...widgetsInEachRow],
      ));
      currentWidth = 0;
      widgetsInEachRow = [];
    }
    return rows;
  }

  // if there is already a loop with the same name in the database
  bool loopExistsWithName(String name) {
    bool exists = false;
    loops.forEach((loop) {
      if (loop.name.toLowerCase() == name.trim().toLowerCase()) {
        exists = true;
      }
    });
    return exists;
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
}
