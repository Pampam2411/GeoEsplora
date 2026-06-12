import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:geoesplora/theme/app_color.dart';
import 'package:geoesplora/viewmodels/geosite_list_viewmodel.dart';
import 'package:geoesplora/viewmodels/location.viewmodel.dart';
import 'package:geoesplora/widgets/texts/section_label.dart';

class CustomSearchBar extends ConsumerStatefulWidget {
  final void Function(String)? onSearchSubmitted;
  const CustomSearchBar({super.key, this.onSearchSubmitted});
  @override
  ConsumerState<CustomSearchBar> createState() => _CustomSearchBarState();
}

class _CustomSearchBarState extends ConsumerState<CustomSearchBar> {
  final TextEditingController _textController = TextEditingController();
  bool _isExpanded = false;

  final LayerLink _layerLink = LayerLink();
  OverlayEntry? _overlayEntry;

  double _tempoDisponibile = 60;
  bool _budgetBasso = false;
  bool _budgetMedio = false;
  bool _budgetAlto = false;
  final List<String> _distanzeSelezionate = [];
  double _lunghezzaPercorso = 60;
  bool _accessibilita = false;
  final List<String> _categorieSelezionate = [];

  @override
  void dispose() {
    _removeOverlay();
    _textController.dispose();
    super.dispose();
  }

  void _toggleFilters() {
    if (_isExpanded) {
      _removeOverlay();
    } else {
      _showOverlay();
    }
    setState(() {
      _isExpanded = !_isExpanded;
    });
  }

  void _updateState(VoidCallback fn) {
    setState(fn);
    _overlayEntry?.markNeedsBuild();
  }

  void _eseguiRicerca() {
    debugPrint("Ricerca avviata...");

    if (_distanzeSelezionate.contains('Vicino a me')) {
      ref.read(userLocationProvider.notifier).fetchLocation();
    }

    final currentFilters = GeositeFilter(
      tempoMassimo: _tempoDisponibile,
      budgetBasso: _budgetBasso,
      budgetMedio: _budgetMedio,
      budgetAlto: _budgetAlto,
      province: _distanzeSelezionate,
      lunghezzaMassima: _lunghezzaPercorso,
      soloAccessibili: _accessibilita,
    );
    ref.read(geositeFilterProvider.notifier).state = currentFilters;
    _toggleFilters();
    FocusScope.of(context).unfocus();
    if (widget.onSearchSubmitted != null) {
      widget.onSearchSubmitted!(_textController.text);
    }
  }

  void _toggleListItem(List<String> list, String item, bool? isChecked) {
    _updateState(() {
      if (isChecked == true) {
        list.add(item);
      } else {
        list.remove(item);
      }
    });
  }

  void _showOverlay() {
    final overlay = Overlay.of(context);
    final renderBox = context.findRenderObject() as RenderBox;
    final size = renderBox.size;

    _overlayEntry = OverlayEntry(
      builder: (context) => Positioned(
        width: size.width,
        child: CompositedTransformFollower(
          link: _layerLink,
          showWhenUnlinked: false,
          offset: Offset(0.0, size.height - 1),
          child: Material(
            elevation: 0.0,
            color: Colors.transparent,
            child: Container(
              decoration: BoxDecoration(
                color: AppColors.background,
                borderRadius: const BorderRadius.vertical(
                  bottom: Radius.circular(22),
                ),
                border: const Border(
                  left: BorderSide(color: AppColors.secondary, width: 1),
                  right: BorderSide(color: AppColors.secondary, width: 1),
                  bottom: BorderSide(color: AppColors.secondary, width: 1),
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.15),
                    blurRadius: 10,
                    spreadRadius: -2,
                    offset: const Offset(0, 6),
                  ),
                ],
              ),
              constraints: BoxConstraints(
                maxHeight: MediaQuery.of(context).size.height * 0.6,
              ),
              child: SingleChildScrollView(child: _buildFilterContent()),
            ),
          ),
        ),
      ),
    );

    overlay.insert(_overlayEntry!);
  }

  void _removeOverlay() {
    _overlayEntry?.remove();
    _overlayEntry = null;
  }

  @override
  Widget build(BuildContext context) {
    final borderRadius = BorderRadius.vertical(
      top: const Radius.circular(10),
      bottom: Radius.circular(_isExpanded ? 0 : 10),
    );

    return CompositedTransformTarget(
      link: _layerLink,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 100),
        decoration: BoxDecoration(
          color: AppColors.background,
          borderRadius: borderRadius,

          border: Border.all(color: AppColors.secondary, width: 1),
        ),
        child: SizedBox(
          height: 42,
          child: TextField(
            controller: _textController,
            textInputAction: TextInputAction.search,
            onChanged: (value) {
              ref.read(searchQueryProvider.notifier).state = value;
            },
            onSubmitted: (value) {
              if (_isExpanded) {
                _toggleFilters();
              }
              FocusScope.of(context).unfocus();

              ref.read(searchQueryProvider.notifier).state = value;
              _textController.clear();

              if (widget.onSearchSubmitted != null) {
                widget.onSearchSubmitted!(value);
              }
            },
            decoration: InputDecoration(
              hintText: 'Cerca geosito...',
              hintStyle: Theme.of(context).textTheme.bodySmall?.copyWith(
                color: AppColors.secondary,
                fontSize: 10,
                fontFamily: 'AxiformaRegular',
              ),
              border: InputBorder.none,
              enabledBorder: InputBorder.none,
              focusedBorder: InputBorder.none,
              contentPadding: const EdgeInsets.only(left: 23, right: 8, top: 6),
              suffixIcon: IconButton(
                icon: const FaIcon(
                  FontAwesomeIcons.sliders,
                  size: 18,
                  color: AppColors.secondary,
                ),
                onPressed: _toggleFilters,
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildFilterContent() {
    return Padding(
      padding: const EdgeInsets.only(left: 20, right: 20, top: 10, bottom: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildSectionTitle('Tempo disponibile (minuti)'),
          Slider(
            value: _tempoDisponibile,
            max: 60,
            divisions: 6,
            activeColor: AppColors.secondary,
            label: _tempoDisponibile >= 60
                ? '60+'
                : _tempoDisponibile.toInt().toString(),
            onChanged: (val) => _updateState(() => _tempoDisponibile = val),
          ),

          _buildSectionTitle('Budget stimato'),
          Padding(
            padding: const EdgeInsets.only(bottom: 10.0),
            child: Row(
              children: [
                _buildBudgetCheckbox(
                  '€',
                  _budgetBasso,
                  (val) => _updateState(() => _budgetBasso = val ?? false),
                ),
                const SizedBox(width: 20),
                _buildBudgetCheckbox(
                  '€€',
                  _budgetMedio,
                  (val) => _updateState(() => _budgetMedio = val ?? false),
                ),
                const SizedBox(width: 20),
                _buildBudgetCheckbox(
                  '€€€',
                  _budgetAlto,
                  (val) => _updateState(() => _budgetAlto = val ?? false),
                ),
              ],
            ),
          ),

          _buildSectionTitle('Distanza / area geografica'),
          _buildCheckboxGrid([
            'Vicino a me',
            'Crotone',
            'Cosenza',
            'Reggio Calabria',
            'Catanzaro',
            'Vibo Valentia',
          ], _distanzeSelezionate),

          _buildSectionTitle('Lunghezza percorso massimo (km)'),
          Slider(
            value: _lunghezzaPercorso,
            max: 60,
            divisions: 12,
            activeColor: AppColors.secondary,
            label: _lunghezzaPercorso >= 60
                ? '60+'
                : _lunghezzaPercorso.toInt().toString(),
            onChanged: (val) => _updateState(() => _lunghezzaPercorso = val),
          ),

          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _buildSectionTitle('Accessibilità'),
              Switch(
                value: _accessibilita,
                activeThumbColor: AppColors.secondary,
                onChanged: (val) => _updateState(() => _accessibilita = val),
              ),
            ],
          ),

          _buildSectionTitle('Categoria di interesse'),
          _buildCheckboxGrid([
            'Geologico',
            'Minerario',
            'Paesaggistico',
            'Storico-culturale',
            'Paleontologico',
            'Naturalistico',
          ], _categorieSelezionate),

          Center(
            child: SizedBox(
              width: 89,
              height: 32,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.secondary,
                  foregroundColor: AppColors.surface,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                  elevation: 0,
                  padding: EdgeInsets.zero,
                ),
                onPressed: _eseguiRicerca,
                child: const Text('Cerca'),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.only(top: 10, bottom: 5),
      child: SectionLabel(text: title, fontSize: 13),
    );
  }

  Widget _buildCheckboxGrid(List<String> items, List<String> selectedList) {
    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      padding: EdgeInsets.zero,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        mainAxisExtent: 32,
        crossAxisSpacing: 10,
      ),
      itemCount: items.length,
      itemBuilder: (context, index) {
        final item = items[index];
        return Row(
          children: [
            SizedBox(
              width: 24,
              height: 24,
              child: Checkbox(
                value: selectedList.contains(item),
                activeColor: AppColors.secondary,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(4),
                ),
                materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                onChanged: (val) => _toggleListItem(selectedList, item, val),
              ),
            ),
            const SizedBox(width: 8),
            Expanded(
              child: Text(
                item,
                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                  color: AppColors.secondary,
                  fontFamily: 'AxiformaBold',
                  fontSize: 11,
                  letterSpacing: 0.2,
                ),
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        );
      },
    );
  }

  Widget _buildBudgetCheckbox(
    String label,
    bool isChecked,
    ValueChanged<bool?> onChanged,
  ) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        SizedBox(
          width: 24,
          height: 24,
          child: Checkbox(
            value: isChecked,
            onChanged: onChanged,
            activeColor: AppColors.secondary,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(4),
            ),
          ),
        ),
        const SizedBox(width: 6),
        SectionLabel(text: label, color: AppColors.secondary, fontSize: 11),
      ],
    );
  }
}
