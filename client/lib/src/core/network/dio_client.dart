// dio_client.dart
import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final dioClientProvider = Provider<Dio>((ref) {
  final dio = Dio(
    BaseOptions(
      baseUrl: 'http://localhost:5500/api',
      connectTimeout: const Duration(seconds: 1000),
      receiveTimeout: const Duration(seconds: 1000)
    ),
  );
  return dio;
});
