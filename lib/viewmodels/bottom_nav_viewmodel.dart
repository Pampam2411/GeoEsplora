import 'package:flutter_riverpod/flutter_riverpod.dart';

class BottomNavNotifier extends Notifier<int> {
  @override
  int build() {
    return 0;
  }

  void changePage(int newIndex) {
    state = newIndex;
  }
}

final bottomNavIndexProvider = NotifierProvider<BottomNavNotifier, int>(() {
  return BottomNavNotifier();
});
