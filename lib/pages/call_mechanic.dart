import 'package:bengkel_online/theme.dart';
import 'package:flutter/material.dart';

class CallMechanic extends StatelessWidget {
  const CallMechanic({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: [
          Stack(
            children: [
              Image.asset(
                'assets/img/img_default.png',
                width: double.infinity,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(
                  vertical: 30,
                  horizontal: 20,
                ),
                child: Image.asset(
                  'assets/img/ic_back.png',
                  width: 60,
                ),
              ),
            ],
          ),

          // PROFIL
          Container(
            padding: const EdgeInsets.symmetric(
              horizontal: 20,
              vertical: 14,
            ),
            decoration: BoxDecoration(
              color: whiteColor,
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Image.network(
                  'https://ui-avatars.com/api/?name=Fauzan&color=7F9CF5&background=EBF4FF&rounded=true&size=64',
                ),
                const SizedBox(width: 20),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Johnny Croissant',
                      style: blackTextStyle.copyWith(
                        fontWeight: semibold,
                        fontSize: 16,
                      ),
                    ),
                    Text(
                      'P 354 JM',
                      style: blackTextStyle.copyWith(
                        fontWeight: medium,
                        fontSize: 13,
                      ),
                    ),
                    Text(
                      'Sampai dalam 5 min',
                      style: poppinsTextStyle.copyWith(
                        color: greenColor,
                        fontWeight: medium,
                        fontSize: 13,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(height: 40),

          // CONTACT
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                'assets/img/ic_whatsapp.png',
                height: 40,
              ),
              const SizedBox(width: 14),
              Image.asset(
                'assets/img/ic_sms.png',
                height: 40,
              ),
              const SizedBox(width: 14),
              Image.asset(
                'assets/img/ic_telephone.png',
                height: 40,
              ),
            ],
          ),
          const SizedBox(height: 36),

          // PART YANG DIGANTI
          Container(
            width: double.infinity,
            margin: const EdgeInsets.symmetric(horizontal: 30),
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              border: Border.all(),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Part yang diganti:',
                  style: blackTextStyle.copyWith(
                    fontWeight: medium,
                    fontSize: 16,
                  ),
                ),
                const SizedBox(height: 6),
                Text(
                  '1. Barang A',
                  style: blackTextStyle,
                ),
                Text(
                  '2. Barang B',
                  style: blackTextStyle,
                ),
                Text(
                  '3. Barang C',
                  style: blackTextStyle,
                ),
              ],
            ),
          ),
          const SizedBox(height: 40),

          // BUTTON NEXT TO PAYMENT
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 30),
            width: double.infinity,
            height: 50,
            decoration: BoxDecoration(
              borderRadius: const BorderRadius.all(
                Radius.circular(10),
              ),
              gradient: const LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Color(0xffF30F0F),
                  Color(0xffD3717C),
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
            child: TextButton(
              onPressed: () {
                Navigator.pushNamed(context, 'confirm');
              },
              child: Text(
                'Lanjut ke Pembayaran',
                style: whiteTextStyle.copyWith(
                  fontWeight: semibold,
                  fontSize: 16,
                ),
              ),
            ),
          ),
          const SizedBox(height: 16),

          // BUTTON CANCEL
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 30),
            width: double.infinity,
            height: 50,
            decoration: BoxDecoration(
              borderRadius: const BorderRadius.all(
                Radius.circular(10),
              ),
              border: Border.all(color: primaryColor),
            ),
            child: TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text(
                'Batalkan',
                style: redTextStyle.copyWith(
                  fontWeight: semibold,
                  fontSize: 16,
                ),
              ),
            ),
          ),
          const SizedBox(height: 30),
        ],
      ),
    );
  }
}
