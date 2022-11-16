import 'package:bengkel_online/models/product_model.dart';
import 'package:bengkel_online/providers/cart_provider.dart';
import 'package:bengkel_online/themes/themes.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ProductDetailPage extends StatefulWidget {
  const ProductDetailPage(this.product, {Key? key}) : super(key: key);
  final ProductModel product;

  @override
  State<ProductDetailPage> createState() => _ProductDetailPageState();
}

class _ProductDetailPageState extends State<ProductDetailPage> {
  int currentIndex = 0;
  bool isWishlist = false;

  @override
  Widget build(BuildContext context) {
    CartProvider cartProvider = Provider.of<CartProvider>(context);

    Future<void> showSuccessDialog() async {
      return showDialog(
        context: context,
        builder: (BuildContext context) => SizedBox(
          width: MediaQuery.of(context).size.width - (2 * 30),
          child: AlertDialog(
            backgroundColor: bgLightColor,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(30),
            ),
            content: SingleChildScrollView(
              child: Column(
                children: [
                  GestureDetector(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Icon(
                        Icons.close,
                        color: primaryColor,
                      ),
                    ),
                  ),
                  Image.asset(
                    'assets/img/ic_success.png',
                    width: 100,
                    height: 100,
                  ),
                  const SizedBox(height: 12),
                  Text(
                    'Hurray :)',
                    style: blackTextStyle.copyWith(
                      fontWeight: semibold,
                      fontSize: 18,
                    ),
                  ),
                  const SizedBox(height: 12),
                  Text(
                    'Produk berhasil ditambahkan',
                    style: greyTextStyle.copyWith(
                      fontWeight: regular,
                      fontSize: 14,
                    ),
                  ),
                  const SizedBox(height: 20),
                  SizedBox(
                    width: 160,
                    height: 44,
                    child: TextButton(
                      onPressed: () {
                        Navigator.pushReplacementNamed(context, 'cart');
                      },
                      style: TextButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        backgroundColor: primaryColor,
                      ),
                      child: Text(
                        'Lihat Keranjang',
                        style: whiteTextStyle.copyWith(
                          fontWeight: medium,
                          fontSize: 16,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      );
    }

    Widget indicator(int index) {
      return Container(
        width: currentIndex == index ? 16 : 4,
        height: 4,
        margin: const EdgeInsets.symmetric(horizontal: 2),
        decoration: BoxDecoration(
          color: currentIndex == index ? primaryColor : const Color(0xffC4C4C4),
          borderRadius: BorderRadius.circular(10),
        ),
      );
    }

    Widget header() {
      int index = -1;

      return Column(
        children: [
          Container(
            margin: const EdgeInsets.only(
              top: 25,
              left: 30,
              right: 30,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                GestureDetector(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: const Icon(
                    Icons.chevron_left,
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.pushNamed(context, 'cart');
                  },
                  child: const Icon(
                    Icons.shopping_bag,
                  ),
                ),
              ],
            ),
          ),
          Hero(
            tag: "product",
            child: CarouselSlider(
              items: widget.product.galleries!
                  .map(
                    (image) => Image.network(
                      image.url!,
                      width: MediaQuery.of(context).size.width,
                      height: 300,
                      fit: BoxFit.contain,
                    ),
                  )
                  .toList(),
              options: CarouselOptions(
                  initialPage: 0,
                  onPageChanged: (index, reason) {
                    setState(() {
                      currentIndex = index;
                    });
                  }),
            ),
          ),
          const SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: widget.product.galleries!.map(
              (e) {
                index++;
                return indicator(index);
              },
            ).toList(),
          ),
        ],
      );
    }

    Widget content() {
      return Container(
        margin: const EdgeInsets.only(top: 30),
        height: MediaQuery.of(context).size.height - 349,
        decoration: BoxDecoration(
          borderRadius: const BorderRadius.vertical(
            top: Radius.circular(30),
          ),
          color: bgLightColor,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(30, 30, 30, 0),
              child: Text(
                widget.product.productName!,
                style: blackTextStyle.copyWith(
                  fontWeight: semibold,
                  fontSize: 18,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(30, 0, 30, 0),
              child: Text(
                widget.product.productCategory!,
                style: greyTextStyle,
              ),
            ),

            // PRICE
            Container(
              margin: const EdgeInsets.fromLTRB(30, 16, 30, 0),
              padding: const EdgeInsets.symmetric(horizontal: 14),
              height: 55,
              decoration: BoxDecoration(
                color: whiteColor,
                borderRadius: BorderRadius.circular(4),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Harga',
                    style: blackTextStyle,
                  ),
                  Text(
                    'Rp${widget.product.price}',
                    style: greenTextStyle.copyWith(
                      fontWeight: medium,
                    ),
                  ),
                ],
              ),
            ),

            // BUTTON
            Container(
              margin: const EdgeInsets.all(30),
              width: double.infinity,
              child: SizedBox(
                height: 54,
                child: TextButton(
                  onPressed: () {
                    cartProvider.addCart(widget.product);
                    showSuccessDialog();
                  },
                  style: TextButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    backgroundColor: primaryColor,
                  ),
                  child: Text(
                    'Masukkan Keranjang',
                    style: whiteTextStyle.copyWith(
                      fontWeight: semibold,
                      fontSize: 16,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      );
    }

    return Scaffold(
      backgroundColor: whiteColor,
      body: ListView(
        children: [
          header(),
          content(),
        ],
      ),
    );
  }
}
