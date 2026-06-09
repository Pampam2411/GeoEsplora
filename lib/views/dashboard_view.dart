import 'package:flutter/material.dart';
import 'package:flutter_card_swiper/flutter_card_swiper.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:geoesplora/theme/app_color.dart';
import 'package:geoesplora/viewmodels/bottom_nav_viewmodel.dart';
import 'package:geoesplora/viewmodels/geosite_list_viewmodel.dart';
import 'package:geoesplora/views/geosite_list_view.dart';
import 'package:geoesplora/widgets/inputs/custom_search_bar.dart';
import 'package:geoesplora/widgets/sections/my_rocks_banner.dart';
import 'package:geoesplora/widgets/inputs/filter_pills.dart';
import 'package:geoesplora/widgets/cards/geosite_card.dart';
import 'package:geoesplora/widgets/texts/section_label.dart';
import 'package:geoesplora/widgets/texts/title_page.dart';

class DashboardView extends ConsumerStatefulWidget {
  const DashboardView({super.key});

  @override
  ConsumerState<DashboardView> createState() => _DashboardViewState();
}

class _DashboardViewState extends ConsumerState<DashboardView> {
  int _selectedFilterIndex = 0;

  @override
  Widget build(BuildContext context) {
    final geositi = ref.watch(geositeListProvider);

    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // SALUTO
          TitlePage(title: "Hi, Giuseppe"),

          const SizedBox(height: 20),

          //BARRA RICERCA
          CustomSearchBar(
            onSearchSubmitted: (query) {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => const GeositeListView(),
                ),
              );
            },
          ),

          const SizedBox(height: 20),
          SectionLabel(text: "Le tue attività", fontSize: 10),

          const SizedBox(height: 20),

          //BANNER MIE ROCCE
          MyRocksBanner(
            onCameraTap: () {
              ref.read(bottomNavIndexProvider.notifier).changePage(2);
            },
            onMyRockTap: () {
              ref.read(bottomNavIndexProvider.notifier).changePage(3);
            },
          ),
          const SizedBox(height: 25),

          //TITOLO SEZIONE
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              SectionLabel(text: "Geositi popolari", fontSize: 10),
              GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const GeositeListView(),
                    ),
                  );
                },
                child: SectionLabel(
                  text: "visualizza tutti",
                  fontSize: 10,
                  color: AppColors.secondary,
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
                height: 300,
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
                        return GeositeCard(
                          geosite: geositi[index],
                          showShadow: true,
                        );
                      },
                ),
              ),
            ),
        ],
      ),
    );
  }
}
