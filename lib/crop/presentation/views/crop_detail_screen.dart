import 'package:flutter/material.dart';
import 'package:greentools/crop/domain/inventory.dart';

class CropDetailScreen extends StatelessWidget {
  final Inventory crop;

  const CropDetailScreen({Key? key, required this.crop}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(crop.stationName),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Image.network(
              'https://us.images.westend61.de/0001691190pw/primer-plano-vertical-de-un-hongo-ostra-comestible-MINF16552.jpg',
              fit: BoxFit.cover,
            ),
            Container(
              width: double.infinity,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 16.0),
                    child: Text(
                      crop.plant,
                      style:
                          TextStyle(fontSize: 40, fontWeight: FontWeight.bold),
                    ),
                  ),
                ],
              ),
            ),
            ListTile(
              leading: Icon(Icons.wb_sunny),
              title: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text("Sunlight: ${crop.uvSolar}"),
              ),
            ),
            ListTile(
              leading: Icon(Icons.thermostat_outlined),
              title: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text("Temperature: ${crop.temperature}"),
              ),
            ),
            ListTile(
              leading: Icon(Icons.opacity),
              title: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text("Water: ${crop.humidity}"),
              ),
            ),
            //insert a buttom
            Container(
              width: double.infinity,
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: Container(
                  width: MediaQuery.of(context).size.width * 0.85,
                  height: 50,
                  child: ElevatedButton(
                    onPressed: () {
                      // Add plant to user's collection
                    },
                    style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(100),
                      ),
                      backgroundColor: Color(0xFF276749),
                    ),
                    child: Text(
                      "Add me to a pot",
                      style: TextStyle(color: Colors.white, fontSize: 20),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
