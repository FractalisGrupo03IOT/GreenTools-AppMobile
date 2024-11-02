import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/services.dart';
import 'package:greentools/crop/domain/user.dart'; // Asegúrate de que la ruta sea la correcta

class UserRepository {
  final String apiUrl = "https://backend-demo-gj8g.onrender.com/api/v1/users"; // Cambia esta URL según tu API
  final String apiUrlById = "https://backend-demo-gj8g.onrender.com/api/v1/users";

  Future<List<User>> getUsers() async {
    final response = await http.get(Uri.parse(apiUrl));

    if (response.statusCode == 200) {
      List<dynamic> data = json.decode(response.body);
      return data.map((userJson) => User.fromJson(userJson)).toList();
    } else {
      throw Exception("Error al obtener la lista de usuarios");
    }
  }
  Future<User> getFakeUser() async {
    // Simulando carga de datos desde un JSON local
    final String response = await rootBundle.loadString('assets/user.json');
    final data = jsonDecode(response);
    return User.fromJson(data);
  }
}
