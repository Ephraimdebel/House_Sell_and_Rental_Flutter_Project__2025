import '../entities/house_entity.dart';

abstract class HouseRepository {
  Future<List<HouseEntity>> getHousesByType(int typeId);
}


