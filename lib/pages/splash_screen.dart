import 'package:bengkel_online/providers/product_provider.dart';
import 'package:bengkel_online/theme.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SplashScreenPage extends StatelessWidget {
  const SplashScreenPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: primaryColor,
      body: Stack(
        children: [
          Image.asset(
            'assets/img/bg_splashscreen.png',
            width: double.infinity,
            fit: BoxFit.fill,
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(40, 188, 40, 20),
                child: Image.asset(
                  'assets/img/img_splashscreen.png',
                  width: double.infinity,
                  fit: BoxFit.fill,
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 16),
                child: Text(
                  'Kendaraan Mogok?\nPanggil Mekanik Aja!',
                  textAlign: TextAlign.center,
                  style: poppinsTextStyle.copyWith(
                    fontWeight: bold,
                    fontSize: 20,
                    color: Colors.white,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 48),
                child: Text(
                  'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore.',
                  overflow: TextOverflow.clip,
                  textAlign: TextAlign.center,
                  style: poppinsTextStyle.copyWith(
                    color: Colors.white,
                  ),
                ),
              ),
              const SizedBox(height: 20),
              Container(
                width: 190,
                height: 40,
                decoration: BoxDecoration(
                  borderRadius: const BorderRadius.all(
                    Radius.circular(10),
                  ),
                  gradient: const LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      Color(0xff5879B9),
                      Color(0xff755E88),
                    ],
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.25),
                      spreadRadius: 0,
                      blurRadius: 4,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                margin: const EdgeInsets.only(top: 16),
                child: TextButton(
                  onPressed: () async {
                    await Provider.of<ProductProvider>(context, listen: false)
                        .getProducts();

                    Navigator.pushNamed(context, 'login');
                  },
                  child: Text(
                    'Mulai',
                    style: poppinsTextStyle.copyWith(
                      fontWeight: bold,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 100),
            ],
          ),
        ],
      ),
    );
  }
}
