import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../data/datasources/user_remote_datasource.dart';
import '../../data/repositories_impl/user_repository_impl.dart';
import '../../application/get_all_users.dart';
import '../../application/delete_users.dart';
import 'package:dio/dio.dart';

final dioProvider = Provider((ref) => Dio(BaseOptions(baseUrl: 'http://your-api-url.com')));

final userRepositoryProvider = Provider((ref) {
  final dio = ref.read(dioProvider);
  return UserRepositoryImpl(UserRemoteDataSource(dio));
});

final getAllUsersProvider = Provider((ref) => GetAllUsers(ref.read(userRepositoryProvider)));
final deleteUserProvider = Provider((ref) => DeleteUser(ref.read(userRepositoryProvider)));

final userListProvider = FutureProvider((ref) async {
  return ref.read(getAllUsersProvider).call();
});
