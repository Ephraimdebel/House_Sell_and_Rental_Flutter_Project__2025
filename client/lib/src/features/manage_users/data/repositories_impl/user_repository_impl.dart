// repositories_impl.dart
import '../../domain/entities/entities.dart';
import '../../domain/repositories/repositories.dart';
import '../datasources/user_remote_datasource.dart';

class UserRepositoryImpl implements UserRepository {
  final UserRemoteDataSource remote;

  UserRepositoryImpl(this.remote);

  @override
  Future<List<UserEntity>> getAllUsers() => remote.getAllUsers();

  @override
  Future<void> deleteUser(int id) => remote.deleteUser(id);
}
