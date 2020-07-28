import 'package:SnapLoop/Model/loop.dart';
import 'package:SnapLoop/app/locator.dart';
import 'package:SnapLoop/services/LoopsDataService.dart';
import 'package:stacked/stacked.dart';
import '../../../constants.dart';

class HomeViewModel extends ReactiveViewModel {
  final _loopDataService = locator<LoopsDataService>();

  bool emptyHomeScreen() {
    if (loops == null || loops.length == 0) return true;
    return loops
            .where((element) =>
                element.type == LoopType.EXISTING_LOOP ||
                element.type == LoopType.NEW_LOOP ||
                element.type == LoopType.NEW_NOTIFICATION)
            .length ==
        0;
  }

  bool emptyCompletedLoopsScreen() {
    if (loops == null || loops.length == 0) return true;
    return loops
            .where((element) =>
                element.type == LoopType.INACTIVE_LOOP_FAILED ||
                element.type == LoopType.INACTIVE_LOOP_SUCCESSFUL ||
                element.type == LoopType.UNIDENTIFIED)
            .length ==
        0;
  }

  List<Loop> get loops => _loopDataService.loops;

  void initializeLoops() {
    _loopDataService.initializeLoopsFromUserData();
  }

  List<double> radiiLoop(List<Loop> loopsies) {
    List<double> loopRadii = [];
    loopsies.forEach((loop) {
      loopRadii.add(kradiusCalculator(loop.numberOfMembers));
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

  @override
  List<ReactiveServiceMixin> get reactiveServices => [_loopDataService];
}
