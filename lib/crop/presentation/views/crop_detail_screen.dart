import 'package:flutter/material.dart';
import 'package:greentools/crop/domain/crop_available.dart';

class CropDetailScreen extends StatelessWidget {
  final CropAvailable crop;

  const CropDetailScreen({Key? key, required this.crop}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(crop.cropName),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Image.network(
              crop.cropImageUrl,
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
                      crop.cropName,
                      style:
                          TextStyle(fontSize: 40, fontWeight: FontWeight.bold),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 5.0, left: 14),
              child: Text(
                "Description:",
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(14.0),
              child: Text(
                crop.description,
                style: TextStyle(fontSize: 16),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 14.0, left: 14),
              child: Text(
                "Recommendations:",
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(14.0),
              child: Text(
                crop.recommendation,
                style: TextStyle(fontSize: 16),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 14.0, left: 14),
              child: Text(
                "Care Instructions:",
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
            ),
            ListTile(
              leading: Icon(Icons.wb_sunny),
              title: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text("Sunlight: ${crop.careIcons['sunlight']}"),
              ),
            ),
            ListTile(
              leading: Icon(Icons.thermostat_outlined),
              title: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text("Temperature: ${crop.careIcons['temperature']}"),
              ),
            ),
            ListTile(
              leading: Icon(Icons.opacity),
              title: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text("Water: ${crop.careIcons['water']}"),
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
