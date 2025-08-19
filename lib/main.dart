import 'package:bukulapak/pages/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:bukulapak/pages/home.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: '/splash',
      routes: {
        '/splash': (context) => const SplashScreen(),
        '/homepage': (context) => const HomePage(),
      },
    );
  }
}
