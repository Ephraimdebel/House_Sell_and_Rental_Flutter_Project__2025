import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'src/features/home/presentation/pages/home_page.dart';
import 'src/features/login/presentation/pages/login_page.dart';
import 'src/features/signup/presentation/pages/signup_page.dart';

void main() {
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    // return MaterialApp(
    //   title: 'House Listing App',
    //   theme: ThemeData(primarySwatch: Colors.blue),
    //   home: const HomePage(),
    // );
    // return MaterialApp(
    //   title: 'House Listing App',
    //   theme: ThemeData(primarySwatch: Colors.blue),
    //   home: LoginPage(),
    // );
    return MaterialApp(
      title: 'House Listing App',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: SignUpPage(),
    );
  }
}
