

import 'package:dio/dio.dart';
import 'package:house_rental_flutter/src/core/exceptions/exceptions.dart';
import 'package:house_rental_flutter/src/features/home/data/models/house_model.dart';
import 'package:house_rental_flutter/src/features/home/domain/entities/home_entitiy.dart';

abstract class PropertyRemoteDataSource {
  Future<List<Property>> getProperties();
}

class PropertyRemoteDataSourceImpl implements PropertyRemoteDataSource {
  final Dio dio;

  PropertyRemoteDataSourceImpl({required this.dio});

  @override
  Future<List<Property>> getProperties() async {
    try {
      final response = await dio.get('/house');
      final data = response.data['data'] as List;
      return data.map((property) => PropertyModel.fromJson(property)).toList();
    } on DioException catch (e) {
      throw ServerException(message: e.message ?? 'Failed to fetch properties');
    }
  }
}