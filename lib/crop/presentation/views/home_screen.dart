import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:greentools/common/widgets/navigation_appbar.dart';
import 'package:greentools/crop/presentation/widgets/top_bar.dart';
import 'package:greentools/common/widgets/horizontal_background_painter.dart';
import 'package:greentools/crop/application/station_service.dart';
import 'package:greentools/crop/domain/station.dart';
import 'package:greentools/common/utils/local_storage_service.dart';
import 'package:greentools/crop/presentation/widgets/station_card.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;

  // Lista de estaciones simulada
  final List<Map<String, String>> _stations =
  [
    {
      "Id": "2",
      "userId": "1",
      "stationName": "GORENCITO",
      "description": "MULTICULTIVO DE PLATANITOS ",
      "stationImage": 'https://us.images.westend61.de/0001691190pw/primer-plano-vertical-de-un-hongo-ostra-comestible-MINF16552.jpg',
      "startDate": "02-11-2024",
      "endDate": "02-10-2025",
    },
    {
      "Id": "9",
      "userId": "1",
      "stationName": "Station 1",
      "description": "Microcultivo de Hongos",
      "stationImage": 'https://us.images.westend61.de/0001691190pw/primer-plano-vertical-de-un-hongo-ostra-comestible-MINF16552.jpg',
      "startDate": "16-11-2024",
      "endDate": "16-11-2024",
    }
  ];

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
        child: Column(
          children: [
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: GridView.builder(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2, // Dos columnas
                    crossAxisSpacing: 10,
                    mainAxisSpacing: 10,
                  ),
                  itemCount: _stations.length,
                  itemBuilder: (context, index) {
                    final station = _stations[index];
                    return StationCard(
                      stationImage: station['stationImage']!,
                      stationName: station['stationName']!,
                      onTap: () {
                        // Acción al presionar la tarjeta
                        print('Tapped on ${station['stationName']}');
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

