import 'package:house_rental_flutter/src/features/admin_dashboard/domain/entities/dashboard_entities.dart';
import 'package:house_rental_flutter/src/features/admin_dashboard/domain/usecases/usecases.dart';

class DashboardController {
  final GetDashboardStatsUseCase useCase;

  DashboardController(this.useCase);

  Future<DashboardStats> fetchDashboardStats() async {
    final result = await useCase(); // no `.execute()`
    return DashboardStats.fromMap(result); // assuming you're converting it
  }
}
