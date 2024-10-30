import 'package:flutter/material.dart';
import 'package:greentools/common/widgets/navigation_appbar.dart';
import 'package:greentools/crop/presentation/widgets/flowerpot_dashboard.dart';
import 'package:greentools/crop/presentation/widgets/flowerpot_info.dart';

class FlowerpotMetricsScreen extends StatefulWidget {
  const FlowerpotMetricsScreen({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _FlowerpotMetricsScreenState createState() => _FlowerpotMetricsScreenState();
}

class _FlowerpotMetricsScreenState extends State<FlowerpotMetricsScreen> {
  int _selectedIndex = 2;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomPaint(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            buildCustomAppBar(context),
            const CropInfoComponent(),
            const PlantChartsComponent()
          ],
        ),
      ),
      bottomNavigationBar: CustomNavigationBar(
        selectedIndex: _selectedIndex,
        onDestinationSelected: _onItemTapped,
      ),
    );
  }

  Widget buildCustomAppBar(BuildContext context) {
    return Container(
      color: Colors.transparent,
      padding: const EdgeInsets.only(left: 5, top: 40, bottom: 5),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          IconButton(
            icon: const Icon(Icons.arrow_back, color: Colors.black),
            iconSize: 36,
            onPressed: () => Navigator.of(context).pop(),
          ),
          const Text('CROP 1',
              style: TextStyle(
                  color: Colors.black,
                  fontSize: 36,
                  fontWeight: FontWeight.bold)),
          Opacity(
              opacity: 0.0,
              child: IconButton(
                  icon: const Icon(Icons.arrow_back), onPressed: () {})),
        ],
      ),
    );
  }
}

