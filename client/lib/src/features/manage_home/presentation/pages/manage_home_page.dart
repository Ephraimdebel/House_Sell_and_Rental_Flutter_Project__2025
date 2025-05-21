import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../providers/property_provider.dart';
import '../widgets/property_card.dart';

class ManageHomePage extends ConsumerStatefulWidget {
  const ManageHomePage({super.key});

  @override
  ConsumerState<ManageHomePage> createState() => _ManageHomePageState();
}

class _ManageHomePageState extends ConsumerState<ManageHomePage> {
  String filter = 'All';
  String searchQuery = '';

  @override
  Widget build(BuildContext context) {
    final propertyAsync = ref.watch(propertyProvider);

    return Scaffold(
      backgroundColor: const Color(0xFFF7F7F7),
      appBar: AppBar(
        title: const Text(
          "Manage Properties",
          style: TextStyle(color: Colors.blue),
        ),
        leading: const BackButton(color: Colors.blue),
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: propertyAsync.when(
        data: (properties) {
          final filtered = properties.where((prop) {
            final matchesFilter = filter == 'All' || prop.type.toLowerCase() == filter.toLowerCase();
            final matchesSearch = prop.title.toLowerCase().contains(searchQuery.toLowerCase());
            return matchesFilter && matchesSearch;
          }).toList();

          return Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // 🔍 Search Bar
                TextField(
                  onChanged: (value) => setState(() => searchQuery = value),
                  decoration: InputDecoration(
                    hintText: 'Search properties...',
                    prefixIcon: const Icon(Icons.search),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    contentPadding: const EdgeInsets.symmetric(horizontal: 12),
                  ),
                ),
                const SizedBox(height: 12),

                // 🟦 Filter Buttons
                Row(
                children: ['All', 'For sale', 'For rent'].map((label) {
                    final isSelected = filter == label;
                    return Padding(
                    padding: const EdgeInsets.only(right: 8),
                    child: ChoiceChip(
                        label: Text(label),
                        selected: isSelected,
                        onSelected: (_) => setState(() => filter = label),
                        selectedColor: Colors.blue,
                        backgroundColor: const Color(0xFFF7F7F7), // background for unselected
                        labelStyle: TextStyle(
                        color: isSelected ? Colors.white : Colors.black,
                        ),
                    ),
                    );
                }).toList(),
                ),

                const SizedBox(height: 16),

                // 🏘️ Property List
                Expanded(
                  child: filtered.isEmpty
                      ? const Center(child: Text("No properties found"))
                      : ListView.builder(
                          itemCount: filtered.length,
                          itemBuilder: (context, index) {
                            final property = filtered[index];
                            return PropertyCard(
                              property: property,
                              onEdit: () {
                                // TODO: Navigate to edit screen
                              },
                              onDelete: () {
                                // TODO: Handle delete
                              },
                            );
                          },
                        ),
                ),
              ],
            ),
          );
        },
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (e, _) => Center(child: Text('Error: $e')),
      ),
    );
  }
}
