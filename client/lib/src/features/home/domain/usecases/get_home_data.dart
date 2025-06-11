

import 'package:house_rental_flutter/src/features/home/domain/entities/home_entitiy.dart';
import 'package:house_rental_flutter/src/features/home/domain/repositories/home_repository.dart';

class GetProperties {
  final PropertyRepository repository;

  GetProperties({required this.repository});

  Future<List<Property>> call() async {
    return await repository.getProperties();
  }
}