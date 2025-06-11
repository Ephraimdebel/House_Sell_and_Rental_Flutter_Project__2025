
import 'package:house_rental_flutter/src/features/home/domain/entities/home_entitiy.dart';

abstract class PropertyRepository {
  Future<List<Property>> getProperties();
  Future<List<Property>> getFeaturedProperties();
}