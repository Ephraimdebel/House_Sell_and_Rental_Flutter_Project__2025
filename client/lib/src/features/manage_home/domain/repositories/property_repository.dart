import '../entities/property.dart';

abstract class PropertyRepository {
  Future<List<Property>> getAllProperties();
  Future<void> deleteProperty(String id);
 Future<Property> getPropertyById(String id);
}
