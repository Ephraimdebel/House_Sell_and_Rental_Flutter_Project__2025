import 'package:dio/dio.dart';

abstract class EditPropertyRepository {
  Future<void> updateProperty(String id, FormData formData);
}
