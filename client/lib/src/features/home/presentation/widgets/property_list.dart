import 'package:flutter/material.dart';
import 'package:house_rental_flutter/src/features/home/domain/entities/home_entitiy.dart';
import 'package:intl/intl.dart';


class PropertyListSection extends StatelessWidget {
  final String title;
  final List<Property> properties;

  const PropertyListSection({
    super.key,
    required this.title,
    required this.properties,
  });

  @override
  Widget build(BuildContext context) {
    if (properties.isEmpty) return const SizedBox();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Section title + View All
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              title,
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            TextButton(
              onPressed: () {},
              child: const Text('View All >'),
            ),
          ],
        ),
        const SizedBox(height: 10),

        // Horizontal List of Property Tiles
        SizedBox(
          height: 150, // Control height here
          child: ListView.separated(
            scrollDirection: Axis.horizontal,
            itemCount: properties.length,
            separatorBuilder: (_, __) => const SizedBox(width: 12),
            itemBuilder: (context, index) {
              return SizedBox(
                width: MediaQuery.of(context).size.width * 1, // Make tile almost full width
                child: PropertyTile(property: properties[index]),
              );
            },
          ),
        ),
      ],
    );
  }
}


class PropertyTile extends StatelessWidget {
  final Property property;
  final NumberFormat _priceFormat = NumberFormat('#,##0');

  PropertyTile({super.key, required this.property});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      child: Padding(
        padding: const EdgeInsets.all(8),
        child: Row(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: SizedBox(
                width: 120,
                height: 120,
                child: Image.network(
                  property.listingPhotoPaths.isNotEmpty
                      ? property.listingPhotoPaths.first
                      : 'https://via.placeholder.com/250x150',
                  fit: BoxFit.cover,
                ),
              ),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'ETB ${_priceFormat.format(property.price)}',
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 14,
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    property.title,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(fontSize: 13),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    '${property.streetAddress}, ${property.city}',
                    style: const TextStyle(fontSize: 12, color: Colors.grey),
                  ),
                  const SizedBox(height: 6),
                  Row(
                    children: [
                      _buildFeatureItem(Icons.king_bed, '${property.bedroomCount}'),
                      const SizedBox(width: 8),
                      _buildFeatureItem(Icons.bathtub, '${property.bathroomCount}'),
                      const SizedBox(width: 8),
                      _buildFeatureItem(Icons.square_foot, '${property.area}ft²'),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFeatureItem(IconData icon, String text) {
    return Row(
      children: [
        Icon(icon, size: 14, color: Colors.grey[600]),
        const SizedBox(width: 2),
        Text(
          text,
          style: TextStyle(fontSize: 11, color: Colors.grey[600]),
        ),
      ],
    );
  }
}

