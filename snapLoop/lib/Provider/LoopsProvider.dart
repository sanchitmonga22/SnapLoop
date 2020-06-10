import 'package:SnapLoop/Helper/loops.dart' as loopsies;
import 'package:SnapLoop/Model/loop.dart';
import 'package:SnapLoop/Screens/Home/loopWidget.dart';
import 'package:flutter/widgets.dart';

class LoopsProvider with ChangeNotifier {
  List<Loop> _loops = loopsies.loops;

  List<Loop> get loops {
    return [..._loops];
  }

  int get loopCount {
    return _loops.length;
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
    double radii = 0.0;
    double minRadius = maxRadius / 2;
    if (numberOfMember > 3) {
      // factor by which the loop will increase by the addition of a new member in the loop
      double factor = (numberOfMember - 3) * 3.0;
      radii = minRadius + factor;
    } else {
      radii = minRadius;
    }
//  if(radii > maxRadius){
//    radii=maxRadius;
//  }
//  if(radii <minRadius) {
//    radii = minRadius / 2;
//  }
    return radii;
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
    print(maxRadius);
    List<Widget> widgetsInEachRow = [];
    double currentWidth = 0;
    List<Widget> rows = [];
    while (radiis.isNotEmpty) {
      for (int i = 0; i <= radiis.length; i++) {
        if (currentWidth + (radiis[i] * 2) < deviceWidth) {
          widgetsInEachRow.add(LoopWidget(
            radius: radiis[i],
            numberOfMembers: deleted[i].numberOfMembers,
            text: deleted[i].name,
            type: deleted[i].type,
          ));
          print(deleted[i].name);
          print(deleted[i].type);
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
        children: [...widgetsInEachRow],
      ));
      currentWidth = 0;
      widgetsInEachRow = [];
      print(rows);
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
}