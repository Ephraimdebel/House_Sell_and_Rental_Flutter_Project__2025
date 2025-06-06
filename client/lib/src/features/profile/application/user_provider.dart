// // features/auth/application/user_provider.dart
// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import '../../../core/utils/storage_service.dart';
// import '../domain/entities/user_entities.dart';

// final userProvider = StateNotifierProvider<UserNotifier, UserEntity?>((ref) {
//   return UserNotifier(StorageService());
// });

// class UserNotifier extends StateNotifier<UserEntity?> {
//   final StorageService storage;

//   UserNotifier(this.storage) : super(null) {
//     loadUser();
//   }

//   Future<void> loadUser() async {
//     final data = await storage.getUser();
//     if (data != null) {
//       state = UserEntity(name: data['name']!, email: data['email']!);
//     }
//   }

//   void logout() async {
//     await storage.clearUser();
//     state = null;
//   }
// }
