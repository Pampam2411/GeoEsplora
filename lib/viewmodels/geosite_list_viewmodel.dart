import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:geoesplora/models/geosite.dart';
import 'package:geoesplora/models/mock_data.dart';

class GeositeListViewModel extends Notifier<List<Geosite>> {
  @override
  List<Geosite> build() {
    return MockData.mockGeosites;
  }
}

final geositeListProvider =
    NotifierProvider<GeositeListViewModel, List<Geosite>>(() {
      return GeositeListViewModel();
    });
