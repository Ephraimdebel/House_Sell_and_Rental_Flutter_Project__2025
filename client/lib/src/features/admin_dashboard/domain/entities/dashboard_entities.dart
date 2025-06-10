class DashboardStats {
  final int totalProperties;
  final int forSale;
  final int forRent;
  final double totalSaleValue;
  final double monthlyRentalIncome;

  DashboardStats({
    required this.totalProperties,
    required this.forSale,
    required this.forRent,
    required this.totalSaleValue,
    required this.monthlyRentalIncome,
  });

  factory DashboardStats.fromMap(Map<String, dynamic> map) {
    return DashboardStats(
      totalProperties: map['total'] ?? 0,
      forSale: map['forSale'] ?? 0,
      forRent: map['forRent'] ?? 0,
      totalSaleValue: map['saleValue']?.toDouble() ?? 0.0,
      monthlyRentalIncome: map['rentValue']?.toDouble() ?? 0.0,
    );
  }
}
