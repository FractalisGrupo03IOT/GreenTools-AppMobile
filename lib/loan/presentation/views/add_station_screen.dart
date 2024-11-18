import 'package:flutter/material.dart';
import 'package:greentools/loan/presentation/widgets/Station_Input.dart';
import 'package:greentools/common/widgets/navigation_appbar.dart';
import 'package:greentools/crop/presentation/widgets/top_bar.dart';
import 'package:greentools/common/widgets/horizontal_background_painter.dart';
import 'package:path/path.dart';

class AddStationScreen extends StatefulWidget {
  @override
  _AddStationScreenState createState() => _AddStationScreenState();
}

class _AddStationScreenState extends State<AddStationScreen> {
  int _selectedIndex = 0;

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
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // StationInputWidget
                      StationInputWidget(
                        onImageUrlSubmitted: (url) {
                          print('Image URL submitted: $url');
                        },
                        onStationDataSubmitted: (name, isGreenHouse) {
                          print('Station Name: $name, Type: ${isGreenHouse ? "GreenHouse" : "Microculture"}');
                        },
                      ),
                      const SizedBox(height: 20.0),
                      // Label "Your Plants"
                      const Text(
                        "Your Plants",
                        style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 16.0),
                      // Botón circular "+"
                      Center(
                        child: FloatingActionButton(
                          onPressed: () {
                            print("Add plant button pressed");
                            Navigator.pushNamed(context, 'addPlant');
                          },
                          child: const Icon(Icons.add),
                          backgroundColor: const Color(0xFF3A785D),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            // Botones "Save" y "Cancel"
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  ElevatedButton.icon(
                    onPressed: () {
                      print("Save action");
                      // Lógica para guardar la estación
                    },
                    icon: const Icon(Icons.save),
                    label: const Text("Save"),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF3A785D),
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.pop(context); // Regresa a la pantalla anterior
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.grey,
                    ),
                    child: const Text("Cancel"),
                  ),
                ],
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

