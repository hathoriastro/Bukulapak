import 'package:bukulapak/pages/splash_screen.dart';
import 'package:bukulapak/pages/user/add_product_page.dart';
import 'package:bukulapak/pages/user/barterin_page.dart';
import 'package:bukulapak/pages/user/home.dart';
import 'package:bukulapak/pages/user/keranjang_page.dart';
import 'package:bukulapak/pages/user/modul_page.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:bukulapak/pages/auth/welcomepage.dart';
import 'package:bukulapak/pages/auth/sign_in_page.dart';
import 'package:bukulapak/pages/auth/sign_up_page.dart';
import 'package:bukulapak/pages/user/category_page.dart';
import 'package:bukulapak/pages/user/profile_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  if (kIsWeb) {
    await Firebase.initializeApp(
      options: const FirebaseOptions(
        apiKey: "API_KEY_DARI_FIREBASE",
        authDomain: "PROJECT_ID.firebaseapp.com",
        projectId: "PROJECT_ID",
        storageBucket: "PROJECT_ID.appspot.com",
        messagingSenderId: "NOMOR_MESSAGING_DARI_FIREBASE",
        appId: "APP_ID_DARI_FIREBASE",
      ),
    );
  } else {
    await Firebase.initializeApp();
  }

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        fontFamily: 'poppins',
      ),
      debugShowCheckedModeBanner: false,
      initialRoute: '/sign_up',
      routes: {
        '/splash': (context) => const SplashScreen(),
        '/welcome': (context) => const WelcomePage(),
        '/sign_in': (context) => const SignInPage(),
        '/sign_up': (context) => const SignUpPage(),
        '/category': (context) => const CategoryPage(),
        '/add_product': (context) => const AddProductPage(),
        '/barterin': (context) => const BarterinPage(),
        '/modulGo': (context) => const ModulPage(),
        '/homepage': (context) => const HomePage(),
        '/keranjangpage': (context) => const KeranjangPage(),
        '/profilepage': (context) => const ProfilePage(),
      },
    );
  }
}
