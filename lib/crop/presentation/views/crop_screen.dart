import 'dart:async';

import 'package:flutter/material.dart';
import 'package:greentools/common/widgets/navigation_appbar.dart';
import 'package:greentools/crop/application/crop_available_service.dart';
import 'package:greentools/crop/domain/crop_available.dart';
import 'package:greentools/crop/infrastructure/crop_available_repository.dart';
import 'package:greentools/crop/presentation/views/crop_detail_screen.dart';
import 'package:greentools/crop/presentation/widgets/card_crop_available.dart';
import 'package:greentools/crop/presentation/widgets/card_crop_simple.dart';
import 'package:greentools/crop/presentation/widgets/top_bar.dart';
import 'package:greentools/crop/domain/user.dart';
import 'package:greentools/crop/infrastructure/user_repository.dart';

class CropsScreen extends StatefulWidget {
  @override
  _CropScreenState createState() => _CropScreenState();
}

class _CropScreenState extends State<CropsScreen> {
  int _selectedIndex = 2;
  TextEditingController searchController = TextEditingController();
  late StreamController<String> searchStreamController;
  late Future<User> user;
  late Future<List<CropAvailable>> availableCrops;

  void _onItemTapped(int index) {
    if (_selectedIndex != index) {
      // Solo actualizar si el índice cambió
      setState(() {
        _selectedIndex = index;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    searchStreamController = StreamController<String>.broadcast();
    final userRepository = UserRepository();
    final cropAvailableRepository = CropAvailableRepository();
    user = userRepository.getUser();
    availableCrops =
        CropAvailableService(cropAvailableRepository).getAvailableCrops();
    searchController.addListener(() {
      searchStreamController.add(searchController.text.toLowerCase());
    });
  }

  @override
  void dispose() {
    searchController.dispose();
    searchStreamController.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: TopBar(),
      body: CustomPaint(
        child: ListView(
          children: [
            // Agregar primero la sección de las plantas del usuario
            Padding(
              padding: const EdgeInsets.all(18.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "YOUR CROPS",
                    style: TextStyle(
                      fontSize: 35,
                      fontWeight: FontWeight.w900,
                      letterSpacing: 1.2,
                      color: Colors.white,
                    ),
                  ),
                  SizedBox(height: 10),
                  FutureBuilder<List<dynamic>>(
                    future: Future.wait([user, availableCrops]),
                    builder: (context, snapshotFuture) {
                      if (!snapshotFuture.hasData) return SizedBox();
                      List<CropInfo> userCrops =
                          snapshotFuture.data![0].plants;
                      return buildUserPlantsGridView(userCrops);
                    },
                  ),
                ],
              ),
            ),
            // Sección "MORE PLANTS"
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 18.0, vertical: 10),
              child: Column(
                children: [
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      "MORE PLANTS",
                      style: TextStyle(
                        fontSize: 35,
                        fontWeight: FontWeight.w900,
                        letterSpacing: 1.2,
                        color: Colors.black,
                      ),
                    ),
                  ),
                  SizedBox(height: 10),
                  TextField(
                    controller: searchController,
                    decoration: InputDecoration(
                      labelText: "Enter the plant you want to search for",
                      prefixIcon: Icon(Icons.search),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15.0),
                      ),
                      filled: true,
                      fillColor: Colors.white,
                    ),
                  ),
                ],
              ),
            ),
            // Vista de plantas filtradas por la búsqueda
            StreamBuilder<String>(
              stream: searchStreamController.stream,
              builder: (context, snapshot) {
                // Aquí pasamos snapshot.data ?? "" que es el valor actual del searchQuery
                return FutureBuilder<List<dynamic>>(
                  future: Future.wait([user, availableCrops]),
                  builder: (context, snapshotFuture) {
                    if (!snapshotFuture.hasData) return SizedBox();
                    List<CropAvailable> crops = snapshotFuture.data![1];
                    return buildAvailableCropsGridView(crops,
                        snapshot.data ?? ""); // Pasamos el searchQuery aquí
                  },
                );
              },
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

  Widget buildUserPlantsGridView(List<CropInfo> crops) {
    return GridView.builder(
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(), // Desactiva el scroll interno
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
        childAspectRatio: 0.8,
      ),
      itemCount: crops.length,
      itemBuilder: (context, index) {
        return CardCropSimple(
          cropInfo: crops[index],
          onTap: () {
            // Implementación del onTap si es necesario
          },
        );
      },
    );
  }

  Widget buildAvailableCropsGridView(
      List<CropAvailable> crop, String searchQuery) {
    List<CropAvailable> filteredCrops = crop.where((crop) {
      return crop.cropName.toLowerCase().contains(searchQuery) ||
          crop.cropName.toLowerCase().contains(searchQuery);
    }).toList();

    return GridView.builder(
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(), // Desactiva el scroll interno
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
        childAspectRatio: 0.8,
      ),
      itemCount: filteredCrops.length,
      itemBuilder: (context, index) {
        return CardCropAvailable(
          cropAvailable: filteredCrops[index],
          onTap: (crop) {
            Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => CropDetailScreen(crop: crop,)),
            );
          },
        );
      },
    );
  }
}
