// test/unit/favourite/get_favourites_usecase_test.dart

import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:house_rental_flutter/src/features/favourite/domain/usecases/get_favourites_usecase.dart';
import 'package:house_rental_flutter/src/features/favourite/domain/repositories/favourite_repository.dart';

class MockFavouriteRepository extends Mock implements FavouriteRepository {}

void main() {
  late GetFavouritesUseCase useCase;
  late MockFavouriteRepository mockRepo;

  setUp(() {
    mockRepo = MockFavouriteRepository();
    useCase = GetFavouritesUseCase(mockRepo);
  });

  test('should return list of favourites for given user ID', () async {
    const userId = 1; // int, not string

    // Arrange
    when(mockRepo.getFavourites(userId)).thenAnswer((_) async => []);

    // Act
    final result = await useCase(userId); // using `call` method

    // Assert
    expect(result, isA<List>());
    verify(mockRepo.getFavourites(userId)).called(1);
    verifyNoMoreInteractions(mockRepo);
  });
}
