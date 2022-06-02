import 'package:bengkel_online/models/user_model.dart';
import 'package:bengkel_online/providers/auth_provider.dart';
import 'package:bengkel_online/providers/product_provider.dart';
import 'package:bengkel_online/providers/vehicle_provider.dart';
import 'package:bengkel_online/util/themes.dart';
import 'package:bengkel_online/widgets/loading_wdiget.dart';
import 'package:bengkel_online/widgets/product_card.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    AuthProvider authProvider = Provider.of<AuthProvider>(context);
    UserModel user = authProvider.user;
    VehicleProvider vehicleProvider =
        Provider.of<VehicleProvider>(context, listen: false);
    ProductProvider productProvider = Provider.of<ProductProvider>(context);

    handleCallMechanic() async {
      setState(() {
        isLoading = true;
      });

      if (vehicleProvider.vehicles.isEmpty) {
        await vehicleProvider.getVehicles(
          authProvider.user.token.toString(),
        );
        Navigator.pushNamed(context, 'vehicle');
      } else {
        Navigator.pushNamed(context, 'vehicle');
      }

      setState(() {
        isLoading = false;
      });
    }

    handleShowProducts() async {
      setState(() {
        isLoading = true;
      });

      if (productProvider.allProduct.isEmpty) {
        await Provider.of<ProductProvider>(context, listen: false)
            .getAllProducts();

        Navigator.pushNamed(context, 'products');
      } else {
        Navigator.pushNamed(context, 'products');
      }

      setState(() {
        isLoading = false;
      });
    }

    Widget fastFeatures(
      String imageUrl,
      String text,
      String textButton,
      void Function()? onPressed,
    ) {
      return Container(
        margin: const EdgeInsets.only(top: 20),
        padding: const EdgeInsets.symmetric(horizontal: 30),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Flexible(
              flex: 1,
              child: Image.asset(
                imageUrl,
                width: double.infinity,
              ),
            ),
            const SizedBox(width: 12),
            Flexible(
              flex: 3,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    text,
                    style: blackTextStyle.copyWith(
                      fontWeight: medium,
                    ),
                    overflow: TextOverflow.clip,
                  ),
                  const SizedBox(height: 12),
                  TextButton(
                    onPressed: onPressed,
                    child: Text(
                      textButton,
                      style: whiteTextStyle.copyWith(
                        fontSize: 12,
                      ),
                    ),
                    style: TextButton.styleFrom(
                      padding: const EdgeInsets.symmetric(
                        vertical: 6,
                        horizontal: 12,
                      ),
                      backgroundColor: primaryColor,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      );
    }

    return isLoading
        ? const LoadingWidget('Mohon ditunggu')
        : Container(
            decoration: BoxDecoration(
              gradient: RadialGradient(
                radius: 20,
                colors: [
                  primaryColor,
                  bgLightColor,
                ],
              ),
            ),
            child: ListView(
              children: [
                // HEADER
                Padding(
                  padding: const EdgeInsets.fromLTRB(30, 30, 30, 0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Flexible(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Hello, ${user.fullname}',
                              style: whiteTextStyle.copyWith(
                                fontWeight: medium,
                                fontSize: 20,
                              ),
                            ),
                            Text(
                              '${user.email}',
                              style: whiteTextStyle.copyWith(
                                fontSize: 16,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Image.network(
                        'https://ui-avatars.com/api/?name=${user.fullname}&color=7F9CF5&background=random&rounded=true&size=60',
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 70),

                // CONTENT
                Container(
                  padding: const EdgeInsets.symmetric(
                    vertical: 40,
                  ),
                  decoration: BoxDecoration(
                    borderRadius: const BorderRadius.vertical(
                      top: Radius.circular(30),
                    ),
                    color: bgLightColor,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // PRODUCT CARD
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 30),
                        child: Text(
                          'Rekomendasi untuk anda',
                          style: blackTextStyle.copyWith(
                            fontWeight: semibold,
                            fontSize: 20,
                          ),
                        ),
                      ),
                      const SizedBox(height: 20),
                      SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Padding(
                          padding: const EdgeInsets.only(left: 30, right: 30),
                          child: Row(
                            children: [
                              Row(
                                children: productProvider.products
                                    .map(
                                      (e) => ProductCard(e),
                                    )
                                    .toList(),
                              ),
                              const SizedBox(width: 18),
                              Center(
                                child: TextButton(
                                  onPressed: handleShowProducts,
                                  child: Text(
                                    'lihat semua',
                                    style: blackTextStyle,
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(height: 22),

                      // IMAGE PROMOSI
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 30),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(12),
                          child: Image.asset(
                            'assets/img/img_promosi.png',
                            width: double.infinity,
                          ),
                        ),
                      ),
                      const SizedBox(height: 30),

                      // KENDARAAN MOGOK?
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 30),
                        child: Text(
                          'Kendaraan Mogok?',
                          style: blackTextStyle.copyWith(
                            fontWeight: semibold,
                            fontSize: 20,
                          ),
                        ),
                      ),
                      fastFeatures(
                        'assets/img/img_default.png',
                        'Panggil Mekanik jika KM anda mencapai 16.058KM',
                        'Panggil Sekarang',
                        handleCallMechanic,
                      ),
                      fastFeatures(
                        'assets/img/img_default.png',
                        'Mogok dan susah cari bengkel? Panggil Mekanik aja',
                        'Panggil Sekarang',
                        handleCallMechanic,
                      ),
                      fastFeatures(
                        'assets/img/img_default.png',
                        'Susah cari sparepart? Cari aja di disini',
                        'Cari Sparepart',
                        handleShowProducts,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
  }
}
