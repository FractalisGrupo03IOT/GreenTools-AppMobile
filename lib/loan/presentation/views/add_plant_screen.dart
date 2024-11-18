import 'package:flutter/material.dart';
import 'package:greentools/common/widgets/navigation_appbar.dart';
import 'package:greentools/crop/presentation/widgets/top_bar.dart';
import 'package:greentools/common/widgets/horizontal_background_painter.dart';
import 'package:greentools/crop/presentation/widgets/plant_card.dart';

class AddPlantScreen extends StatelessWidget {
  final List<Map<String, String>> _plants = [
    {
      'plantImage': 'https://images.pexels.com/photos/4022083/pexels-photo-4022083.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1',
      'name': 'Tomate',
    },
    {
      'plantImage': 'https://images.pexels.com/photos/1382102/pexels-photo-1382102.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1',
      'name': 'Maiz',
    },
    {
      'plantImage': 'https://images.pexels.com/photos/60021/grapes-wine-fruit-vines-60021.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1',
      'name': 'Uva',
    },
    {
      'plantImage': 'https://images.pexels.com/photos/265278/pexels-photo-265278.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1',
      'name': 'Trigo',
    },
    {
      'plantImage': 'https://images.pexels.com/photos/9201495/pexels-photo-9201495.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1',
      'name': 'Soja',
    },
    {
      'plantImage': 'https://images.pexels.com/photos/144248/potatoes-vegetables-erdfrucht-bio-144248.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1',
      'name': 'Papa',
    },
    {
      'plantImage': 'https://images.pexels.com/photos/3568039/pexels-photo-3568039.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1',
      'name': 'Pepino',
    },
    {
      'plantImage': 'https://images.pexels.com/photos/11022366/pexels-photo-11022366.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1',
      'name': 'Cebollin',
    },
    {
      'plantImage': 'https://images.pexels.com/photos/594137/pexels-photo-594137.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1',
      'name': 'Pimiento',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: TopBar(),
      body: CustomPaint(
        painter: HorizontalBackgroundPainter(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Padding(
              padding: EdgeInsets.all(16.0),
              child: Text(
                "Choose your plant:",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: GridView.builder(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2, // Dos columnas
                    crossAxisSpacing: 10,
                    mainAxisSpacing: 10,
                  ),
                  itemCount: _plants.length,
                  itemBuilder: (context, index) {
                    final plant = _plants[index];
                    return PlantCard(
                      plantImage: plant['plantImage']!,
                      name: plant['name']!,
                      onTap: () {
                        print('Selected: ${plant['name']}');
                      },
                    );
                  },
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  ElevatedButton.icon(
                    onPressed: () {
                      print('Add plant action');
                      // Navega o realiza la acción de agregar
                    },
                    icon: const Icon(Icons.add),
                    label: const Text('Add'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF3A785D),
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.pop(context); // Cerrar la vista
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.grey,
                    ),
                    child: const Text('Cancel'),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: CustomNavigationBar(
        selectedIndex: 1, // Índice actual
        onDestinationSelected: (index) {
          print("Selected index: $index");
        },
      ),
    );
  }
}
