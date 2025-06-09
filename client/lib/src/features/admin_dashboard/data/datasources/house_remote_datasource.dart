// datasources.dart
import 'package:dio/dio.dart';
import '../models/house_model.dart';

class HouseRemoteDatasource {
  final Dio dio;
  HouseRemoteDatasource(this.dio);

  Future<List<HouseModel>> fetchListings(int type) async {
    final response = await dio.get('/listings', queryParameters: {'type': type});
    final data = response.data['houses'] as List;
    return data.map((e) => HouseModel.fromJson(e)).toList();
  }
}
