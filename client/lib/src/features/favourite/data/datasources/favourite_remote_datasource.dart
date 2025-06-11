import 'package:dio/dio.dart';
import '../models/favourite_model.dart';

class FavouriteRemoteDataSource {
  final Dio dio;

  FavouriteRemoteDataSource(this.dio);

  Future<List<FavouriteModel>> getFavourites(int userId) async {
    final response = await dio.get('/favorite/$userId');
    final List<dynamic> data = response.data['favorites'];
    print(response);
    return data.map((json) => FavouriteModel.fromJson(json)).toList();
  }
}
