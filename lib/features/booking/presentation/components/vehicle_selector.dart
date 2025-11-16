import 'package:bus_pos/common/widgets/select_input.dart';
import 'package:bus_pos/features/booking/utils/vehicle_formatter.dart';
import 'package:bus_pos/features/booking/data/dummy_data.dart';
import 'package:bus_pos/features/booking/models/bus.dart';
import 'package:bus_pos/features/booking/presentation/components/vehicle_list.dart';
import 'package:flutter/material.dart';

class VehicleSelector extends StatefulWidget {
  const VehicleSelector({super.key});

  @override
  State<VehicleSelector> createState() => _VehicleSelectorState();
}

class _VehicleSelectorState extends State<VehicleSelector> {
  List<Bus> buses = BusData.getBuses();
  List<Bus> filteredBuses = BusData.getBuses();

  double minPrice = 0;
  double maxPrice = 10000;
  double currentMaxPrice = 10000;

  String selectedOperator = 'All';
  List<String> operators = ['All'];

  @override
  void initState() {
    super.initState();
    _calculatePriceRange();
    _initializeOperators();
  }

  void _calculatePriceRange() {
    if (buses.isEmpty) return;
    minPrice = buses.map((b) => b.fare).reduce((a, b) => a < b ? a : b);
    maxPrice = buses.map((b) => b.fare).reduce((a, b) => a > b ? a : b);
    currentMaxPrice = maxPrice;
  }

  void _initializeOperators() {
    Set<String> uniqueOperators = buses.map((b) => b.busOperator).toSet();
    operators = ['All', ...uniqueOperators];
  }

  void _applyFilters() {
    setState(() {
      filteredBuses = buses.where((bus) {
        bool priceMatch = bus.fare <= currentMaxPrice;
        bool operatorMatch =
            selectedOperator == 'All' || bus.busOperator == selectedOperator;
        return priceMatch && operatorMatch;
      }).toList();
    });
  }

  void _onOperatorSelect(String busOperator) {
    setState(() {
      selectedOperator = busOperator;
      _applyFilters();
    });
  }

  void _onPriceSelect(String priceStr) {
    setState(() {
      currentMaxPrice = double.parse(
        priceStr.replaceAll('KES ', '').replaceAll(',', ''),
      );
      _applyFilters();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.all(2),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            spacing: 5.0,
            children: [
              Text(
                '${filteredBuses.length} buses found',
                style: Theme.of(context).textTheme.headlineSmall,
              ),

              Row(
                spacing: 12.0,
                children: [
                  Expanded(
                    child: SelectInput(
                      items: operators,
                      onSelect: _onOperatorSelect,
                      placeholder: selectedOperator,
                      padding: 2,
                      fontsize: 13.0,
                      iconsize: 20,
                    ),
                  ),
                  Expanded(
                    child: SelectInput(
                      items: getPriceRanges(minPrice, maxPrice),
                      onSelect: _onPriceSelect,
                      placeholder: 'KES ${currentMaxPrice.toInt()}',
                      padding: 2,
                      fontsize: 13.0,
                      iconsize: 20,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
        Expanded(
          child: filteredBuses.isEmpty
              ? const Center(child: Text('No buses found'))
              : VehicleList(filteredBuses: filteredBuses),
        ),
      ],
    );
  }
}
