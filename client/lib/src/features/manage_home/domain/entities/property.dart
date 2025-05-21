class Property {
  final int id;
  final String title;
  final String city;
  final String country;
  final String price;
  final String type; // "For sale" or "For rent"
  final bool isFeatured;
  final String imageUrl;

  Property({
    required this.id,
    required this.title,
    required this.city,
    required this.country,
    required this.price,
    required this.type,
    required this.isFeatured,
    required this.imageUrl,
  });
}
