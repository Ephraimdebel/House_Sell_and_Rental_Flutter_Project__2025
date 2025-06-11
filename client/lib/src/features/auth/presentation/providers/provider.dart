import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:house_rental_flutter/src/features/auth/data/datasources/auth_local_data_source.dart';

final secureStorageProvider = Provider((ref) => const FlutterSecureStorage());

final authLocalDataSourceProvider = Provider<AuthLocalDataSource>((ref) {
  return AuthLocalDataSourceImpl(ref.read(secureStorageProvider));
});
