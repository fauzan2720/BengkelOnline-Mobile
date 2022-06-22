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

    handleSwipeRefresh() async {
      await Provider.of<ProductProvider>(context, listen: false).getProducts();
      await Provider.of<ProductProvider>(context, listen: false)
          .getProductOils();

      Navigator.pushReplacementNamed(context, 'home');
    }

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
              child: ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: Image.network(
                  imageUrl,
                  width: double.infinity,
                  fit: BoxFit.cover,
                ),
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
        : RefreshIndicator(
            onRefresh: handleSwipeRefresh,
            child: Container(
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
                                        (e) => Hero(
                                          tag: "product",
                                          child: ProductCard(e),
                                        ),
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
                          'http://ae01.alicdn.com/kf/H36b10080f4bc4e4ea59cbec53b7522d5K.jpg',
                          'Panggil Mekanik jika KM anda mencapai 16.058KM',
                          'Panggil Sekarang',
                          handleCallMechanic,
                        ),
                        fastFeatures(
                          'https://www.astramotor-md.co.id/wp-content/uploads/2020/05/WhatsApp-Image-2020-05-13-at-11.39.41-2.jpeg',
                          'Mogok dan susah cari bengkel? Panggil Mekanik aja',
                          'Panggil Sekarang',
                          handleCallMechanic,
                        ),
                        fastFeatures(
                          'https://blue.kumparan.com/image/upload/fl_progressive,fl_lossy,c_fill,q_auto:best,w_640/v1608290419/pw0nfekk2ssnxurv85pz.jpg',
                          'Susah cari sparepart? Cari aja di disini',
                          'Cari Sparepart',
                          handleShowProducts,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
  }
}
