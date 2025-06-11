class SearchResult {
  final int id;
  final String title;
  final String city;
  final String country;
  final int bedroomCount;
  final int bathroomCount;
  final double area;
  final double price;
  final List<String> photos;

  SearchResult({
    required this.id,
    required this.title,
    required this.city,
    required this.country,
    required this.bedroomCount,
    required this.bathroomCount,
    required this.area,
    required this.price,
    required this.photos,
  });
}
