import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../favourite/data/datasources/favourite_remote_datasource.dart';
import '../../../favourite/data/repositories_impl/favourite_repository_impl.dart';
import '../../../favourite/domain/usecases/get_favourites_usecase.dart';
import '../../../favourite/domain/entities/favourite.dart';
import '../../../../core/network/dio_client.dart';

final favouriteControllerProvider = FutureProvider.family<List<Favourite>, int>(
  (ref, userId) async {
    final dio = ref.read(dioClientProvider);
    final datasource = FavouriteRemoteDataSource(dio);
    final repository = FavouriteRepositoryImpl(datasource);
    final usecase = GetFavouritesUseCase(repository);
    return usecase(userId);
  },
);
