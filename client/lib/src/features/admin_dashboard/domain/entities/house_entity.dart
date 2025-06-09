// entities.dart
class HouseEntity {
  final int id;
  final int typeId;
  final String title;
  final String city;
  final String streetAddress;
  final String price;
  final bool isFeatured;

  HouseEntity({
    required this.id,
    required this.typeId,
    required this.title,
    required this.city,
    required this.streetAddress,
    required this.price,
    required this.isFeatured,
  });
}
