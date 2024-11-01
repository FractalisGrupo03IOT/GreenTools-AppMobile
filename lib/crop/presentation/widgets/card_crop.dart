import 'package:flutter/material.dart';
import 'package:greentools/crop/domain/inventory.dart';

class CardCrop extends StatelessWidget {
  final Inventory station;
  final VoidCallback? onTap;

  const CardCrop({Key? key, required this.station, this.onTap})
      : super(key: key);

  // Función que retorna un color basado en la entrada de cuidados de la planta
  Color _getColor(int careValue) {
    switch (careValue) {
      case 1.0:
        return Colors.red;
      case 2.0:
        return Colors.orange;
      case 3.0:
        return Colors.lightGreen;
      default:
        return Colors.grey;
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: onTap,
        child: Card(
          shape:
          RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: ClipRRect(
                  borderRadius: BorderRadius.vertical(
                      top: Radius.circular(15), bottom: Radius.circular(15)),
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
                  crossAxisAlignment:
                  CrossAxisAlignment.center, // Centrar horizontalmente
                  children: [
                    SizedBox(height: 4), // Espacio entre el texto y los íconos
                    Row(
                      mainAxisAlignment: MainAxisAlignment
                          .spaceEvenly, // Distribuir íconos equitativamente
                      children: [
                        Icon(Icons.thermostat,
                            color: _getColor(station.temperature)), // Icono de temperatura
                        Icon(Icons.opacity,
                            color: _getColor(station.humidity)), // Icono de agua
                        Icon(Icons.wb_sunny,
                            color: _getColor(station.uvSolar)), // Icono de luz solar
                      ],
                    ),
                    SizedBox(height: 5), // Add top margin
                    Text(
                      station.stationName,
                      textAlign: TextAlign
                          .center, // Asegurar que el texto esté centrado
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 20, // Tamaño más grande del texto
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