import 'package:dio/dio.dart';
import '../../domain/repositories/add_property_repository.dart';
import '../datasources/add_property_remote_datasource.dart';
import '../../application/add_property_service.dart';

class AddPropertyRepositoryImpl implements AddPropertyRepository {
  final AddPropertyRemoteDataSource remoteDataSource;

  AddPropertyRepositoryImpl(this.remoteDataSource);

  @override
  Future<void> addProperty(FormData formData) {
    return remoteDataSource.addProperty(formData);
  }
}
