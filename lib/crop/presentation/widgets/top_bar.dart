import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:greentools/crop/application/user_service.dart';
import 'package:greentools/crop/domain/user.dart';
import 'package:greentools/common/utils/local_storage_service.dart';

class TopBar extends StatelessWidget implements PreferredSizeWidget {
  final LocalStorageService _localStorageService;
  final UserService _userService;

  TopBar({Key? key})
      : _localStorageService = LocalStorageService(),
        _userService = UserService(),
        preferredSize = const Size.fromHeight(80.0),
        super(key: key);

  @override
  final Size preferredSize;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Map<String, dynamic>?>(
      future: _getOrFetchUser(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return AppBar(
            automaticallyImplyLeading: false,
            title: const LinearProgressIndicator(color: Colors.white),
            backgroundColor: const Color(0xFF3A785D),
          );
        } else if (snapshot.hasError) {
          return AppBar(
            automaticallyImplyLeading: false,
            title: const Text(
              "Error loading user",
              style: TextStyle(color: Colors.white),
            ),
            backgroundColor: const Color(0xFF3A785D),
          );
        } else if (!snapshot.hasData || snapshot.data == null) {
          return AppBar(
            automaticallyImplyLeading: false,
            title: const Text(
              "No user found",
              style: TextStyle(color: Colors.white),
            ),
            backgroundColor: const Color(0xFF3A785D),
          );
        }

        final user = snapshot.data!;
        return AppBar(
          automaticallyImplyLeading: false,
          flexibleSpace: Padding(
            padding: const EdgeInsets.only(top: 25, left: 25),
            child: Row(
              children: [
                const CircleAvatar(
                  backgroundImage:
                  AssetImage('assets/Logo-greentools-inicio.png'),
                  radius: 25.0,
                ),
                const SizedBox(width: 10),
                Text(
                  'Hello, ${user['name']['firstName']}!',
                  style: const TextStyle(color: Colors.white, fontSize: 20),
                ),
              ],
            ),
          ),
          actions: [
            Padding(
              padding: const EdgeInsets.only(right: 20, top: 25),
              child: IconButton(
                icon: const Icon(Icons.notifications),
                color: Colors.white,
                onPressed: () {
                  Navigator.pushNamed(context, 'notification');
                },
              ),
            ),
          ],
          backgroundColor: const Color(0xFF3A785D),
        );
      },
    );
  }

  Future<Map<String, dynamic>?> _getOrFetchUser() async {
    // Intentar obtener el usuario desde el almacenamiento local
    final userJson = await _localStorageService.getUser();
    if (userJson != null) {
      return jsonDecode(userJson);
    }

    // Si no hay usuario almacenado, obtenerlo desde el servicio
    try {
      final user = await _userService.fetchUserById(1); // Cambia el ID según sea necesario
      if (user != null) {
        // Guardar el usuario obtenido en el almacenamiento local
        await _localStorageService.saveUser(user.toJson());
        return user.toJson();
      }
    } catch (error) {
      debugPrint("Error fetching user from service: $error");
    }

    return null; // Si no se pudo obtener el usuario, retornar null
  }
}