import '../domain/entities/property.dart';
import '../domain/repositories/property_repository.dart';

class PropertyService {
  final PropertyRepository repository;

  PropertyService(this.repository);

  Future<List<Property>> getAllProperties() {
    return repository.getAllProperties();
  }
  Future<void> deleteProperty(String id) {
      return repository.deleteProperty(id);
    }
  
}
