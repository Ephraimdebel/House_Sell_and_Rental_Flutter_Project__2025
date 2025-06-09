import 'package:house_rental_flutter/src/features/admin_dashboard/domain/entities/dashboard_entities.dart';

import '../../domain/entities/house_entity.dart';

class DashboardModel extends DashboardStats {
  DashboardModel({
    required super.totalProperties,
    required super.forSale,
    required super.forRent,
    // required super.featured, // Removed or rename to match the actual parameter in DashboardStats
    required super.totalSaleValue,
    required super.monthlyRentalIncome,
  });

  factory DashboardModel.fromJson(Map<String, dynamic> json) {
    return DashboardModel(
      totalProperties: json['totalProperties'],
      forSale: json['forSale'],
      forRent: json['forRent'],
      // featured: json['featured'],
      totalSaleValue: double.parse(json['totalSaleValue']),
      monthlyRentalIncome: double.parse(json['monthlyRentalIncome']),
    );
  }
}
