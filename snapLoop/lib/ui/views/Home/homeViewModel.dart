import 'package:SnapLoop/Model/loop.dart';
import 'package:SnapLoop/app/locator.dart';
import 'package:SnapLoop/services/LoopsDataService.dart';
import 'package:stacked/stacked.dart';
import '../../../constants.dart';

class HomeViewModel extends ReactiveViewModel {
  final _loopDataService = locator<LoopsDataService>();

  // List<Loop> _loops = [];
  List<Loop> get loops => _loopDataService.loops;

  void initializeLoops() {
    _loopDataService.initializeLoopsFromUserData();
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
