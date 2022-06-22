import 'package:bengkel_online/util/themes.dart';
import 'package:flutter/material.dart';

class CheckoutSuccessPage extends StatefulWidget {
  const CheckoutSuccessPage({Key? key}) : super(key: key);

  @override
  State<CheckoutSuccessPage> createState() => _CheckoutSuccessPageState();
}

class _CheckoutSuccessPageState extends State<CheckoutSuccessPage> {
  @override
  Widget build(BuildContext context) {
    // setState(() {
    //   HistoryPage.isSelected = 1;
    // });

    Widget header() {
      return AppBar(
        backgroundColor: primaryColor,
        centerTitle: true,
        automaticallyImplyLeading: false,
        elevation: 0,
        title: Text(
          'Transaksi Berhasil',
          style: whiteTextStyle.copyWith(
            fontSize: 18,
            fontWeight: medium,
          ),
        ),
      );
    }

    Widget content() {
      return Expanded(
        child: Container(
          width: double.infinity,
          color: whiteColor,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                'assets/img/ic_cart_shop.png',
                width: 80,
              ),
              const SizedBox(height: 20),
              Text(
                'Anda melakukan transaksi',
                style: blackTextStyle.copyWith(
                  fontSize: 16,
                  fontWeight: medium,
                ),
              ),
              const SizedBox(height: 12),
              Text(
                'Tetap di rumah sementara kami\nsiapkan pesanan Anda',
                style: greyTextStyle,
                textAlign: TextAlign.center,
              ),
              Container(
                margin: const EdgeInsets.only(top: 30),
                width: 196,
                height: 44,
                child: TextButton(
                  onPressed: () {
                    Navigator.pushNamedAndRemoveUntil(
                        context, 'home', (route) => false);
                  },
                  child: Text(
                    'Oke',
                    style: whiteTextStyle.copyWith(
                      fontSize: 16,
                      fontWeight: medium,
                    ),
                  ),
                  style: TextButton.styleFrom(
                    backgroundColor: primaryColor,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                ),
              ),
              Container(
                margin: const EdgeInsets.only(top: 12),
                width: 196,
                height: 44,
                child: TextButton(
                  onPressed: () {
                    Navigator.pushNamedAndRemoveUntil(
                        context, 'history', (route) => false);
                  },
                  child: Text(
                    'Lihat Pesanan',
                    style: whiteTextStyle.copyWith(
                      fontSize: 16,
                      fontWeight: medium,
                    ),
                  ),
                  style: TextButton.styleFrom(
                    backgroundColor: const Color(0xff39374B),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      );
    }

    return Scaffold(
      backgroundColor: bgLightColor,
      body: Column(
        children: [
          header(),
          content(),
        ],
      ),
    );
  }
}
