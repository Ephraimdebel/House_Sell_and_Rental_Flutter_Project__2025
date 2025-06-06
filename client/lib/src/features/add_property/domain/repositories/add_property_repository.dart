import 'package:dio/dio.dart';

abstract class AddPropertyRepository {
  Future<void> addProperty(FormData formData);
}
