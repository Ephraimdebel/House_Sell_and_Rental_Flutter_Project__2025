import 'package:dio/dio.dart';
import '../models/property_model.dart';

class PropertyRemoteDataSource {
  final Dio dio;

  PropertyRemoteDataSource(this.dio);

  Future<List<PropertyModel>> fetchProperties() async {
    final response = await dio.get('http://10.0.2.2:5500/api/house');
    final List data = response.data['data'];
    return data.map((json) => PropertyModel.fromJson(json)).toList();
  }
  
}
