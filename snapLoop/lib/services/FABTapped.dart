import 'package:injectable/injectable.dart';
import 'package:observable_ish/value/value.dart';
import 'package:stacked/stacked.dart';

@lazySingleton
class FABTapped with ReactiveServiceMixin {
  FABTapped() {
    listenToReactiveValues([_isTapped]);
  }
  RxValue<bool> _isTapped = RxValue<bool>(initial: false);
  bool get isTapped => _isTapped.value;

  void toggleIsTapped() {
    _isTapped.value = !_isTapped.value;
  }
}
