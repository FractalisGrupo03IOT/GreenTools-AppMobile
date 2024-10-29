import 'package:flutter/material.dart';
import 'package:greentools/crop/domain/user.dart';

class CardCropSimple extends StatelessWidget {
  final CropInfo cropInfo;
  final VoidCallback? onTap;

  const CardCropSimple({Key? key, required this.cropInfo, this.onTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: onTap,
        child: Card(
          shape:
          RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Expanded(
                child: ClipRRect(
                  borderRadius: BorderRadius.vertical(
                      top: Radius.circular(15), bottom: Radius.circular(15)),
                  child: Image.network(
                    cropInfo.cropImageUrl,
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
                      cropInfo.cropName,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ));
  }
}