import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

class LocalStorageService {
  static const String _userKey = 'current_user';
  static const String _plantIdKey = 'current_plant_id';
  static const String _stationIdKey = 'current_station_id';

  // Guardar el usuario actual como JSON
  Future<void> saveUser(Map<String, dynamic> user) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString(_userKey, jsonEncode(user));
    } catch (e) {
      print("Error saving user: $e");
    }
  }

  // Obtener el usuario actual
  Future<Map<String, dynamic>?> getUser() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final userJson = prefs.getString(_userKey);
      if (userJson != null) {
        return jsonDecode(userJson) as Map<String, dynamic>;
      }
    } catch (e) {
      print("Error getting user: $e");
    }
    return null;
  }

  // Eliminar el usuario actual
  Future<void> removeUser() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.remove(_userKey);
    } catch (e) {
      print("Error removing user: $e");
    }
  }

  // Guardar el plantId actual
  Future<void> savePlantId(int plantId) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setInt(_plantIdKey, plantId);
    } catch (e) {
      print("Error saving plantId: $e");
    }
  }

  // Obtener el plantId actual
  Future<int?> getPlantId() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      return prefs.getInt(_plantIdKey);
    } catch (e) {
      print("Error getting plantId: $e");
    }
    return null;
  }

  // Guardar el stationId actual
  Future<void> saveStationId(int stationId) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setInt(_stationIdKey, stationId);
    } catch (e) {
      print("Error saving stationId: $e");
    }
  }

  // Obtener el stationId actual
  Future<int?> getStationId() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      return prefs.getInt(_stationIdKey);
    } catch (e) {
      print("Error getting stationId: $e");
    }
    return null;
  }

  // Eliminar todos los datos persistentes
  Future<void> clearAll() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.clear();
    } catch (e) {
      print("Error clearing all data: $e");
    }
  }
}


