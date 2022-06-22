import 'package:bengkel_online/providers/product_provider.dart';
import 'package:bengkel_online/util/themes.dart';
import 'package:bengkel_online/widgets/loading_light_button.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SplashScreenPage extends StatefulWidget {
  const SplashScreenPage({Key? key}) : super(key: key);

  @override
  State<SplashScreenPage> createState() => _SplashScreenPageState();
}

class _SplashScreenPageState extends State<SplashScreenPage> {
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    getInit() async {
      setState(() {
        isLoading = true;
      });

      await Provider.of<ProductProvider>(context, listen: false).getProducts();
      await Provider.of<ProductProvider>(context, listen: false)
          .getProductOils();

      Navigator.pushNamed(context, 'login');

      setState(() {
        isLoading = false;
      });
    }

    return Scaffold(
      backgroundColor: primaryColor,
      body: Stack(
        children: [
          Image.asset(
            'assets/img/bg_splashscreen.png',
            width: double.infinity,
            fit: BoxFit.fill,
          ),
          SingleChildScrollView(
            child: Column(
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
                    'Rasakan berbagai fitur yang memberi kemudahan layanan servis tanpa harus pergi ke Bengkel. Mekanik profesional dan Bengkel Resmi.',
                    overflow: TextOverflow.clip,
                    textAlign: TextAlign.center,
                    style: poppinsTextStyle.copyWith(
                      color: Colors.white,
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                isLoading
                    ? const LoadingLightButton()
                    : Container(
                        width: 190,
                        height: 40,
                        decoration: BoxDecoration(
                          borderRadius: const BorderRadius.all(
                            Radius.circular(10),
                          ),
                          color: whiteColor,
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
                          onPressed: getInit,
                          child: Text(
                            'Mulai',
                            style: poppinsTextStyle.copyWith(
                              fontWeight: bold,
                              color: primaryColor,
                            ),
                          ),
                        ),
                      ),
                const SizedBox(height: 100),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
