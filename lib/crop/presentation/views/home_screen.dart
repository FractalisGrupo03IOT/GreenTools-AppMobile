import 'package:flutter/material.dart';
import 'package:greentools/common/widgets/navigation_appbar.dart';
import 'package:greentools/crop/presentation/widgets/top_bar.dart';
import 'package:greentools/common/widgets/horizontal_background_painter.dart';
import 'package:greentools/crop/application/station_service.dart';
import 'package:greentools/crop/presentation/widgets/station_card.dart';
import 'package:greentools/common/utils/local_storage_service.dart';
import 'station_plants_screen.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final StationService _stationService = StationService();
  final LocalStorageService _localStorageService = LocalStorageService();
  List<Map<String, dynamic>> _stations = [];
  bool _isLoading = true;
  int _selectedIndex = 0;

  @override
  void initState() {
    super.initState();
    _loadStations();
  }

  Future<void> _loadStations() async {
    setState(() {
      _isLoading = true;
    });

    try {
      final user = await _localStorageService.getUser();
      if (user != null && user['id'] != null) {
        final userId = user['id'];
        final stations = await _stationService.fetchStationsByUserId(userId);
        setState(() {
          _stations = stations.map((station) => station.toJson()).toList();
        });
      } else {
        print("No user found or user ID is null.");
      }
    } catch (e) {
      print("Error loading stations: $e");
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: TopBar(),
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
                child: _stations.isEmpty
                    ? const Center(
                  child: Text(
                    "No stations found.",
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                )
                    : GridView.builder(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2, // Dos columnas
                    crossAxisSpacing: 10,
                    mainAxisSpacing: 10,
                  ),
                  itemCount: _stations.length,
                  itemBuilder: (context, index) {
                    final station = _stations[index];
                    return StationCard(
                      stationImage: station['stationImage'] ?? '',
                      stationName: station['stationName'] ?? 'Unnamed Station',
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => StationPlantsScreen(
                              stationId: station['Id'],
                              stationName: station['stationName'],
                            ),
                          ),
                        );
                      },
                    );
                  },
                ),
              ),
            ),
            // Botón flotante debajo del listado
            Padding(
              padding: const EdgeInsets.only(bottom: 16.0),
              child: FloatingActionButton(
                onPressed: () {
                  Navigator.pushNamed(context, "addStation");
                },
                child: const Icon(Icons.add),
                backgroundColor: const Color(0xFF3A785D),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: CustomNavigationBar(
        selectedIndex: _selectedIndex,
        onDestinationSelected: _onItemTapped,
      ),
    );
  }
}



