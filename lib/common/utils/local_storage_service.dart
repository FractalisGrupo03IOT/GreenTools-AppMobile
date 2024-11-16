import 'package:shared_preferences/shared_preferences.dart';

class LocalStorageService {
  static const String _userKey = 'current_user';
  static const String _plantIdKey = 'current_plant_id';
  static const String _stationIdKey = 'current_station_id';

  // Guardar el usuario actual como JSON
  Future<void> saveUser(String userJson) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_userKey, userJson);
  }

  // Obtener el usuario actual
  Future<String?> getUser() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_userKey);
  }

  // Eliminar el usuario actual
  Future<void> removeUser() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_userKey);
  }

  // Guardar el plantId actual
  Future<void> savePlantId(int plantId) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt(_plantIdKey, plantId);
  }

  // Obtener el plantId actual
  Future<int?> getPlantId() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getInt(_plantIdKey);
  }

  // Guardar el stationId actual
  Future<void> saveStationId(int stationId) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt(_stationIdKey, stationId);
  }

  // Obtener el stationId actual
  Future<int?> getStationId() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getInt(_stationIdKey);
  }

  // Eliminar todos los datos persistentes
  Future<void> clearAll() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.clear();
  }
}

