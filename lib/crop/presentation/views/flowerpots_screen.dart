import 'package:flutter/material.dart';
import 'package:greentools/common/widgets/horizontal_background_painter.dart';
import 'package:greentools/common/widgets/navigation_appbar.dart';
import 'package:greentools/crop/domain/inventory.dart';
import 'package:greentools/crop/presentation/views/flowerpot_detail_screen.dart';
import 'package:greentools/crop/presentation/widgets/top_bar.dart';
import 'package:greentools/crop/domain/user.dart';
import 'package:greentools/crop/presentation/widgets/card_crop.dart';
import 'package:greentools/crop/application/user_service.dart';
import 'package:greentools/crop/application/inventory_service.dart';

/*
class FlowerpotsScreen extends StatefulWidget {
  @override
  _FlowerpotsScreenState createState() => _FlowerpotsScreenState();
}

class _FlowerpotsScreenState extends State<FlowerpotsScreen> {
  int _selectedIndex = 0;
  late Future<User?> _user;
  late Future<List<Inventory>?> _stations;
  late Future<List<Inventory>?> _stationsFake;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  Future<User>? user;
  Future<List<Inventory>>? stations;
  Future<List<Inventory>>? stationsFake;


  @override
  void initState() {
    super.initState();
    _user = UserService().getUserById(1); // Cambia el ID según tu lógica
    _stations = InventoryService().getInventoriesByUserId(1); // Cambia el ID según tu lógica
    _stationsFake = InventoryService().getFakeInventories();
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
            Padding(
              padding: const EdgeInsets.all(18.0),
              child: Text(
                "POTS",
                style: TextStyle(
                  fontSize: 35,
                  fontWeight: FontWeight.w900,
                  letterSpacing: 1.2,
                  color: Colors.white,
                ),
              ),
            ),

            Expanded(
              child: FutureBuilder<List<Inventory>>(
                future: stationsFake,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.done) {
                    if (snapshot.hasData) {
                      int itemCount = snapshot.data!.length +
                          1; // +1 para el botón de '+'
                      return GridView.builder(
                        padding: EdgeInsets.symmetric(horizontal: 15),
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          crossAxisSpacing: 10,
                          mainAxisSpacing: 10,
                          childAspectRatio: 0.8,
                        ),
                        itemCount: itemCount,
                        itemBuilder: (context, index) {
                          if (index < snapshot.data!.length) {
                            return CardCrop(
                              station: snapshot.data![index],
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) =>
                                        FlowerpotDetailScreen(), // Aquí puedes pasar datos si es necesario
                                  ),
                                );
                              },
                            );
                          } else {
                            // Botón '+' para agregar más plantas
                            return Center(
                              child: RawMaterialButton(
                                onPressed: () {
                                  // Implementa la acción para agregar una nueva planta
                                },
                                elevation: 2.0,
                                fillColor: Color(0xFFEDEDED),
                                child: Icon(
                                  Icons.add,
                                  size: 50.0,
                                  color: Colors.black,
                                ),
                                padding: EdgeInsets.all(15.0),
                                shape: CircleBorder(),
                              ),
                            );
                          }
                        },
                      );
                    } else if (snapshot.hasError) {
                      return Center(
                          child:
                              Text('Error al cargar datos: ${snapshot.error}'));
                    }
                  }
                  return Center(
                      child:
                          CircularProgressIndicator()); // Muestra un spinner de carga
                },
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
*/