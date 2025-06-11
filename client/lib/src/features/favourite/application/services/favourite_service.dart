import '../../domain/usecases/get_favourites_usecase.dart';

class FavouriteService {
  final GetFavouritesUseCase useCase;

  FavouriteService(this.useCase);

  Future<List<Favourite>> getFavourites(int userId) {
    return useCase(userId);
  }
}
