import 'package:bengkel_online/pages/add_location.dart';
import 'package:bengkel_online/pages/add_vehicle.dart';
import 'package:bengkel_online/pages/call_mechanic.dart';
import 'package:bengkel_online/pages/edit_profile.dart';
import 'package:bengkel_online/pages/home/main_page.dart';
import 'package:bengkel_online/pages/location.dart';
import 'package:bengkel_online/pages/login.dart';
import 'package:bengkel_online/pages/pin_confirmation.dart';
import 'package:bengkel_online/pages/register.dart';
import 'package:bengkel_online/pages/splash_screen.dart';
import 'package:bengkel_online/pages/vehicles.dart';
import 'package:bengkel_online/providers/auth_provider.dart';
import 'package:bengkel_online/providers/product_provider.dart';
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
        ChangeNotifierProvider(
          create: (context) => ProductProvider(),
        )
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: const SplashScreenPage(),
        routes: {
          'login': (context) => const LoginPage(),
          'registrasi': (context) => const RegisterPage(),
          'home': (context) => const MainPage(),
          'call-mechanic': (context) => const CallMechanic(),
          'confirm': (context) => const PinConfirmation(),
          'edit-profile': (context) => const EditProfilePage(),
          'vehicle': (context) => const VehiclePage(),
          'add-vehicle': (context) => const AddVehicle(),
          'location': (context) => const LocationPage(),
          'add-location': (context) => const AddLocation(),
        },
      ),
    );
  }
}

class Palette {
  static String baseUrl = 'http://127.0.0.1:8000/api';
}
