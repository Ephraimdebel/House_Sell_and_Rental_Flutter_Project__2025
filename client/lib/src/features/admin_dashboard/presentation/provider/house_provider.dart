
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:dio/dio.dart';
import 'package:house_rental_flutter/src/features/admin_dashboard/data/datasources/house_remote_datasource.dart';
import 'package:house_rental_flutter/src/features/admin_dashboard/data/repositories_impl/dashborad_repository__impl.dart';
import 'package:house_rental_flutter/src/features/admin_dashboard/domain/repositories/house_repository.dart';
import 'package:house_rental_flutter/src/features/admin_dashboard/domain/usecases/usecases.dart';

final dioProvider = Provider((ref) => Dio(BaseOptions(baseUrl: "http://localhost:5500/api")));

final houseRemoteDataSourceProvider = Provider((ref) => HouseRemoteDataSource(ref.read(dioProvider)));

final houseRepositoryProvider = Provider<HouseRepository>(
  (ref) => HouseRepositoryImpl(ref.read(houseRemoteDataSourceProvider)),
);

final dashboardStatsProvider = FutureProvider((ref) {
  final useCase = GetDashboardStatsUseCase(ref.read(houseRepositoryProvider));
  return useCase();
});
