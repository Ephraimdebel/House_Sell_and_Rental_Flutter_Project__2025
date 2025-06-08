import 'package:dio/dio.dart';
import '../../domain/repositories/edit_property_repository.dart';
import '../datasources/edit_property_remote_datasource.dart';

class EditPropertyRepositoryImpl implements EditPropertyRepository {
  final EditPropertyRemoteDataSource remoteDataSource;

  EditPropertyRepositoryImpl(this.remoteDataSource);

  @override
  Future<void> updateProperty(String id, FormData formData) {
    return remoteDataSource.updateProperty(id, formData);
  }
}
