import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'package:greentools/crop/domain/inventory.dart'; // Asegúrate de que la ruta sea la correcta

class InventoryRepository {
  final String apiUrl = "https://api.example.com/inventories"; // Cambia esta URL según tu API

  Future<List<Inventory>> getInventories() async {
    final response = await http.get(Uri.parse(apiUrl));

    if (response.statusCode == 200) {
      List<dynamic> data = json.decode(response.body);
      return data.map((inventoryJson) => Inventory.fromJson(inventoryJson)).toList();
    } else {
      throw Exception("Error al obtener la lista de inventarios");
    }
  }
  Future<List<Inventory>> getFakeInventories() async {
    final String response =
    await rootBundle.loadString('assets/plants_available.json');
    final data = jsonDecode(response) as List;
    return data.map((e) => Inventory.fromJson(e)).toList();
  }
}
