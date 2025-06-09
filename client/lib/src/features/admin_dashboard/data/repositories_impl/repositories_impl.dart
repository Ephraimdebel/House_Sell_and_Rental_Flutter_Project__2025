// repositories_impl.dart
import '../../domain/entities/house_entity.dart';
import '../../domain/repositories/house_repository.dart';
import '../datasources/house_remote_datasource.dart';

class HouseRepositoryImpl implements HouseRepository {
  final HouseRemoteDatasource remote;

  HouseRepositoryImpl(this.remote);

  @override
  Future<List<HouseEntity>> getListingsByType(int type) {
    return remote.fetchListings(type);
  }
}
