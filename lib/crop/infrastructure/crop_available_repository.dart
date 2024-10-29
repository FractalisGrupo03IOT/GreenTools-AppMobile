import 'dart:convert';
import 'package:flutter/services.dart';
import '../domain/crop_available.dart';

class CropAvailableRepository {
  Future<List<CropAvailable>> getAvailableCrop() async {
    final String response =
    await rootBundle.loadString('assets/crop_available.json');
    final data = jsonDecode(response) as List;
    return data.map((e) => CropAvailable.fromJson(e)).toList();
  }
}