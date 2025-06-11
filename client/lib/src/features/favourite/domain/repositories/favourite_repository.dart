import '../entities/favourite.dart';

abstract class FavouriteRepository {
  Future<List<Favourite>> getFavourites(int userId);
}
