import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:house_rental_flutter/src/features/home/presentation/providers/home_providers.dart';
import 'package:house_rental_flutter/src/features/home/presentation/widgets/featured_properties.dart';
import '../widgets/property_list.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final propertiesAsync = ref.watch(propertiesProvider);

    return Scaffold(
      backgroundColor: Color(0xFFF7F7F7),
      appBar: AppBar(
        title: const Text('Home',style: TextStyle(color: Colors.blue),),
        centerTitle: false,
        backgroundColor: Colors.white,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 20),
                const Text(
                  'Hello there',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const Text(
                  'Find your perfect home',
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.grey,
                  ),
                ),
                const SizedBox(height: 20),
                propertiesAsync.when(
                  loading: () => const Center(child: CircularProgressIndicator()),
                  error: (error, stack) => Center(child: Text('Error: $error')),
                  data: (properties) {
                    final forSaleProperties = properties.where((p) => p.typeId == 1).toList();
                    final forRentProperties = properties.where((p) => p.typeId == 2).toList();
                    final featuredProperties = forRentProperties + forSaleProperties;


                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // ✅ Featured Properties Horizontal Scroll
                        if (featuredProperties.isNotEmpty) ...[
                          const Text(
                            'Featured Properties',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 10),
                          SizedBox(
                            height: 350,
                            child: ListView.builder(
                              scrollDirection: Axis.horizontal,
                              itemCount: featuredProperties.length,
                              itemBuilder: (context, index) {
                                final property = featuredProperties[index];
                                return Container(
                                  width: 250,
                                  margin: const EdgeInsets.only(right: 16),
                                  child: FeaturedProperties(properties: featuredProperties),
                                );
                              },
                            ),
                          ),
                          const SizedBox(height: 30),
                        ],

                        // ✅ For Sale Section
                        if (forSaleProperties.isNotEmpty)
                          PropertyListSection(
                            title: 'For Sale',
                            properties: forSaleProperties,
                          ),

                        const SizedBox(height: 30),

                        // ✅ For Rent Section
                        if (forRentProperties.isNotEmpty)
                          PropertyListSection(
                            title: 'For Rent',
                            properties: forRentProperties,
                          ),
                      ],
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
