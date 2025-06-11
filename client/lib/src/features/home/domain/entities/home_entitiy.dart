class Property {
  final int id;
  final String title;
  final String description;
  final String streetAddress;
  final String city;
  final String province;
  final String country;
  final double price;
  final int bedroomCount;
  final int bathroomCount;
  final int area;
  final List<String> listingPhotoPaths;
  final int typeId; // 1 for sale, 2 for rent
  final bool isFeatured;

  Property({
    required this.id,
    required this.title,
    required this.description,
    required this.streetAddress,
    required this.city,
    required this.province,
    required this.country,
    required this.price,
    required this.bedroomCount,
    required this.bathroomCount,
    required this.area,
    required this.listingPhotoPaths,
    required this.typeId,
    required this.isFeatured,
  });
}