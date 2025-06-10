// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import '../../data/repositories/home_repository_impl.dart';
// import '../../data/data_sources/home_remote_data_source.dart';
// import '../../domain/usecases/get_home_data.dart';
// import '../../domain/repositories/home_repository.dart';
// import '../../domain/entities/home_entitiy.dart';
// import '../../../../core/errors/failures.dart';
// import 'package:dartz/dartz.dart';
// import '../../../../core/network/dio_provider.dart';


// final homeRemoteDataSourceProvider = Provider<HomeRemoteDataSource>((ref) {
//   return HomeRemoteDataSourceImpl(dio: ref.read(dioProvider));
// });

// final homeRepositoryProvider = Provider<HomeRepository>((ref) {
//   return HomeRepositoryImpl(
//     remoteDataSource: ref.read(homeRemoteDataSourceProvider),
//   );
// });

// final getHomeDataProvider = Provider<GetHomeData>((ref) {
//   return GetHomeData(ref.read(homeRepositoryProvider));
// });

// final homeControllerProvider = StateNotifierProvider<HomeController, AsyncValue<HomeEntity>>((ref) {
//   return HomeController(ref.read(getHomeDataProvider));
// });

// class HomeController extends StateNotifier<AsyncValue<HomeEntity>> {
//   final GetHomeData getHomeData;

//   HomeController(this.getHomeData) : super(const AsyncValue.loading()) {
//     fetchHomeData();
//   }

//   Future<void> fetchHomeData() async {
//     state = const AsyncValue.loading();
//     final result = await getHomeData.call(NoParams());
//     state = result.fold(
//       (failure) => AsyncValue.error(failure, StackTrace.current),
//       (data) => AsyncValue.data(data),
//     );
//   }
// }