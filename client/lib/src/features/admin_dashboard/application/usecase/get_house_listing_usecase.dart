import 'package:house_rental_flutter/src/features/admin_dashboard/domain/repositories/house_repository.dart';

class GetDashboardStatsUseCase {
  final HouseRepository repository;

  GetDashboardStatsUseCase(this.repository);

  Future<Map<String, dynamic>> execute() async {
    final forSale = await repository.getHousesByType(1);
    final forRent = await repository.getHousesByType(2);

    double saleValue = forSale.fold(0.0, (sum, item) => sum + (double.tryParse(item.price) ?? 0.0));
    double rentValue = forRent.fold(0.0, (sum, item) => sum + (double.tryParse(item.price) ?? 0.0));

    return {
      'total': forSale.length + forRent.length,
      'forSale': forSale.length,
      'forRent': forRent.length,
      'saleValue': saleValue,
      'rentValue': rentValue,
    };
  }
}
