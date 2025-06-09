import 'package:dio/dio.dart';
import 'package:house_rental_flutter/src/features/admin_dashboard/data/models/house_model.dart';


class HouseRemoteDataSource {
  final Dio dio;

  HouseRemoteDataSource(this.dio);

  Future<List<HouseModel>> fetchHousesByType(int typeId) async {
    final response = await dio.get('/listings?type=$typeId');
    final data = response.data['houses'] as List;
    return data.map((json) => HouseModel.fromJson(json)).toList();
  }
}
