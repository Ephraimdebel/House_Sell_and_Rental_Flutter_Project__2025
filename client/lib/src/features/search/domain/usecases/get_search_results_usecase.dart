import '../entities/search_result.dart';
import '../repositories/search_repository.dart';

class GetSearchResultsUseCase {
  final SearchRepository repository;

  GetSearchResultsUseCase(this.repository);

  Future<List<SearchResult>> call(String city) {
    return repository.getSearchResults(city);
  }
}
