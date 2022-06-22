import 'package:bengkel_online/models/location_model.dart';
import 'package:bengkel_online/providers/auth_provider.dart';
import 'package:bengkel_online/providers/cart_provider.dart';
import 'package:bengkel_online/providers/location_provider.dart';
import 'package:bengkel_online/providers/transaction_provider.dart';
import 'package:bengkel_online/util/themes.dart';
import 'package:bengkel_online/widgets/checkout_card.dart';
import 'package:bengkel_online/widgets/loading_wdiget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CheckoutPage extends StatefulWidget {
  const CheckoutPage({Key? key}) : super(key: key);

  @override
  State<CheckoutPage> createState() => _CheckoutPageState();
}

class _CheckoutPageState extends State<CheckoutPage> {
  bool isLoading = false;
  double shippingPrice = 0;

  @override
  Widget build(BuildContext context) {
    AuthProvider authProvider = Provider.of<AuthProvider>(context);
    CartProvider cartProvider = Provider.of<CartProvider>(context);
    LocationProvider locationProvider = Provider.of<LocationProvider>(context);
    LocationModel location = locationProvider.locations[0];
    TransactionProvider transactionProvider =
        Provider.of<TransactionProvider>(context);

    handleShowLocation() async {
      await Provider.of<LocationProvider>(context, listen: false).getLocations(
        authProvider.user.token.toString(),
      );
      Navigator.pushNamed(context, 'location-transaction');
    }

    handleCheckout() async {
      setState(() {
        isLoading = true;
      });

      if (locationProvider.locations.isEmpty) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            backgroundColor: primaryColor,
            content: const Text(
              'Silahkan pilih lokasi pengiriman',
              textAlign: TextAlign.center,
            ),
          ),
        );
      } else if (await transactionProvider.checkout(
        authProvider.user.token!,
        location.id!,
        cartProvider.totalPrice(),
        shippingPrice,
        cartProvider.totalPrice(),
        cartProvider.carts,
      )) {
        cartProvider.carts = [];

        await Provider.of<TransactionProvider>(context, listen: false)
            .getHistory(
          token: authProvider.user.token!,
        );

        Navigator.pushNamedAndRemoveUntil(
            context, 'checkout-success', (route) => false);
      }

      setState(() {
        isLoading = false;
      });
    }

    PreferredSizeWidget header() {
      return AppBar(
        backgroundColor: primaryColor,
        centerTitle: true,
        elevation: 0,
        title: Text(
          'Detail Pesanan',
          style: whiteTextStyle.copyWith(
            fontSize: 18,
            fontWeight: medium,
          ),
        ),
      );
    }

    Widget buttonChangeLocation(
      String text,
    ) {
      return TextButton(
        onPressed: handleShowLocation,
        child: Text(
          text,
          style: blackTextStyle.copyWith(
            fontWeight: semibold,
            fontSize: 14,
            color: const Color(0xffCA4646),
          ),
        ),
      );
    }

    Widget content() {
      return Container(
        margin: const EdgeInsets.all(30),
        child: ListView(
          children: [
            Text(
              'List Items',
              style: blackTextStyle.copyWith(
                fontWeight: medium,
                fontSize: 16,
              ),
            ),

            // HEADER
            Column(
              children: cartProvider.carts.map((e) => CheckoutCard(e)).toList(),
            ),

            // ADDRESS DETAIL
            Container(
              margin: const EdgeInsets.only(top: 30),
              padding: const EdgeInsets.all(20),
              width: double.infinity,
              decoration: BoxDecoration(
                color: whiteColor,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Address Details',
                        style: blackTextStyle.copyWith(
                          fontWeight: medium,
                          fontSize: 16,
                        ),
                      ),
                      locationProvider.locations.isEmpty
                          ? const SizedBox()
                          : buttonChangeLocation('Ganti Alamat'),
                    ],
                  ),
                  const SizedBox(height: 12),
                  Row(
                    children: [
                      Image.asset(
                        'assets/img/ic_location_shop.png',
                        width: 40,
                      ),
                      const SizedBox(width: 12),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Store Location',
                            style: greyTextStyle.copyWith(
                              fontWeight: light,
                              fontSize: 12,
                            ),
                          ),
                          Text(
                            'Ahass Danadipa Auto Garage',
                            style: blackTextStyle.copyWith(
                              fontWeight: medium,
                              fontSize: 14,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  Container(
                    margin: const EdgeInsets.only(left: 20),
                    child: Image.asset(
                      'assets/img/ic_line.png',
                      height: 30,
                    ),
                  ),
                  Row(
                    children: [
                      Image.asset(
                        'assets/img/ic_location.png',
                        width: 40,
                      ),
                      const SizedBox(width: 12),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Your Address',
                            style: greyTextStyle.copyWith(
                              fontWeight: light,
                              fontSize: 12,
                            ),
                          ),
                          locationProvider.locations.isEmpty
                              ? buttonChangeLocation('Pilih Alamat')
                              : Text(
                                  // 'lokasi',
                                  location.address!,
                                  style: blackTextStyle.copyWith(
                                    fontWeight: medium,
                                    fontSize: 14,
                                  ),
                                  overflow: TextOverflow.ellipsis,
                                ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),

            // PAYMENT SUMMARY
            Container(
              margin: const EdgeInsets.only(top: 30),
              padding: const EdgeInsets.all(20),
              width: double.infinity,
              decoration: BoxDecoration(
                color: whiteColor,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Payment Summary',
                    style: blackTextStyle.copyWith(
                      fontWeight: medium,
                      fontSize: 16,
                    ),
                  ),
                  const SizedBox(height: 12),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Product Quantity',
                        style: blackTextStyle.copyWith(
                          fontWeight: regular,
                          fontSize: 12,
                        ),
                      ),
                      Text(
                        '${cartProvider.totalItems()} Items',
                        style: blackTextStyle.copyWith(
                          fontWeight: medium,
                          fontSize: 14,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Product Price',
                        style: blackTextStyle.copyWith(
                          fontWeight: regular,
                          fontSize: 12,
                        ),
                      ),
                      Text(
                        'Rp${cartProvider.totalPrice()}',
                        style: blackTextStyle.copyWith(
                          fontWeight: medium,
                          fontSize: 14,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Shipping',
                        style: blackTextStyle.copyWith(
                          fontWeight: regular,
                          fontSize: 12,
                        ),
                      ),
                      Text(
                        shippingPrice == 0 ? 'Free' : shippingPrice.toString(),
                        style: blackTextStyle.copyWith(
                          fontWeight: medium,
                          fontSize: 14,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  const Divider(color: Color(0xff2E3141)),
                  const SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Total',
                        style: redTextStyle.copyWith(
                          fontWeight: semibold,
                          fontSize: 14,
                        ),
                      ),
                      Text(
                        'Rp${cartProvider.totalPrice()}',
                        style: redTextStyle.copyWith(
                          fontWeight: semibold,
                          fontSize: 14,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            const SizedBox(height: 30),
            const Divider(color: Color(0xff2E3141)),
            const SizedBox(height: 30),

            // BUTTON CHECKOUT
            Container(
              width: double.infinity,
              alignment: Alignment.center,
              height: 50,
              decoration: BoxDecoration(
                color: primaryColor,
                borderRadius: BorderRadius.circular(12),
              ),
              child: TextButton(
                onPressed: handleCheckout,
                child: Text(
                  'Checkout Sekarang',
                  style: whiteTextStyle.copyWith(
                    fontWeight: semibold,
                    fontSize: 16,
                  ),
                ),
              ),
            ),
          ],
        ),
      );
    }

    return Scaffold(
      backgroundColor: bgLightColor,
      appBar: header(),
      body: isLoading ? const LoadingWidget('Mohon ditunggu') : content(),
    );
  }
}
