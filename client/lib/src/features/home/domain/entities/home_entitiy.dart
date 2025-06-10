class HomeEntity {
  final String greeting;
  final String email;
  final List<HouseEntity> featuredHouses;

  const HomeEntity({
    required this.greeting,
    required this.email,
    required this.featuredHouses,
  });
}

class HouseEntity {
  final int id;
  final String title;
  final String city;
  final String price;
  final List<String> images;

  const HouseEntity({
    required this.id,
    required this.title,
    required this.city,
    required this.price,
    required this.images,
  });
}
