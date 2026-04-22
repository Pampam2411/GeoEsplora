import 'package:flutter_riverpod/flutter_riverpod.dart';

class BottomNavViewModel extends Notifier<int> {
  @override
  int build() {
    return 0;
  }

  void setIndex(int newIndex) {
    state = newIndex;
  }
}

final bottomNavProvider = NotifierProvider<BottomNavViewModel, int>(() {
  return BottomNavViewModel();
});
