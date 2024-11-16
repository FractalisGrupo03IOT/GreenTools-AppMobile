import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/services.dart';
import 'package:greentools/crop/domain/plant.dart'; // Asegúrate de que la ruta sea la correcta

class PlantRepository {
  final String baseUrl1 = "https://fractalisbackend-production.up.railway.app/api/v1/plants";
  final String baseUrl2 = "https://fractalisbackend-production.up.railway.app/api/v1/plant";

  Future<List<Plant>> getAllPlants() async {
    final response = await http.get(Uri.parse(baseUrl1));
    if (response.statusCode == 200) {
      List<dynamic> data = json.decode(response.body);
      return data.map((json) => Plant.fromJson(json)).toList();
    } else {
      throw Exception("Failed to fetch plants");
    }
  }

  Future<Plant> getPlantById(int id) async {
    final response = await http.get(Uri.parse('$baseUrl2/$id'));
    if (response.statusCode == 200) {
      return Plant.fromJson(json.decode(response.body));
    } else {
      throw Exception("Failed to fetch plant by id");
    }
  }

  Future<List<Plant>> getPlantsByStationId(int stationId) async {
    final response = await http.get(Uri.parse('$baseUrl1/$stationId'));
    if (response.statusCode == 200) {
      List<dynamic> data = json.decode(response.body);
      return data.map((json) => Plant.fromJson(json)).toList();
    } else {
      throw Exception("Failed to fetch plants by station id");
    }
  }

  Future<void> createPlant(Plant plant) async {
    final response = await http.post(
      Uri.parse(baseUrl2),
      headers: {'Content-Type': 'application/json'},
      body: json.encode(plant.toJson()),
    );
    if (response.statusCode != 201) {
      throw Exception("Failed to create plant");
    }
  }

  Future<void> deletePlantByStationId(int id) async {
    final response = await http.delete(Uri.parse('$baseUrl2/$id'));
    if (response.statusCode != 204) {
      throw Exception("Failed to delete plants by station id");
    }
  }

  Future<Plant> getFakePlant() async {
    // Simulando carga de datos desde un JSON local
    final String response = await rootBundle.loadString('assets/user.json');
    final data = jsonDecode(response);
    return Plant.fromJson(data);
  }
}




