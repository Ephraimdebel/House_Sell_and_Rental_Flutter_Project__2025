import 'package:dio/dio.dart';

class AddPropertyRemoteDataSource {
  final Dio dio;

  AddPropertyRemoteDataSource(this.dio);

  Future<void> addProperty(FormData formData) async {
    await dio.post("/addHouse", data: formData);
  }
}
