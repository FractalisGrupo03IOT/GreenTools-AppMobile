import 'package:collection/collection.dart';
import 'package:greentools/crop/domain/user.dart';
import 'package:greentools/crop/infrastructure/user_repository.dart';

class UserService {
  final UserRepository _userRepository = UserRepository(); 

  // Método para obtener todos los usuarios
  Future<List<User>> getAllUsers() async {
    try {
      return await _userRepository.getUsers();
    } catch (e) {
      throw Exception("Error al obtener la lista de usuarios: $e");
    }
  }

  // Método para obtener un usuario por su ID
  Future<User?> getUserById(int id) async {
    try {
      List<User> users = await _userRepository.getUsers();
      return users.firstWhereOrNull((user) => user.id == id);
    } catch (e) {
      throw Exception("Error al obtener el usuario: $e");
    }
  }


  // Método para buscar usuarios por nombre
  Future<List<User>> searchUsersByName(String name) async {
    try {
      List<User> users = await _userRepository.getUsers();
      return users
          .where((user) => user.name.firstName.toLowerCase().contains(name.toLowerCase()) || user.name.lastName.toLowerCase().contains(name.toLowerCase()))
          .toList();
    } catch (e) {
      throw Exception("Error al buscar usuarios por nombre: $e");
    }
  }
  // Método para obtener todos los usuarios del APIFake
  Future<User> getFakeUser() async {
    return await _userRepository.getFakeUser();
  }
}
