// repositories.dart
import '../entities/entities.dart';

abstract class UserRepository {
  Future<List<UserEntity>> getAllUsers();
  Future<void> deleteUser(int id);
}
