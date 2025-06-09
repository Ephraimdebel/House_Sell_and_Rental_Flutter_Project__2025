import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import '../../presentation/controllers/edit_property_controller.dart';
import '../../domain/entities/editable_property.dart';

class EditPropertyPage extends ConsumerStatefulWidget {
  final int propertyId;

  const EditPropertyPage({super.key, required this.propertyId});

  @override
  ConsumerState<EditPropertyPage> createState() => _EditPropertyPageState();
}

class _EditPropertyPageState extends ConsumerState<EditPropertyPage> {
  final _formKey = GlobalKey<FormState>();

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

  String category = 'House';
  String type = 'For Sale';
  List<int> selectedFacilities = [];
  List<String> imagePaths = [];

  bool isLoading = true;

  final facilities = [
    'WiFi', 'Parking', 'Swimming Pool', 'Gym', 'Air Conditioning', 'Heating',
    'Laundry', 'Security', 'Elevator', 'Balcony', 'Garden', 'Furnished',
    'Pet Friendly', 'Fireplace', 'Dishwasher'
  ];

  final ImagePicker _picker = ImagePicker();

  void pickImages() async {
    final pickedFiles = await _picker.pickMultiImage();
    if (pickedFiles != null) {
      setState(() {
        imagePaths.addAll(pickedFiles.map((file) => file.path));
      });
    }
  }

  void loadPropertyData(EditableProperty data) {
    _titleController.text = data.title;
    _descriptionController.text = data.description;
    _priceController.text = data.price.toString();
    _bedroomController.text = data.bedroomCount.toString();
    _bathroomController.text = data.bathroomCount.toString();
    _areaController.text = data.area.toString();
    _streetController.text = data.streetAddress;
    _cityController.text = data.city;
    _provinceController.text = data.province;
    _countryController.text = data.country;
    category = data.category;
    type = data.type;
    selectedFacilities = data.facilities;
    imagePaths = data.photos;
  }

  void submit() async {
    if (!_formKey.currentState!.validate()) return;

    final updatedProperty = EditableProperty(
      id: widget.propertyId,
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

    final controller = ref.read(editPropertyControllerProvider);
    await controller.updateProperty(widget.propertyId, updatedProperty);

    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Property updated successfully!')),
      );
      Navigator.pop(context);
    }
  }

  @override
  void initState() {
    super.initState();
    _loadProperty();
  }

  Future<void> _loadProperty() async {
    try {
      final controller = ref.read(editPropertyControllerProvider);
      final property = await controller.fetchProperty(widget.propertyId);
      setState(() {
        loadPropertyData(property);
        isLoading = false;
      });
    } catch (e) {
      // Handle error
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
    if (isLoading) {
      return const Scaffold(body: Center(child: CircularProgressIndicator()));
    }

    return Scaffold(
      backgroundColor: const Color(0xFFF7F7F7),
      appBar: AppBar(
        title: const Text(
          'Edit Property',
          style: TextStyle(color: Colors.blue),
        ),
        backgroundColor: Colors.white,
        iconTheme: const IconThemeData(color: Colors.blue),
        elevation: 1,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(8),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: _titleController,
                decoration: _inputDecoration('Title'),
              ),
              const SizedBox(height: 12),
              TextFormField(
                controller: _descriptionController,
                decoration: _inputDecoration('Description'),
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
                children: ['House', 'Apartment', 'Condo', 'Townhouse', 'Villa']
                    .map(
                      (e) => ChoiceChip(
                        label: Text(e),
                        selected: category == e,
                        selectedColor: Colors.blue,
                        onSelected: (_) => setState(() => category = e),
                        backgroundColor: Colors.grey.shade200,
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
              const SizedBox(height: 12),
              Wrap(
                spacing: 8,
                children: ['For Sale', 'For Rent']
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
              const SizedBox(height: 12),
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
                      decoration: _inputDecoration('Bedrooms'),
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
              const SizedBox(height: 20),
              const Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'Location',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                ),
              ),
              const SizedBox(height: 8),
              TextFormField(
                controller: _streetController,
                decoration: _inputDecoration('Street'),
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
                      decoration: _inputDecoration('State'),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 12),
              TextFormField(
                controller: _countryController,
                decoration: _inputDecoration('Country'),
              ),
              const SizedBox(height: 20),
              const Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'Amenities',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                ),
              ),
              const SizedBox(height: 8),
              Wrap(
                spacing: 8,
                children: facilities.asMap().entries.map((entry) {
                  final isSelected = selectedFacilities.contains(entry.key);
                  return FilterChip(
                    label: Text(entry.value),
                    selected: isSelected,
                    selectedColor: Colors.blue.shade300,
                    checkmarkColor: Colors.white,
                    onSelected: (val) {
                      setState(() {
                        if (val) {
                          selectedFacilities.add(entry.key);
                        } else {
                          selectedFacilities.remove(entry.key);
                        }
                      });
                    },
                    backgroundColor: Colors.grey.shade200,
                  );
                }).toList(),
              ),
              const SizedBox(height: 20),
              const Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'Images',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                ),
              ),
              const SizedBox(height: 8),
              ElevatedButton.icon(
                onPressed: pickImages,
                icon: const Icon(Icons.photo),
                label: const Text('Pick Images'),
              ),
              const SizedBox(height: 12),
              Wrap(
                spacing: 8,
                children: imagePaths.map((path) {
                  final displayPath = path.startsWith('http')
                      ? path.replaceFirst('localhost', '10.0.2.2')
                      : path;
                  return ClipRRect(
                    borderRadius: BorderRadius.circular(4),
                    child: path.startsWith('http')
                        ? Image.network(
                            displayPath,
                            width: 100,
                            height: 100,
                            fit: BoxFit.cover,
                          )
                        : Image.file(
                            File(displayPath),
                            width: 100,
                            height: 100,
                            fit: BoxFit.cover,
                          ),
                  );
                }).toList(),
              ),
              const SizedBox(height: 32),
              SizedBox(
                width: double.infinity,
                height: 48,
                child: ElevatedButton(
                  onPressed: submit,
                  child: const Text('Update Property', style: TextStyle(fontSize: 18)),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
