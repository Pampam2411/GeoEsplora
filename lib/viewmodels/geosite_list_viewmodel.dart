import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';
import 'package:geoesplora/models/geosite.dart';
import 'package:geoesplora/models/mock_data.dart';

class GeositeFilter {
  final double tempoMassimo;
  final bool budgetBasso;
  final bool budgetMedio;
  final bool budgetAlto;
  final List<String> province;
  final double lunghezzaMassima;
  final bool soloAccessibili;

  GeositeFilter({
    this.tempoMassimo = 60,
    this.budgetBasso = false,
    this.budgetMedio = false,
    this.budgetAlto = false,
    this.province = const [],
    this.lunghezzaMassima = 60,
    this.soloAccessibili = false,
  });
}

final geositeListProvider = Provider<List<Geosite>>((ref) {
  return MockData.mockGeosites;
});

final searchQueryProvider = StateProvider<String>((ref) => '');

final geositeFilterProvider = StateProvider<GeositeFilter>(
  (ref) => GeositeFilter(),
);

final filteredGeositesProvider = Provider<List<Geosite>>((ref) {
  final allGeosites = ref.watch(geositeListProvider);
  final query = ref.watch(searchQueryProvider).trim().toLowerCase();
  final filters = ref.watch(geositeFilterProvider);

  return allGeosites.where((geosite) {
    if (query.isNotEmpty && !geosite.name.toLowerCase().contains(query)) {
      return false; // Se non contiene la parola cercata, lo scartiamo
    }

    if (filters.soloAccessibili && !geosite.isAccessible) {
      return false;
    }

    if (filters.province.isNotEmpty) {
      bool matchProvincia = false;
      for (var prov in filters.province) {
        if (prov == 'Vicino a me') continue;

        if (geosite.location.toLowerCase().contains(prov.toLowerCase())) {
          matchProvincia = true;
          break;
        }
      }

      if (!matchProvincia && filters.province.any((p) => p != 'Vicino a me')) {
        return false;
      }
    }

    if (filters.lunghezzaMassima < 60) {
      final distanceString = geosite.distance.replaceAll(
        RegExp(r'[^0-9.]'),
        '',
      );
      final distanceValue = double.tryParse(distanceString) ?? 0.0;

      if (distanceValue > filters.lunghezzaMassima) {
        return false;
      }
    }

    if (filters.tempoMassimo < 60) {
      final durationString = geosite.duration.replaceAll(
        RegExp(r'[^0-9.]'),
        '',
      );
      final durationValue = double.tryParse(durationString) ?? 0.0;

      final durationInMinutes = durationValue * 60;
      if (durationInMinutes > filters.tempoMassimo) {
        return false;
      }
    }

    bool filtraBudget =
        filters.budgetBasso || filters.budgetMedio || filters.budgetAlto;
    if (filtraBudget) {
      final isGratis = geosite.price.toLowerCase().contains('gratis');

      if (filters.budgetBasso && !isGratis) return false;
      if (!filters.budgetBasso && isGratis) return false;
    }

    return true;
  }).toList();
});
