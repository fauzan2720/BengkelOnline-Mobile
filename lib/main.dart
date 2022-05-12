import 'package:bengkel_online/pages/home_page.dart';
import 'package:bengkel_online/pages/login.dart';
import 'package:bengkel_online/pages/register.dart';
import 'package:bengkel_online/pages/splash_screen.dart';
import 'package:bengkel_online/providers/auth_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => AuthProvider(),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: const SplashScreenPage(),
        routes: {
          'login': (context) => const LoginPage(),
          'registrasi': (context) => const RegisterPage(),
          'home': (context) => const HomePage(),
        },
      ),
    );
  }
}

class Palette {
  static String baseUrl = 'http://bengkel-online.test/api';
}
