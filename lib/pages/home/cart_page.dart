import 'package:bengkel_online/providers/auth_provider.dart';
import 'package:bengkel_online/providers/cart_provider.dart';
import 'package:bengkel_online/providers/location_provider.dart';
import 'package:bengkel_online/providers/product_provider.dart';
import 'package:bengkel_online/util/themes.dart';
import 'package:bengkel_online/widgets/cart_card.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CartPage extends StatefulWidget {
  const CartPage({Key? key}) : super(key: key);

  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    AuthProvider authProvider = Provider.of<AuthProvider>(context);
    CartProvider cartProvider = Provider.of<CartProvider>(context);
    ProductProvider productProvider = Provider.of<ProductProvider>(context);

    handleShowLocation() async {
      await Provider.of<LocationProvider>(context, listen: false).getLocations(
        authProvider.user.token.toString(),
      );
      Navigator.pushNamed(context, 'checkout');
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

    PreferredSizeWidget header() {
      return AppBar(
        backgroundColor: primaryColor,
        centerTitle: true,
        elevation: 0,
        title: Text(
          'Keranjang Saya',
          style: whiteTextStyle.copyWith(
            fontSize: 18,
            fontWeight: medium,
          ),
        ),
      );
    }

    Widget emptyCart() {
      return Container(
        width: double.infinity,
        color: bgLightColor,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              'assets/img/ic_cart_shop.png',
              width: 80,
            ),
            const SizedBox(height: 20),
            Text(
              'Opss! keranjangmu kosong',
              style: blackTextStyle.copyWith(
                fontSize: 16,
                fontWeight: medium,
              ),
            ),
            const SizedBox(height: 12),
            Text(
              'Yuk cari barang dulu',
              style: greyTextStyle,
            ),
            const SizedBox(height: 20),
            TextButton(
              onPressed: handleShowProducts,
              child: Text(
                'Kunjungi Marketplace',
                style: whiteTextStyle.copyWith(
                  fontSize: 16,
                  fontWeight: medium,
                ),
              ),
              style: TextButton.styleFrom(
                padding: const EdgeInsets.symmetric(
                  horizontal: 24,
                  vertical: 20,
                ),
                backgroundColor: primaryColor,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),
          ],
        ),
      );
    }

    Widget content() {
      return Container(
        margin: const EdgeInsets.fromLTRB(30, 18, 30, 0),
        child: ListView(
          children: cartProvider.carts.map((e) => CartCard(e)).toList(),
        ),
      );
    }

    Widget bottomNav() {
      return Container(
        padding: const EdgeInsets.all(30),
        height: 200,
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Subtotal',
                  style: blackTextStyle.copyWith(
                    fontSize: 14,
                    fontWeight: regular,
                  ),
                ),
                Text(
                  'Rp${cartProvider.totalPrice()}',
                  style: redTextStyle.copyWith(
                    fontSize: 16,
                    fontWeight: semibold,
                  ),
                ),
              ],
            ),
            Container(
              margin: const EdgeInsets.symmetric(vertical: 30),
              child: Divider(
                color: primaryColor,
                height: 1,
              ),
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              width: double.infinity,
              height: 50,
              decoration: BoxDecoration(
                color: primaryColor,
                borderRadius: BorderRadius.circular(12),
              ),
              child: TextButton(
                onPressed: handleShowLocation,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Continue to Checkout',
                      style: whiteTextStyle.copyWith(
                        fontWeight: semibold,
                        fontSize: 16,
                      ),
                    ),
                    Icon(Icons.arrow_forward, color: whiteColor),
                  ],
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
      body: cartProvider.carts.isEmpty ? emptyCart() : content(),
      bottomNavigationBar:
          cartProvider.carts.isEmpty ? const SizedBox() : bottomNav(),
    );
  }
}
