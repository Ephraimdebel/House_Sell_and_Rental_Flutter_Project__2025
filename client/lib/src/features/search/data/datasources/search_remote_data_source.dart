import 'package:dio/dio.dart';
import '../models/search_model.dart';

class SearchRemoteDataSource {
  final Dio dio;

  SearchRemoteDataSource(this.dio);

  Future<List<SearchModel>> getSearchResults(String city) async {
    final response = await dio.get('/listings', queryParameters: {
      'city': city,
    });

    final data = response.data['houses'] as List;
    print("data-> $data");
    return data.map((json) => SearchModel.fromJson(json)).toList();
  }
}
