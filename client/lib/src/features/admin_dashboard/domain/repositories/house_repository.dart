// repositories.dart
import 'package:house_rental_flutter/src/features/admin_dashboard/domain/entities/house_entity.dart';

abstract class HouseRepository {
  Future<List<HouseEntity>> getListingsByType(int type);
}
