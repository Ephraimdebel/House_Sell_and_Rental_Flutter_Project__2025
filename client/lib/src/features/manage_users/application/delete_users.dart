import '../domain/repositories/repositories.dart';

class DeleteUser {
  final UserRepository repository;

  DeleteUser(this.repository);

  Future<void> call(int id) => repository.deleteUser(id);
}
