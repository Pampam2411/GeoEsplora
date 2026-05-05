import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:geoesplora/models/user.dart';

class UserViewModel extends Notifier<AppUser> {
  @override
  AppUser build() {
    return AppUser(
      id: 'u1',
      name: 'Mario Rossi',
      email: 'mario.rossi@example.com',
      favoriteGeositeIds: ['g2'],
      visitedGeositeIds: [],
    );
  }

  void toggleFavorite(String geositeId) {
    final isFavorite = state.favoriteGeositeIds.contains(geositeId);

    List<String> newFavorites = List.from(state.favoriteGeositeIds);

    if (isFavorite) {
      newFavorites.remove(geositeId);
    } else {
      newFavorites.add(geositeId);
    }
    state = state.copyWith(favoriteGeositeIds: newFavorites);
  }
}

final userProvider = NotifierProvider<UserViewModel, AppUser>(() {
  return UserViewModel();
});
