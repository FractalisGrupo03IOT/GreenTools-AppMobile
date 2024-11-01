import 'package:flutter/material.dart';
import 'package:greentools/crop/application/user_service.dart';
import 'package:greentools/crop/domain/user.dart';
import 'package:greentools/crop/infrastructure/user_repository.dart';

class TopBar extends StatelessWidget implements PreferredSizeWidget {
  final UserService _userService;

  TopBar({Key? key})
      : _userService = UserService(), // Inicializa el UserService
        preferredSize = Size.fromHeight(80.0), // Altura de la AppBar
        super(key: key);

  @override
  final Size preferredSize;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<User?>(
      future: _userService.getUserById(1), // Obtiene el usuario por ID
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return AppBar(
            automaticallyImplyLeading: false,
            title: LinearProgressIndicator(color: Colors.white),
            backgroundColor: Color(0xFF3A785D),
          );
        } else if (snapshot.hasError) {
          return AppBar(
            automaticallyImplyLeading: false,
            title: Text("Error loading user data",
                style: TextStyle(color: Colors.white)),
            backgroundColor: Color(0xFF3A785D),
          );
        } else if (!snapshot.hasData || snapshot.data == null) {
          return AppBar(
            automaticallyImplyLeading: false,
            title: Text("User not found",
                style: TextStyle(color: Colors.white)),
            backgroundColor: Color(0xFF3A785D),
          );
        }

        final user = snapshot.data!; // Asegúrate de que user no sea null

        return AppBar(
          automaticallyImplyLeading: false,
          flexibleSpace: Padding(
            padding: EdgeInsets.only(top: 25, left: 25), // Padding superior
            child: Row(
              children: [
                // Logo en la parte izquierda
                CircleAvatar(
                  backgroundImage: AssetImage('assets/Logo-greentools-inicio.png'),
                  radius: 25.0,
                ),
                SizedBox(width: 10),
                // Saludo al usuario
                Text(
                  'Good Day ! , ${user.name.firstName}', // Muestra el firstName
                  style: TextStyle(color: Colors.white, fontSize: 20),
                ),
              ],
            ),
          ),
          actions: [
            Padding(
              padding: EdgeInsets.only(right: 20, top: 25),
              child: IconButton(
                icon: Icon(Icons.notifications),
                color: Colors.white,
                onPressed: () {
                  Navigator.pushNamed(context, 'notification');
                },
              ),
            ),
          ],
          backgroundColor: Color(0xFF3A785D),
        );
      },
    );
  }
}