import '../entities/favourite.dart';
import '../repositories/favourite_repository.dart';

class GetFavouritesUseCase {
  final FavouriteRepository repository;

  GetFavouritesUseCase(this.repository);

  Future<List<Favourite>> call(int userId) {
    return repository.getFavourites(userId);
  }
}
