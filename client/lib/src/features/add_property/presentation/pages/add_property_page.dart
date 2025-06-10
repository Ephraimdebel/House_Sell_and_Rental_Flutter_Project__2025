// add_property_page.dart
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import '../../domain/entities/new_property.dart';
import '../controllers/add_property_provider.dart';

class AddPropertyPage extends ConsumerStatefulWidget {
  const AddPropertyPage({super.key});

  @override
  ConsumerState<AddPropertyPage> createState() => _AddPropertyPageState();
}

class _AddPropertyPageState extends ConsumerState<AddPropertyPage> {
  final _formKey = GlobalKey<FormState>();

  // Controllers
  final _titleController = TextEditingController();
  final _descriptionController = TextEditingController();
  final _priceController = TextEditingController();
  final _bedroomController = TextEditingController();
  final _bathroomController = TextEditingController();
  final _areaController = TextEditingController();
  final _streetController = TextEditingController();
  final _cityController = TextEditingController();
  final _provinceController = TextEditingController();
  final _countryController = TextEditingController();

  // Selections
  String category = 'House';
  String type = 'For Sale';
  List<int> selectedFacilities = [];
  List<String> imagePaths = [];

  final facilities = [
    'WiFi',
    'Parking',
    'Swimming Pool',
    'Gym',
    'Air Conditioning',
    'Heating',
    'Laundry',
    'Security',
    'Elevator',
    'Balcony',
    'Garden',
    'Furnished',
    'Pet Friendly',
    'Fireplace',
    'Dishwasher',
  ];

  final ImagePicker _picker = ImagePicker();

  void pickImages() async {
    final List<XFile> pickedFiles = await _picker.pickMultiImage();

    if (pickedFiles.isNotEmpty) {
      setState(() {
        imagePaths.addAll(pickedFiles.map((file) => file.path));
      });
    }
  }

  void submit() async {
    if (!_formKey.currentState!.validate()) return;

    final newProperty = NewProperty(
      category: category,
      type: type,
      title: _titleController.text,
      description: _descriptionController.text,
      price: double.parse(_priceController.text),
      bedroomCount: int.parse(_bedroomController.text),
      bathroomCount: int.parse(_bathroomController.text),
      area: double.parse(_areaController.text),
      streetAddress: _streetController.text,
      city: _cityController.text,
      province: _provinceController.text,
      country: _countryController.text,
      facilities: selectedFacilities,
      photos: imagePaths,
    );

    final service = ref.read(addPropertyControllerProvider);
    await service.addProperty(newProperty);

    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Property added successfully!')),
      );
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Add Property')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextFormField(
                controller: _titleController,
                decoration: const InputDecoration(labelText: 'Title'),
                validator:
                    (val) => val == null || val.isEmpty ? 'Required' : null,
              ),
              TextFormField(
                controller: _descriptionController,
                decoration: const InputDecoration(labelText: 'Description'),
                maxLines: 3,
              ),
              const SizedBox(height: 16),
              Wrap(
                spacing: 8,
                children:
                    ['House', 'Apartment', 'Condo', 'Townhouse', 'Villa']
                        .map(
                          (e) => ChoiceChip(
                            label: Text(e),
                            selected: category == e,
                            onSelected: (_) => setState(() => category = e),
                          ),
                        )
                        .toList(),
              ),
              const SizedBox(height: 8),
              Wrap(
                spacing: 8,
                children:
                    ['For Sale', 'For Rent']
                        .map(
                          (e) => ChoiceChip(
                            label: Text(e),
                            selected: type == e,
                            onSelected: (_) => setState(() => type = e),
                          ),
                        )
                        .toList(),
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _priceController,
                decoration: const InputDecoration(labelText: 'Price'),
                keyboardType: TextInputType.number,
              ),
              Row(
                children: [
                  Expanded(
                    child: TextFormField(
                      controller: _bedroomController,
                      decoration: const InputDecoration(labelText: 'Bedrooms'),
                      keyboardType: TextInputType.number,
                    ),
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: TextFormField(
                      controller: _bathroomController,
                      decoration: const InputDecoration(labelText: 'Bathrooms'),
                      keyboardType: TextInputType.number,
                    ),
                  ),
                ],
              ),
              TextFormField(
                controller: _areaController,
                decoration: const InputDecoration(labelText: 'Area (sq ft)'),
                keyboardType: TextInputType.number,
              ),
              const SizedBox(height: 16),
              const Text(
                'Location',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              TextFormField(
                controller: _streetController,
                decoration: const InputDecoration(labelText: 'Street'),
              ),
              Row(
                children: [
                  Expanded(
                    child: TextFormField(
                      controller: _cityController,
                      decoration: const InputDecoration(labelText: 'City'),
                    ),
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: TextFormField(
                      controller: _provinceController,
                      decoration: const InputDecoration(labelText: 'State'),
                    ),
                  ),
                ],
              ),
              TextFormField(
                controller: _countryController,
                decoration: const InputDecoration(labelText: 'Country'),
              ),
              const SizedBox(height: 16),
              const Text('Amenities'),
              Wrap(
                spacing: 8,
                children:
                    facilities
                        .asMap()
                        .entries
                        .map(
                          (entry) => FilterChip(
                            label: Text(entry.value),
                            selected: selectedFacilities.contains(entry.key),
                            onSelected:
                                (val) => setState(() {
                                  if (val) {
                                    selectedFacilities.add(entry.key);
                                  } else {
                                    selectedFacilities.remove(entry.key);
                                  }
                                }),
                          ),
                        )
                        .toList(),
              ),
              const SizedBox(height: 16),
              const Text('Images'),
              ElevatedButton.icon(
                onPressed: pickImages,
                icon: const Icon(Icons.photo_library),
                label: const Text('Pick Images'),
              ),
              Wrap(
                spacing: 8,
                children:
                    imagePaths
                        .map(
                          (path) => Image.file(
                            File(path),
                            height: 100,
                            width: 100,
                            fit: BoxFit.cover,
                          ),
                        )
                        .toList(),
              ),
              const SizedBox(height: 24),
              ElevatedButton(
                onPressed: submit,
                child: const Text('Submit Property'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
