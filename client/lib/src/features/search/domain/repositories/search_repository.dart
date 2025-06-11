import '../entities/search_result.dart';

abstract class SearchRepository {
  Future<List<SearchResult>> getSearchResults(String city);
}
