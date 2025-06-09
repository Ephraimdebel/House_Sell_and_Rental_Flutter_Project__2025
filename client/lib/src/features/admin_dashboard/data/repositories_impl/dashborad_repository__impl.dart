

import 'package:house_rental_flutter/src/features/admin_dashboard/data/datasources/house_remote_datasource.dart';
import 'package:house_rental_flutter/src/features/admin_dashboard/domain/entities/house_entity.dart';
import 'package:house_rental_flutter/src/features/admin_dashboard/domain/repositories/house_repository.dart';

class HouseRepositoryImpl implements HouseRepository {
  final HouseRemoteDataSource remoteDataSource;

  HouseRepositoryImpl(this.remoteDataSource);

  @override
  Future<List<HouseEntity>> getHousesByType(int typeId) async {
    final models = await remoteDataSource.fetchHousesByType(typeId);
    return models.map((m) => HouseEntity(id: m.id, typeId: m.typeId, title: m.title, price: m.price)).toList();
  }
}
