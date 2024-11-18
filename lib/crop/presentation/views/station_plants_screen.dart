import 'package:flutter/material.dart';
import 'package:greentools/crop/application/plant_service.dart';
import 'package:greentools/crop/presentation/widgets/plant_card.dart';
import 'package:greentools/common/widgets/horizontal_background_painter.dart';
import 'package:greentools/crop/presentation/views/plants_metrics_screen.dart';

class StationPlantsScreen extends StatefulWidget {
  final int stationId;
  final String stationName;

  const StationPlantsScreen({
    Key? key,
    required this.stationId,
    required this.stationName,
  }) : super(key: key);

  @override
  _StationPlantsScreenState createState() => _StationPlantsScreenState();
}

class _StationPlantsScreenState extends State<StationPlantsScreen> {
  final PlantService _plantService = PlantService();
  List<Map<String, dynamic>> _plants = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadPlants();
  }

  Future<void> _loadPlants() async {
    setState(() {
      _isLoading = true;
    });

    try {
      final plants = await _plantService.fetchPlantsByStationId(widget.stationId);
      setState(() {
        _plants = plants.map((plant) => plant.toJson()).toList();
      });
    } catch (e) {
      print("Error loading plants: $e");
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.stationName),
        backgroundColor: const Color(0xFF3A785D),
      ),
      body: CustomPaint(
        painter: HorizontalBackgroundPainter(),
        child: _isLoading
            ? const Center(
          child: CircularProgressIndicator(),
        )
            : Column(
          children: [
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: _plants.isEmpty
                    ? const Center(
                  child: Text(
                    "No plants found.",
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                )
                    : GridView.builder(
                  gridDelegate:
                  const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 10,
                    mainAxisSpacing: 10,
                  ),
                  itemCount: _plants.length,
                  itemBuilder: (context, index) {
                    final plant = _plants[index];
                    return PlantCard(
                      plantImage: plant['plantImage'] ?? '',
                      name: plant['name'] ?? 'Unnamed Plant',
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => PlantMetricsScreen(
                              plantName: plant['name'] ?? 'Unnamed Plant',
                              plantImage: plant['plantImage'] ?? '',
                              plantId: plant['id'],
                            ),
                          ),
                        );
                      },
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

