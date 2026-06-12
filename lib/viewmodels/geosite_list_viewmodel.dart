import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';
import 'package:geoesplora/models/geosite.dart';
import 'package:geoesplora/models/mock_data.dart';
import 'package:geoesplora/viewmodels/location.viewmodel.dart';
import 'package:latlong2/latlong.dart';

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
  final userLocation = ref.watch(userLocationProvider);

  return allGeosites.where((geosite) {
    if (query.isNotEmpty && !geosite.name.toLowerCase().contains(query)) {
      return false;
    }

    if (filters.soloAccessibili && !geosite.isAccessible) {
      return false;
    }

    if (filters.province.isNotEmpty) {
      bool matchProvincia = false;
      bool isVicino = false;

      final provinciaGeosito = geosite.location
          .split(',')
          .first
          .trim()
          .toLowerCase();

      for (var prov in filters.province) {
        if (prov == 'Vicino a me') continue;
        if (provinciaGeosito == prov.toLowerCase()) {
          matchProvincia = true;
          break;
        }
      }

      if (filters.province.contains('Vicino a me') && userLocation != null) {
        // Calcoliamo la distanza in chilometri tra l'utente e il geosito
        const distanceCalculator = Distance();
        final double distanceInKm = distanceCalculator.as(
          LengthUnit.Kilometer,
          userLocation,
          LatLng(geosite.latitude, geosite.longitude),
        );

        if (distanceInKm <= 50.0) {
          isVicino = true;
        }
      }

      if (!matchProvincia && !isVicino) {
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
