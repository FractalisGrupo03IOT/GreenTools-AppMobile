import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/services.dart';
import 'package:greentools/crop/domain/crop_data.dart'; // Asegúrate de que la ruta sea la correcta

class CropDataRepository {
  final String baseUrl1 = "https://fractalisbackend-production.up.railway.app/api/v1/cropData";
  final String baseUrl2 = "https://fractalisbackend-production.up.railway.app/api/v1/lastMonthCropData";

  Future<void> createCropData(CropData cropData) async {
    final response = await http.post(
      Uri.parse(baseUrl1),
      headers: {'Content-Type': 'application/json'},
      body: json.encode(cropData.toJson()),
    );
    if (response.statusCode != 201) {
      throw Exception("Failed to create crop data");
    }
  }

  Future<List<CropData>> getCropDataLastMonthById(int plantId) async {
    final response = await http.get(Uri.parse('$baseUrl2/$plantId'));
    if (response.statusCode == 200) {
      List<dynamic> data = json.decode(response.body);
      return data.map((json) => CropData.fromJson(json)).toList();
    } else {
      throw Exception("Failed to fetch last month crop data");
    }
  }

  Future<List<CropData>> getCropDataByPlantId(int plantId) async {
    final response = await http.get(Uri.parse('$baseUrl1/$plantId'));
    if (response.statusCode == 200) {
      List<dynamic> data = json.decode(response.body);
      return data.map((json) => CropData.fromJson(json)).toList();
    } else {
      throw Exception("Failed to fetch crop data by plant id");
    }
  }
}