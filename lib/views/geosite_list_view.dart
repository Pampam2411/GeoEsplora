import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:geoesplora/models/mock_data.dart';
import 'package:geoesplora/theme/app_color.dart';
import 'package:geoesplora/viewmodels/bottom_nav_viewmodel.dart';
import 'package:geoesplora/widgets/inputs/custom_search_bar.dart';
import 'package:geoesplora/widgets/cards/geosite_card.dart';
import 'package:geoesplora/widgets/navigations/custom_bottom_nav.dart';
import 'package:geoesplora/widgets/texts/title_page.dart';

class GeositeListView extends ConsumerWidget {
  const GeositeListView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final geosites = MockData.mockGeosites;
    final currentIndex = ref.watch(bottomNavIndexProvider);

    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TitlePage(title: "I tuoi geositi"),

              const SizedBox(height: 20),
              CustomSearchBar(),
              const SizedBox(height: 30),
              Expanded(
                child: ListView.builder(
                  shrinkWrap: true,
                  itemBuilder: (context, index) {
                    final geosite = geosites[index];
                    return Padding(
                      padding: const EdgeInsets.only(bottom: 20.0),

                      child: SizedBox(
                        height: 165,
                        width: double.infinity,
                        child: GeositeCard(geosite: geosite),
                      ),
                    );
                  },
                  itemCount: geosites.length,
                ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: CustomBottomNav(
        currentIndex: currentIndex,
        onTap: (index) {
          ref.read(bottomNavIndexProvider.notifier).changePage(index);
          Navigator.of(context).popUntil((route) => route.isFirst);
        },
      ),
    );
  }
}
