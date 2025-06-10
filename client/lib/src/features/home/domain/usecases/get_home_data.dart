// import '../repositories/home_repository.dart';
// import '../entities/home_entitiy.dart';
// import '../../../../core/errors/failures.dart';
// import '../../../core/usecase/usecase.dart';
// import 'package:dartz/dartz.dart';

// class GetHomeData implements UseCase<HomeEntity, NoParams> {
//   final HomeRepository repository;

//   GetHomeData(this.repository);

//   @override
//   Future<Either<Failure, HomeEntity>> call(NoParams params) async {
//     // Get featured houses from API
//     final housesResult = await repository.getFeaturedHouses();
    
//     return housesResult.fold(
//       (failure) => Left(failure),
//       (houses) {
//         // Combine API data with static UI content from your Figma design
//         return Right(HomeEntity(
//           greeting: 'Hello there',
//           email: '360000m',
//           featuredHouses: houses,
//         ));
//       },
//     );
//   }
// }