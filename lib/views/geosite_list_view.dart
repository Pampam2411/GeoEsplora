import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';
import 'package:geoesplora/theme/app_color.dart';
import 'package:geoesplora/viewmodels/bottom_nav_viewmodel.dart';
import 'package:geoesplora/viewmodels/geosite_list_viewmodel.dart';
import 'package:geoesplora/widgets/inputs/custom_search_bar.dart';
import 'package:geoesplora/widgets/cards/geosite_card.dart';
import 'package:geoesplora/widgets/navigations/custom_bottom_nav.dart';
import 'package:geoesplora/widgets/texts/title_page.dart';

class GeositeListView extends ConsumerStatefulWidget {
  const GeositeListView({super.key});
  @override
  ConsumerState<GeositeListView> createState() => _GeositeListViewState();
}

class _GeositeListViewState extends ConsumerState<GeositeListView> {
  late final StateController<String> _searchNotifier;
  late final StateController<GeositeFilter> _filterNotifier;

  @override
  void initState() {
    super.initState();
    _searchNotifier = ref.read(searchQueryProvider.notifier);
    _filterNotifier = ref.read(geositeFilterProvider.notifier);
  }

  @override
  void dispose() {
    Future.microtask(() {
      _searchNotifier.state = '';
      _filterNotifier.state = GeositeFilter();
    });
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final geosites = ref.watch(filteredGeositesProvider);
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
          ref.invalidate(searchQueryProvider);
          ref.invalidate(filteredGeositesProvider);

          ref.read(bottomNavIndexProvider.notifier).changePage(index);
          Navigator.of(context).popUntil((route) => route.isFirst);
        },
      ),
    );
  }
}
