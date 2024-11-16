import 'package:flutter/material.dart';
import 'package:greentools/common/widgets/navigation_appbar.dart';
import 'package:greentools/crop/presentation/widgets/top_bar.dart';
import 'package:greentools/common/widgets/horizontal_background_painter.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
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
              child: Center(
                child: FloatingActionButton(
                  onPressed: () {
                    Navigator.pushNamed(context, "add_station"); // Redirige a 'add_station'
                  },
                  child: const Icon(Icons.add), // Ícono de "+"
                  backgroundColor: const Color(0xFFFFFFFF), // Color del botón
                ),
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
