import '../domain/entities/entities.dart';
import '../domain/repositories/repositories.dart';

class GetAllUsers {
  final UserRepository repository;

  GetAllUsers(this.repository);

  Future<List<UserEntity>> call() => repository.getAllUsers();
}
