import 'package:bukulapak/pages/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:bukulapak/pages/home.dart';
import 'package:bukulapak/pages/auth/welcomepage.dart';
import 'package:bukulapak/pages/auth/sign_in_page.dart';
import 'package:bukulapak/pages/auth/sign_up_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        fontFamily: 'poppins', // Set the global font family
      ),
      debugShowCheckedModeBanner: false,
      initialRoute: '/homepage',
      routes: {
        '/splash': (context) => const SplashScreen(),
        '/homepage': (context) => const HomePage(),
        '/welcome': (context) => const WelcomePage(),
        '/sign_in': (context) => const SignInPage(),
        '/sign_up': (context) => const SignUpPage(),
      },
    );
  }
}
