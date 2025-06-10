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
    // Helper method for input decoration with white bg & gray border
  InputDecoration _inputDecoration(String label) {
    return InputDecoration(
      labelText: label,
      filled: true,
      fillColor: Colors.white,
      border: OutlineInputBorder(
        borderSide: const BorderSide(color: Colors.grey),
        borderRadius: BorderRadius.circular(4),
      ),
      enabledBorder: OutlineInputBorder(
        borderSide: const BorderSide(color: Colors.grey),
        borderRadius: BorderRadius.circular(4),
      ),
      focusedBorder: OutlineInputBorder(
        borderSide: const BorderSide(color: Colors.blue),
        borderRadius: BorderRadius.circular(4),
      ),
    );
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF7F7F7),
      appBar: AppBar(title: const Text('Add Property', 
       style: TextStyle(color: Colors.blue),
    ),
        backgroundColor: Colors.white,
        iconTheme: const IconThemeData(color: Colors.blue),
        ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextFormField(
                controller: _titleController,
                decoration:  _inputDecoration('Title'),
              ),
              const SizedBox(height: 12),
              TextFormField(
                controller: _descriptionController,
                decoration:  _inputDecoration('Description'),
                maxLines: 3,
              ),
               const SizedBox(height: 12),
                  const SizedBox(height: 20),
              const Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'property type',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                ),
              ),
              Wrap(
                spacing: 8,
                children:
                    ['House', 'Apartment', 'Condo', 'Townhouse', 'Villa']
                        .map(
                          (e) => ChoiceChip(
                            label: Text(e),
                            selected: category == e,
                            selectedColor: Colors.blue,
                            backgroundColor: Colors.grey.shade200,
                            onSelected: (_) => setState(() => category = e),
                            labelStyle: TextStyle(
                            color: category == e ? Colors.white : Colors.black, // correct this line
                          ),
                          ),
                        )
                        .toList(),
              ),
              const SizedBox(height: 20),
              const Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'listing type',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                ),
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
                            selectedColor: Colors.blue,
                            onSelected: (_) => setState(() => type = e),
                            backgroundColor: Colors.grey.shade200,
                            labelStyle: TextStyle(
                            color: type == e ? Colors.white : Colors.black, // correct this line
                        ),
                          ),
                        )
                        .toList(),
              ),
              const SizedBox(height: 20),
              const Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'Price & Details',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                ),
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _priceController,
                decoration: _inputDecoration('Price'),
                keyboardType: TextInputType.number,
              ),
              const SizedBox(height: 12),
              Row(
                children: [
                  Expanded(
                    child: TextFormField(
                      controller: _bedroomController,
                      decoration:  _inputDecoration('Bedrooms'),
                      keyboardType: TextInputType.number,
                    ),
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: TextFormField(
                      controller: _bathroomController,
                      decoration: _inputDecoration('Bathrooms'),
                      keyboardType: TextInputType.number,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 12),
              TextFormField(
                controller: _areaController,
                decoration: _inputDecoration('Area'),
                keyboardType: TextInputType.number,
              ),
              const SizedBox(height: 16),
              const Text(
                'Location',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              TextFormField(
                controller: _streetController,
                decoration:  _inputDecoration('Street'),
              ),
              const SizedBox(height: 12),
              Row(
                children: [
                  Expanded(
                    child: TextFormField(
                      controller: _cityController,
                      decoration: _inputDecoration('City'),
                    ),
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: TextFormField(
                      controller: _provinceController,
                      decoration:  _inputDecoration('State'),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 12),
              TextFormField(
                controller: _countryController,
                decoration:_inputDecoration('Country'),
              ),
              const SizedBox(height: 16),
              const Text(
                  'Amenities',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                ),
              Wrap(
                spacing: 8,
                children:
                    facilities
                        .asMap()
                        .entries
                        .map(
                          (entry){ 
                           final isSelected = selectedFacilities.contains(entry.key);
                            return FilterChip(
                            label: Text(entry.value),
                            selected: isSelected,
                            selectedColor: Colors.blue,
                            checkmarkColor: Colors.white,
                            onSelected:
                                (val) => setState(() {
                                  if (val) {
                                    selectedFacilities.add(entry.key);
                                  } else {
                                    selectedFacilities.remove(entry.key);
                                  }
                                }),
                              backgroundColor: Colors.grey.shade200,
                              labelStyle: TextStyle(
                              color: isSelected ? Colors.white : Colors.black, // correct this line
                           ),
                          );
                          }
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
              const SizedBox(height: 32),
              SizedBox(
                width: double.infinity,
                height: 48,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      backgroundColor: Color(0xFF5D9DF0),
                      elevation: 0,
                      padding: EdgeInsets.symmetric(vertical: 16),
                    ),
                  onPressed: submit,
                 child: Text(
                      "Add New Property",
                      style: TextStyle(color: Colors.white),
                    ),
                ),
                
              ),
            ],
          ),
        ),
      ),
    );
  }
}
