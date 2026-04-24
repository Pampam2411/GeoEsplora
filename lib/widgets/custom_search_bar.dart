import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:geoesplora/theme/app_color.dart';

class CustomSearchBar extends StatefulWidget {
  const CustomSearchBar({super.key});

  @override
  State<CustomSearchBar> createState() => _CustomSearchBarState();
}

class _CustomSearchBarState extends State<CustomSearchBar> {
  bool _isExpanded = false;

  double _tempoDisponibile = 30;
  double _budgetStimato = 20;
  final List<String> _distanzeSelezionate = [];
  double _lunghezzaPercorso = 15;
  bool _accessibilita = false;
  final List<String> _categorieSelezionate = [];

  void _toggleFilters() {
    setState(() {
      _isExpanded = !_isExpanded;
    });
  }

  void _eseguiRicerca() {
    debugPrint(
      "Ricerca avviata con: Tempo $_tempoDisponibile, Budget: $_budgetStimato, Accessibilità: $_accessibilita",
    );
    _toggleFilters();
  }

  void _toggleListItem(List<String> list, String item, bool? isChecked) {
    setState(() {
      if (isChecked == true) {
        list.add(item);
      } else {
        list.remove(item);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final borderRadius = BorderRadius.only(
      topLeft: const Radius.circular(10),
      topRight: const Radius.circular(10),
      bottomLeft: Radius.circular(_isExpanded ? 22 : 10),
      bottomRight: Radius.circular(_isExpanded ? 22 : 10),
    );

    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
      decoration: BoxDecoration(
        color: AppColors.background,
        borderRadius: borderRadius,
        border: Border.all(color: AppColors.secondary, width: 1),
      ),

      child: ClipRRect(
        borderRadius: borderRadius,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            //BARRA RICERCA
            SizedBox(
              height: 42,
              child: TextField(
                decoration: InputDecoration(
                  hintText: 'Cerca geosito...',
                  hintStyle: TextStyle(color: AppColors.secondary),
                  border: InputBorder.none,
                  enabledBorder: InputBorder.none,
                  focusedBorder: InputBorder.none,
                  contentPadding: const EdgeInsets.only(
                    left: 20,
                    right: 8,
                    bottom: 12,
                    top: 12,
                  ),

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

            //AREA FILTRI
            AnimatedSize(
              duration: const Duration(milliseconds: 300),
              curve: Curves.easeInOut,
              alignment: Alignment.topCenter,
              child: _isExpanded
                  ? ConstrainedBox(
                      constraints: BoxConstraints(
                        maxHeight: MediaQuery.of(context).size.height * 0.6,
                      ),
                      child: SingleChildScrollView(
                        child: _buildFilterContent(),
                      ),
                    )
                  : const SizedBox(width: double.infinity, height: 0),
            ),
          ],
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
          //SLIDER TEMPO
          _buildSectionTitle('Tempo disponibilile (minuti)'),
          Slider(
            value: _tempoDisponibile,
            max: 60,
            divisions: 6,
            activeColor: AppColors.secondary,
            label: _tempoDisponibile >= 60
                ? '60+'
                : _tempoDisponibile.toInt().toString(),
            onChanged: (val) => setState(() => _tempoDisponibile = val),
          ),

          //SLIDER BUDGET
          _buildSectionTitle('Budget stimato'),
          Slider(
            value: _budgetStimato,
            max: 100,
            divisions: 20,
            activeColor: AppColors.secondary,
            label: _budgetStimato >= 100
                ? '100+'
                : _budgetStimato.toInt().toString(),
            onChanged: (val) => setState(() => _budgetStimato = val),
          ),

          //DISTANZA/AREA GEOGRAFICA
          _buildSectionTitle('Distanza / area geografica'),
          _buildCheckboxGrid([
            'Vicino a me',
            'Crotone',
            'Cosenza',
            'Reggio Calabria',
            'Catanzaro',
            'Vibo Valentia',
          ], _distanzeSelezionate),

          //LUNGHEZZA PERCORSO
          _buildSectionTitle('Lunghezza percorso massimo (km)'),
          Slider(
            value: _lunghezzaPercorso,
            max: 60,
            divisions: 12,
            activeColor: AppColors.secondary,
            label: _lunghezzaPercorso >= 60
                ? '60+'
                : _lunghezzaPercorso.toInt().toString(),
            onChanged: (val) => setState(() => _lunghezzaPercorso = val),
          ),

          //ACCESSIBILITA
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _buildSectionTitle('Accessibiliȧ'),
              Switch(
                value: _accessibilita,
                activeThumbColor: AppColors.secondary,
                onChanged: (val) => setState(() => _accessibilita = val),
              ),
            ],
          ),

          //CATEGORIE INTERESSE
          _buildSectionTitle('Categoria di interesse'),
          _buildCheckboxGrid([
            'Geologico',
            'Minerario',
            'Paesaggistico',
            'Storico-culturale',
            'Paleontologico',
            'Naturalistico',
          ], _categorieSelezionate),

          //PULSANTE CERCA
          Center(
            child: SizedBox(
              width: 89,
              height: 32,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.secondary,
                  foregroundColor: AppColors.white,
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
      child: Text(
        title,
        style: const TextStyle(
          fontWeight: FontWeight.w700,
          fontSize: 13,
          color: AppColors.textPrimary,
          letterSpacing: 0.26,
        ),
      ),
    );
  }

  Widget _buildCheckboxGrid(List<String> items, List<String> selectedList) {
    return GridView.count(
      crossAxisCount: 2,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      childAspectRatio: 4.5,
      padding: EdgeInsets.zero,
      children: items.map((item) {
        return Row(
          children: [
            Transform.scale(
              scale: 0.9,
              child: Checkbox(
                value: selectedList.contains(item),
                activeColor: AppColors.secondary,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(4),
                ),
                onChanged: (val) => _toggleListItem(selectedList, item, val),
              ),
            ),
            Expanded(
              child: Text(
                item,
                style: const TextStyle(
                  fontSize: 11,
                  fontWeight: FontWeight.w400,
                  color: AppColors.secondary,
                  height: 1.2,
                ),
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        );
      }).toList(),
    );
  }
}
