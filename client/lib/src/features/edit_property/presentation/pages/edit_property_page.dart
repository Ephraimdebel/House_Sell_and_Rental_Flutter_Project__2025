import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';

import '../../domain/entities/new_property.dart';
import '../controllers/edit_property_controller.dart';

class EditPropertyPage extends ConsumerStatefulWidget {
  final NewProperty initialData;
  final String propertyId;

  const EditPropertyPage({
    super.key,
    required this.initialData,
    required this.propertyId,
  });

  @override
  ConsumerState<EditPropertyPage> createState() => _EditPropertyPageState();
}

class _EditPropertyPageState extends ConsumerState<EditPropertyPage> {
  final _formKey = GlobalKey<FormState>();

  late TextEditingController _titleController;
  late TextEditingController _descriptionController;
  late TextEditingController _priceController;
  late TextEditingController _bedroomController;
  late TextEditingController _bathroomController;
  late TextEditingController _areaController;
  late TextEditingController _streetController;
  late TextEditingController _cityController;
  late TextEditingController _provinceController;
  late TextEditingController _countryController;

  String category = 'House';
  String type = 'For Sale';
  List<int> selectedFacilities = [];
  List<String> imagePaths = [];

  final facilities = [
    'WiFi', 'Parking', 'Swimming Pool', 'Gym', 'Air Conditioning', 'Heating',
    'Laundry', 'Security', 'Elevator', 'Balcony', 'Garden', 'Furnished',
    'Pet Friendly', 'Fireplace', 'Dishwasher'
  ];

  final ImagePicker _picker = ImagePicker();

  @override
  void initState() {
    super.initState();
    final p = widget.initialData;
    _titleController = TextEditingController(text: p.title);
    _descriptionController = TextEditingController(text: p.description);
    _priceController = TextEditingController(text: p.price.toString());
    _bedroomController = TextEditingController(text: p.bedroomCount.toString());
    _bathroomController = TextEditingController(text: p.bathroomCount.toString());
    _areaController = TextEditingController(text: p.area.toString());
    _streetController = TextEditingController(text: p.streetAddress);
    _cityController = TextEditingController(text: p.city);
    _provinceController = TextEditingController(text: p.province);
    _countryController = TextEditingController(text: p.country);

    category = p.category;
    type = p.type;
    selectedFacilities = List.from(p.facilities);
    imagePaths = List.from(p.photos);
  }

  void pickImages() async {
    final List<XFile>? pickedFiles = await _picker.pickMultiImage();
    if (pickedFiles != null && pickedFiles.isNotEmpty) {
      setState(() {
        imagePaths.addAll(pickedFiles.map((file) => file.path));
      });
    }
  }

  void submit() async {
    if (!_formKey.currentState!.validate()) return;

    final updatedProperty = NewProperty(
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

    final service = ref.read(editPropertyControllerProvider);
    await service.updateProperty(widget.propertyId, updatedProperty);

    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Property updated successfully!')),
      );
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Edit Property')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              // Same UI fields from AddPropertyPage...
              // With the submit button updated:
              ElevatedButton(
                onPressed: submit,
                child: const Text('Update Property'),
              )
            ],
          ),
        ),
      ),
    );
  }
}
