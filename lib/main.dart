import 'package:bukulapak/pages/splash_screen.dart';
import 'package:bukulapak/pages/user/home.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:bukulapak/pages/auth/welcomepage.dart';
import 'package:bukulapak/pages/auth/sign_in_page.dart';
import 'package:bukulapak/pages/auth/sign_up_page.dart';
import 'package:bukulapak/pages/user/category_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
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
      initialRoute: '/home',
      routes: {
        '/splash': (context) => const SplashScreen(),
        '/welcome': (context) => const WelcomePage(),
        '/sign_in': (context) => const SignInPage(),
        '/sign_up': (context) => const SignUpPage(),
        '/category': (context) => const CategoryPage(),
        '/home' : (context) => const HomePage()
      },
    );
  }
}
