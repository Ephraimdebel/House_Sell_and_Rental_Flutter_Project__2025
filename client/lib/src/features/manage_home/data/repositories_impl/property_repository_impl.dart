import '../../domain/entities/property.dart';
import '../../domain/repositories/property_repository.dart';
import '../datasources/property_remote_datasource.dart';

class PropertyRepositoryImpl implements PropertyRepository {
  final PropertyRemoteDataSource remoteDataSource;

  PropertyRepositoryImpl(this.remoteDataSource);

  @override
  Future<List<Property>> getAllProperties() {
    return remoteDataSource.fetchProperties();
  }
   @override
  Future<void> deleteProperty(String id) {
    return remoteDataSource.deleteProperty(id);
  }
  
}
