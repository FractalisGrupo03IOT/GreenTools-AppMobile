import 'package:flutter/material.dart';
import 'package:greentools/common/utils/local_storage_service.dart';

class TopBar extends StatelessWidget implements PreferredSizeWidget {
  final LocalStorageService _localStorageService;

  TopBar({Key? key})
      : _localStorageService = LocalStorageService(),
        preferredSize = const Size.fromHeight(80.0),
        super(key: key);

  @override
  final Size preferredSize;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Map<String, dynamic>?>(
      future: _getUserFromLocalStorage(),
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
                  backgroundImage: AssetImage('assets/Logo-greentools-inicio.png'),
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

  Future<Map<String, dynamic>?> _getUserFromLocalStorage() async {
    try {
      return await _localStorageService.getUser();
    } catch (e) {
      print("Error retrieving user from LocalStorageService: $e");
      return null;
    }
  }
}

