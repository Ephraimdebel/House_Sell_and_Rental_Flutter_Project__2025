import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../favourite/presentation/controllers/favorite_provider.dart';
import '../../data/datasources/search_remote_data_source.dart';
import '../../data/repositories_impl/search_repository_impl.dart';
import '../../domain/entities/search_result.dart';
import '../../domain/usecases/get_search_results_usecase.dart';
import '../../../../core/network/dio_client.dart';

final searchControllerProvider = FutureProvider.family<List<SearchResult>, String>((ref, city) async {
  final dio = ref.read(dioClientProvider);
  final datasource = SearchRemoteDataSource(dio);
  final repository = SearchRepositoryImpl(datasource);
  final usecase = GetSearchResultsUseCase(repository);

  return await usecase(city);
});
