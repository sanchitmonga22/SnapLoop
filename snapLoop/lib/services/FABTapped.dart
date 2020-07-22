import 'package:injectable/injectable.dart';

@lazySingleton
class FABTapped {
  bool isTapped = false;

  void toggleIsTapped() {
    isTapped = !isTapped;
  }
}
