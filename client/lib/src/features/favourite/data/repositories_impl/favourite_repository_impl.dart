import '../../domain/entities/favourite.dart';
import '../../domain/repositories/favourite_repository.dart';
import '../datasources/favourite_remote_datasource.dart';

class FavouriteRepositoryImpl implements FavouriteRepository {
  final FavouriteRemoteDataSource remoteDataSource;

  FavouriteRepositoryImpl(this.remoteDataSource);

  @override
  Future<List<Favourite>> getFavourites(int userId) {
    return remoteDataSource.getFavourites(userId);
  }
}
