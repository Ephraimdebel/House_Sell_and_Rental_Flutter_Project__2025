class NewProperty {
  final String category;
  final String type;
  final String title;
  final String description;
  final double price;
  final int bedroomCount;
  final int bathroomCount;
  final double area;
  final String streetAddress;
  final String city;
  final String province;
  final String country;
  final List<int> facilities; // List of facility IDs
  final List<String> photos; // Local paths or URLs

  NewProperty({
    required this.category,
    required this.type,
    required this.title,
    required this.description,
    required this.price,
    required this.bedroomCount,
    required this.bathroomCount,
    required this.area,
    required this.streetAddress,
    required this.city,
    required this.province,
    required this.country,
    required this.facilities,
    required this.photos,
  });
}
