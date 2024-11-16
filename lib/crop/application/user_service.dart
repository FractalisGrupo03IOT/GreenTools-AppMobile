import 'package:collection/collection.dart';
import 'package:greentools/crop/domain/user.dart';
import 'package:greentools/crop/infrastructure/user_repository.dart';

class UserService {
  final UserRepository repository = UserRepository();

  Future<List<User>> fetchAllUsers() {
    return repository.getAllUsers();
  }

  Future<User> fetchUserById(int id) {
    return repository.getUserById(id);
  }

  Future<void> addUser(User user) {
    return repository.createUser(user);
  }

  Future<void> updateUser(int id, User user) {
    return repository.updateUserById(id, user);
  }

  Future<void> removeUserById(int id) {
    return repository.deleteUserById(id);
  }
}
