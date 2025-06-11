// lib/features/auth/providers/auth_providers.dart
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:house_rental_flutter/src/features/auth/application/auth_notifier.dart';
import 'package:house_rental_flutter/src/features/auth/application/auth_state.dart';
import 'package:house_rental_flutter/src/features/auth/data/datasources/auth_local_data_source.dart';

// 1. Provide the storage
final secureStorageProvider = Provider((ref) => const FlutterSecureStorage());

// 2. Provide the local data source
final authLocalDataSourceProvider = Provider<AuthLocalDataSource>((ref) {
  return AuthLocalDataSourceImpl(ref.read(secureStorageProvider));
});

// ✅ 3. Provide the AuthNotifier (this is your main question)
final authNotifierProvider =
    StateNotifierProvider<AuthNotifier, AuthState>((ref) {
  final local = ref.read(authLocalDataSourceProvider);
  return AuthNotifier(local);
});
