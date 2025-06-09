import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/editable_property.dart';
import '../../../../core/network/dio_client.dart';

class EditPropertyRemoteDataSource {
  final Dio dio;

  EditPropertyRemoteDataSource({required this.dio});

  Future<EditablePropertyModel> fetchProperty(int id) async {
    final res = await dio.get('/house/$id');
    print('API GET /house/$id returned: ${res.data}');

    // Your backend returns:
    // { "message": "...", "data": [ {...property data...} ] }
    final dataList = res.data['data'] as List<dynamic>;

    if (dataList.isEmpty) {
      throw Exception('No property data found for id $id');
    }

    final propertyJson = dataList[0] as Map<String, dynamic>;

    return EditablePropertyModel.fromJson(propertyJson);
  }

  Future<void> updateProperty(int id, EditablePropertyModel property) async {
    await dio.patch('/listings/$id', data: property.toJson());
  }
}

final editPropertyRemoteDataSourceProvider = Provider<EditPropertyRemoteDataSource>((ref) {
  final dio = ref.read(dioClientProvider);
  return EditPropertyRemoteDataSource(dio: dio);
});
