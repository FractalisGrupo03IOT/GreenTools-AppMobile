import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/services.dart';
import 'package:greentools/crop/domain/user.dart'; // Asegúrate de que la ruta sea la correcta

class UserRepository {
  final String baseUrl1 = "https://fractalisbackend-production.up.railway.app/api/v1/users";
  final String baseUrl2 = "https://fractalisbackend-production.up.railway.app/api/v1/user";

  Future<List<User>> getAllUsers() async {
    final response = await http.get(Uri.parse(baseUrl1));
    if (response.statusCode == 200) {
      List<dynamic> data = json.decode(response.body);
      return data.map((json) => User.fromJson(json)).toList();
    } else {
      throw Exception("Failed to fetch users");
    }
  }

  Future<User> getUserById(int id) async {
    final response = await http.get(Uri.parse('$baseUrl2/$id'));
    if (response.statusCode == 200) {
      return User.fromJson(json.decode(response.body));
    } else {
      throw Exception("Failed to fetch user by id");
    }
  }

  Future<void> createUser(User user) async {
    final response = await http.post(
      Uri.parse(baseUrl2),
      headers: {'Content-Type': 'application/json'},
      body: json.encode(user.toJson()),
    );
    if (response.statusCode != 201) {
      throw Exception("Failed to create user");
    }
  }

  Future<void> updateUserById(int id, User user) async {
    final response = await http.put(
      Uri.parse('$baseUrl2/$id'),
      headers: {'Content-Type': 'application/json'},
      body: json.encode(user.toJson()),
    );
    if (response.statusCode != 200) {
      throw Exception("Failed to update user");
    }
  }

  Future<void> deleteUserById(int id) async {
    final response = await http.delete(Uri.parse('$baseUrl2/$id'));
    if (response.statusCode != 204) {
      throw Exception("Failed to delete user");
    }
  }
}
