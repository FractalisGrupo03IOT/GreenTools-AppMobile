import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:greentools/crop/domain/station.dart'; // Asegúrate de que la ruta sea la correcta

class StationRepository {
  final String baseUrl1 = "https://fractalisbackend-production.up.railway.app/api/v1/stations";
  final String baseUrl2 = "https://fractalisbackend-production.up.railway.app/api/v1/station";

  Future<List<Station>> getAllStations() async {
    final response = await http.get(Uri.parse(baseUrl1));
    if (response.statusCode == 200) {
      List<dynamic> data = json.decode(response.body);
      return data.map((json) => Station.fromJson(json)).toList();
    } else {
      throw Exception("Failed to fetch stations");
    }
  }

  Future<Station> getStationById(int id) async {
    final response = await http.get(Uri.parse('$baseUrl2/$id'));
    if (response.statusCode == 200) {
      return Station.fromJson(json.decode(response.body));
    } else {
      throw Exception("Failed to fetch station by id");
    }
  }

  Future<List<Station>> getStationsByUserId(int userId) async {
    final response = await http.get(Uri.parse('$baseUrl1/userId/$userId'));
    if (response.statusCode == 200) {
      List<dynamic> data = json.decode(response.body);
      return data.map((json) => Station.fromJson(json)).toList();
    } else {
      throw Exception("Failed to fetch stations by user id");
    }
  }

  Future<void> createStation(Station station) async {
    final response = await http.post(
      Uri.parse(baseUrl2),
      headers: {'Content-Type': 'application/json'},
      body: json.encode(station.toJson()),
    );
    if (response.statusCode != 201) {
      throw Exception("Failed to create station");
    }
  }

  Future<void> updateStation(int id, Station station) async {
    final response = await http.put(
      Uri.parse('$baseUrl2/$id'),
      headers: {'Content-Type': 'application/json'},
      body: json.encode(station.toJson()),
    );
    if (response.statusCode != 200) {
      throw Exception("Failed to update station");
    }
  }

  Future<void> deleteStation(int id) async {
    final response = await http.delete(Uri.parse('$baseUrl2/$id'));
    if (response.statusCode != 204) {
      throw Exception("Failed to delete station");
    }
  }
}
