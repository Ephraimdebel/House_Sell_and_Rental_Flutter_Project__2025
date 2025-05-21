import '../entities/property.dart';

abstract class PropertyRepository {
  Future<List<Property>> getAllProperties();
  
}
