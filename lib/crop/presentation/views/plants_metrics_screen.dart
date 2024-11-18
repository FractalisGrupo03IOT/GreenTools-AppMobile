import 'package:flutter/material.dart';
import 'package:greentools/common/widgets/navigation_appbar.dart';
import 'package:greentools/common/widgets/horizontal_background_painter.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:greentools/crop/application/crop_data_service.dart';
import 'package:greentools/crop/domain/crop_data.dart';

class PlantMetricsScreen extends StatefulWidget {
  final String plantName;
  final String plantImage;
  final int plantId;

  const PlantMetricsScreen({
    Key? key,
    required this.plantName,
    required this.plantImage,
    required this.plantId,
  }) : super(key: key);

  @override
  _PlantMetricsScreenState createState() => _PlantMetricsScreenState();
}

class _PlantMetricsScreenState extends State<PlantMetricsScreen> {
  final CropDataService _cropDataService = CropDataService();
  List<CropData> _cropDataList = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _fetchCropData();
  }

  Future<void> _fetchCropData() async {
    try {
      final cropData = await _cropDataService.fetchCropDataByPlantId(widget.plantId);
      setState(() {
        _cropDataList = cropData;
        _isLoading = false;
      });
    } catch (e) {
      print("Error fetching crop data: $e");
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('${widget.plantName} Metrics'),
        backgroundColor: const Color(0xFF3A785D),
      ),
      body: CustomPaint(
        painter: HorizontalBackgroundPainter(),
        child: _isLoading
            ? const Center(
          child: CircularProgressIndicator(),
        )
            : _cropDataList.isEmpty
            ? const Center(
          child: Text(
            "No data available.",
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
        )
            : SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Image.network(
                  widget.plantImage,
                  height: 200,
                  width: double.infinity,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) {
                    return Container(
                      height: 200,
                      color: Colors.grey[300],
                      child: const Icon(Icons.broken_image, size: 50),
                    );
                  },
                ),
              ),
              const SizedBox(height: 10),
              _buildMetricSection('Temperature', Colors.red, '°C',
                  _cropDataList.map((data) => data.temperature).toList()),
              _buildMetricSection('Humidity', Colors.blue, '%',
                  _cropDataList.map((data) => data.humidity).toList()),
              _buildMetricSection('Light Intensity', Colors.yellow, 'UV',
                  _cropDataList.map((data) => data.uv).toList()),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  Navigator.pop(context); // Regresa a StationPlantsScreen
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF3A785D),
                  padding:
                  const EdgeInsets.symmetric(horizontal: 50, vertical: 15),
                ),
                child: const Text(
                  'Back',
                  style: TextStyle(color: Colors.white, fontSize: 16),
                ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: CustomNavigationBar(
        selectedIndex: 2,
        onDestinationSelected: (index) {
          Navigator.pop(context);
        },
      ),
    );
  }

  Widget _buildMetricSection(String title, Color color, String yAxisLabel, List<double> data) {
    final labels = _cropDataList.map((data) => data.dataDate).toList();
    return Column(
      children: [
        Text(
          title,
          style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 10),
        _buildBarChart(color: color, data: data, labels: labels, yAxisLabel: yAxisLabel),
        const SizedBox(height: 10),
      ],
    );
  }

  Widget _buildBarChart({
    required Color color,
    required List<double> data,
    required List<String> labels,
    required String yAxisLabel,
  }) {
    return Container(
      height: 300,
      decoration: BoxDecoration(
        color: Colors.grey[200], // Fondo gris
        borderRadius: BorderRadius.circular(8),
      ),
      margin: const EdgeInsets.symmetric(horizontal: 16),
      padding: const EdgeInsets.all(8.0),
      child: BarChart(
        BarChartData(
          alignment: BarChartAlignment.spaceEvenly,
          maxY: (data.reduce((a, b) => a > b ? a : b) + 10),
          barTouchData: BarTouchData(enabled: false),
          titlesData: FlTitlesData(
            leftTitles: AxisTitles(
              sideTitles: SideTitles(
                showTitles: true,
                getTitlesWidget: (value, _) => Text(
                  '${value.toInt()} $yAxisLabel',
                  style: const TextStyle(fontSize: 10),
                ),
                reservedSize: 40,
              ),
            ),
            bottomTitles: AxisTitles(
              sideTitles: SideTitles(
                showTitles: true,
                getTitlesWidget: (value, _) {
                  if (value.toInt() >= 0 && value.toInt() < labels.length) {
                    return Text(
                      labels[value.toInt()].split(' ')[0], // Mostrar solo la fecha
                      style: const TextStyle(fontSize: 10),
                    );
                  }
                  return const SizedBox.shrink();
                },
              ),
            ),
          ),
          borderData: FlBorderData(
            show: true,
            border: Border.all(color: Colors.black, width: 1),
          ),
          gridData: FlGridData(show: false),
          barGroups: data
              .asMap()
              .entries
              .map(
                (entry) => BarChartGroupData(
              x: entry.key,
              barRods: [
                BarChartRodData(
                  toY: entry.value,
                  width: 15,
                  color: color,
                  borderRadius: BorderRadius.zero,
                ),
              ],
            ),
          )
              .toList(),
        ),
      ),
    );
  }
}




