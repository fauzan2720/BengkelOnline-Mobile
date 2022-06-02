import 'package:bengkel_online/pages/add_location.dart';
import 'package:bengkel_online/pages/add_vehicle.dart';
import 'package:bengkel_online/pages/edit_password.dart';
import 'package:bengkel_online/pages/mechanic/home_page.dart';
import 'package:bengkel_online/pages/products.dart';
import 'package:bengkel_online/pages/result_call_mechanic.dart';
import 'package:bengkel_online/pages/edit_profile.dart';
import 'package:bengkel_online/pages/home/call_mechanic_page.dart';
import 'package:bengkel_online/pages/home/main_page.dart';
import 'package:bengkel_online/pages/location.dart';
import 'package:bengkel_online/pages/login.dart';
import 'package:bengkel_online/pages/pin_confirmation.dart';
import 'package:bengkel_online/pages/register.dart';
import 'package:bengkel_online/pages/splash_screen.dart';
import 'package:bengkel_online/pages/vehicles.dart';
import 'package:bengkel_online/providers/auth_provider.dart';
import 'package:bengkel_online/providers/call_mechanic_provider.dart';
import 'package:bengkel_online/providers/location_provider.dart';
import 'package:bengkel_online/providers/product_provider.dart';
import 'package:bengkel_online/providers/transaction_provider.dart';
import 'package:bengkel_online/providers/vehicle_provider.dart';
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
        ),
        ChangeNotifierProvider(
          create: (context) => VehicleProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => LocationProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => CallMechanicProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => TransactionProvider(),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: const SplashScreenPage(),
        routes: {
          'login': (context) => const LoginPage(),
          'registrasi': (context) => const RegisterPage(),
          'home': (context) => const MainPage(),
          'call': (context) => const CallMechanicPage(),
          'call-mechanic': (context) => const CallMechanic(),
          'confirm': (context) => const PinConfirmation(),
          'edit-profile': (context) => const EditProfilePage(),
          'edit-password': (context) => const EditPasswordPage(),
          'vehicle': (context) => const VehiclePage(),
          'add-vehicle': (context) => const AddVehicle(),
          'location': (context) => const LocationPage(),
          'add-location': (context) => const AddLocation(),
          'products': (context) => const ProductsPage(),

          // halaman mekanik
          'mechanic-home': (context) => const MechanicHomePage(),
        },
      ),
    );
  }
}
