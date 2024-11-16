import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:greentools/crop/application/user_service.dart';
import 'package:greentools/crop/domain/user.dart';
import 'package:greentools/common/utils/local_storage_service.dart';

class TopBar extends StatelessWidget implements PreferredSizeWidget {
  final UserService _userService;
  final LocalStorageService _localStorageService;

  TopBar({Key? key})
      : _userService = UserService(),
        _localStorageService = LocalStorageService(),
        preferredSize = const Size.fromHeight(80.0),
        super(key: key);

  @override
  final Size preferredSize;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<User?>(
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
              "Error loading user data",
              style: TextStyle(color: Colors.white),
            ),
            backgroundColor: const Color(0xFF3A785D),
          );
        } else if (!snapshot.hasData || snapshot.data == null) {
          return AppBar(
            automaticallyImplyLeading: false,
            title: const Text(
              "User not found",
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
                  'Good Day, ${user.name.firstName}!',
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

  Future<User?> _getOrFetchUser() async {
    // Intentar obtener el usuario de la persistencia local
    final userJson = await _localStorageService.getUser();
    if (userJson != null) {
      return User.fromJson(jsonDecode(userJson));
    }

    // Si no hay usuario almacenado, obtenerlo del servicio
    try {
      final user = await _userService.fetchUserById(1);
      if (user != null) {
        // Guardar el usuario en la persistencia local
        await _localStorageService.saveUser(jsonEncode(user.toJson()));
      }
      return user;
    } catch (e) {
      return null;
    }
  }
}