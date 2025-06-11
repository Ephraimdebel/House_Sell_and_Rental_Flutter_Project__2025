class Favourite {
  final int id;
  final String title;
  final String description;
  final String country;
  final String city;
  final String streetAddress;
  final int bedroomCount;
  final int bathroomCount;
  final int area;
  final String price;
  final List<String> photos;

  Favourite({
    required this.id,
    required this.title,
    required this.description,
    required this.country,
    required this.city,
    required this.streetAddress,
    required this.bedroomCount,
    required this.bathroomCount,
    required this.area,
    required this.price,
    required this.photos,
  });
}
