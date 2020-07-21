import 'package:SnapLoop/Model/loop.dart';
import 'package:SnapLoop/Provider/LoopsProvider.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';
import 'package:stacked/stacked.dart';

import '../../../constants.dart';

class HomeViewModel extends BaseViewModel {
  List<Loop> _loops = [];
  List<Loop> get loops => _loops;

  void setLoops(BuildContext context) {
    _loops = Provider.of<LoopsProvider>(context).loops;
  }

  List<double> radiiLoop(double maxRadius, List<Loop> loopsies) {
    List<double> loopRadii = [];
    loopsies.forEach((loop) {
      loopRadii.add(kradiusCalculator(loop.numberOfMembers, maxRadius));
    });
    return loopRadii;
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
}
