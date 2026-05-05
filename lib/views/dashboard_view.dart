import 'package:flutter/material.dart';
import 'package:geoesplora/theme/app_color.dart';
import 'package:geoesplora/widgets/my_rocks_banner.dart';
import 'package:geoesplora/widgets/filter_pills.dart';
import 'package:geoesplora/widgets/geosite_card.dart';
import 'package:geoesplora/models/mock_data.dart';

class DashboardView extends StatefulWidget {
  const DashboardView({super.key});

  @override
  State<DashboardView> createState() => _DashboardViewState();
}

class _DashboardViewState extends State<DashboardView> {
  int _selectedFilterIndex = 0;

  @override
  Widget build(BuildContext context) {
    final geositi = MockData.mockGeosites;

    return SingleChildScrollView(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // SALUTO
          const Text(
            "Hi, Giuseppe",
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: AppColors.textPrimary,
            ),
          ),
          const SizedBox(height: 20),

          //BANNER MIE ROCCE
          MyRocksBanner(onCameraTap: () => debugPrint("Apro fotocamera!")),
          const SizedBox(height: 25),

          //TITOLO SEZIONE
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              const Text(
                "Geositi popolari",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: AppColors.textPrimary,
                ),
              ),
              GestureDetector(
                onTap: () => debugPrint("Vai alla HomeView (Tutti i geositi)"),
                child: const Text(
                  "visualizza tutti",
                  style: TextStyle(
                    fontSize: 12,
                    color: AppColors.secondary,
                    decoration: TextDecoration.underline,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 15),

          //FILTRO
          FilterPills(
            options: const ["Consigliati", "Vicini", "Salvati"],
            selectedIndex: _selectedFilterIndex,
            onSelected: (index) {
              setState(() {
                _selectedFilterIndex = index;
              });
            },
          ),
          const SizedBox(height: 25),

          if (_selectedFilterIndex == 2)
            const Center(
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: 40),
                child: Text(
                  "Nessun geosito disponibile",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: AppColors.textPrimary,
                  ),
                ),
              ),
            )
          else
            SizedBox(
              height: 220,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: geositi.length,
                itemBuilder: (context, index) {
                  final geosito = geositi[index];
                  return Container(
                    width: 280,
                    margin: const EdgeInsets.only(right: 16.0),
                    child: GeositeCard(
                      imageUrl: geosito.imageUrl,
                      placeholder: geosito.name,
                      location: geosito.location,
                      rating: geosito.rating,
                      reviewCount: geosito.reviewCount,
                    ),
                  );
                },
              ),
            ),
        ],
      ),
    );
  }
}
