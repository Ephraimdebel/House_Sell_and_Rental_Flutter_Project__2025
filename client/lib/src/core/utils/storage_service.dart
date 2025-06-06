
// import 'package:shared_preferences/shared_preferences.dart';

// class StorageService {
//   Future<void> saveUser(String name, String email) async {
//     final prefs = await SharedPreferences.getInstance();
//     await prefs.setString('name', name);
//     await prefs.setString('email', email);
//   }

//   Future<Map<String, String>?> getUser() async {
//     final prefs = await SharedPreferences.getInstance();
//     final name = prefs.getString('name');
//     final email = prefs.getString('email');
//     if (name != null && email != null) {
//       return {'name': name, 'email': email};
//     }
//     return null;
//   }

//   Future<void> clearUser() async {
//     final prefs = await SharedPreferences.getInstance();
//     await prefs.remove('name');
//     await prefs.remove('email');
//   }
// }
