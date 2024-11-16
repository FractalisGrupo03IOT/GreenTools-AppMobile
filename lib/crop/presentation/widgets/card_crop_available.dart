import 'package:flutter/material.dart';
import 'package:greentools/crop/domain/crop_data.dart';
import 'package:greentools/crop/domain/plant.dart';
/*
class CardCropAvailable extends StatelessWidget {
  final CropData cropInfoCare;
  final Plant cropInfoPlant;
  final Function(Inventory) onTap;

  const CardCropAvailable(
      {Key? key, required this.cropAvailable, required this.onTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => onTap(cropAvailable),
      child: Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Expanded(
              child: ClipRRect(
                borderRadius: BorderRadius.vertical(top: Radius.circular(15)),
                child: Image.network(
                  'https://us.images.westend61.de/0001691190pw/primer-plano-vertical-de-un-hongo-ostra-comestible-MINF16552.jpg',
                  fit: BoxFit.cover,
                  width: double.infinity,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  Text(
                    cropAvailable.stationName,
                    textAlign: TextAlign.center,
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}*/