import 'package:dio/dio.dart';
import '../models/user_model.dart';

class UserRemoteDataSource {
  final Dio dio;

  UserRemoteDataSource(this.dio);

  Future<List<UserModel>> getAllUsers() async {
    final response = await dio.get('/users/getAllUsers');
    return (response.data['users'] as List)
        .map((json) => UserModel.fromJson(json))
        .toList();
  }

  Future<void> deleteUser(int id) async {
    await dio.delete('/users/user/$id');
  }
}
