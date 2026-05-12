import 'package:flutter/material.dart';
import 'package:flutter_card_swiper/flutter_card_swiper.dart';
import 'package:geoesplora/theme/app_color.dart';
import 'package:geoesplora/views/rock_list_view.dart';
import 'package:geoesplora/widgets/custom_search_bar.dart';
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
          Text(
            "Hi, Giuseppe",
            style: Theme.of(
              context,
            ).textTheme.titleMedium?.copyWith(fontSize: 20),
          ),

          const SizedBox(height: 20),

          //BARRA RICERCA
          CustomSearchBar(),

          const SizedBox(height: 20),

          Text(
            'Le tue attività',
            style: Theme.of(context).textTheme.bodySmall?.copyWith(
              fontFamily: 'AxiformaBold',
              fontSize: 10,
            ),
          ),

          const SizedBox(height: 20),

          //BANNER MIE ROCCE
          MyRocksBanner(
            onCameraTap: () => debugPrint("Apro fotocamera!"),
            onMyRockTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const RockListView()),
              );
            },
          ),
          const SizedBox(height: 25),

          //TITOLO SEZIONE
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                "Geositi popolari",
                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                  fontFamily: 'AxiformaBold',
                  fontSize: 10,
                ),
              ),
              GestureDetector(
                onTap: () => debugPrint("Vai alla HomeView (Tutti i geositi)"),
                child: Text(
                  "visualizza tutti",
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: AppColors.secondary,
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
            Center(
              child: SizedBox(
                height: 347,
                width: 279,
                child: CardSwiper(
                  scale: 0.9,
                  cardsCount: geositi.length,
                  isLoop: true,
                  numberOfCardsDisplayed: 2,
                  backCardOffset: const Offset(36, 0),
                  padding: const EdgeInsets.only(left: 10, right: 20),
                  allowedSwipeDirection: const AllowedSwipeDirection.symmetric(
                    horizontal: true,
                  ),
                  controller: CardSwiperController(),
                  cardBuilder:
                      (context, index, percentThresholdX, percentThresholdY) {
                        return GeositeCard(geosite: geositi[index]);
                      },
                ),
              ),
            ),
        ],
      ),
    );
  }
}
