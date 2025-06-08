import 'package:dio/dio.dart';

class EditPropertyRemoteDataSource {
  final Dio dio;

  EditPropertyRemoteDataSource(this.dio);

  Future<void> updateProperty(String id, FormData formData) async {
    await dio.put("http://localhost:5500/api/listings/$id", data: formData);
  }
}
