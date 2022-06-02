import 'package:bengkel_online/util/themes.dart';
import 'package:flutter/material.dart';

class MechanicHomePage extends StatelessWidget {
  const MechanicHomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bgLightColor,
      body: ListView(
        children: [
          // PROFILE MECHANIC
          Container(
            padding: const EdgeInsets.symmetric(
              horizontal: 20,
              vertical: 14,
            ),
            decoration: BoxDecoration(
              color: whiteColor,
            ),
            child: Row(
              children: [
                Image.network(
                  'https://ui-avatars.com/api/?name=ANA&color=7F9CF5&background=EBF4FF&rounded=true&size=64',
                ),
                const SizedBox(width: 20),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Afris Nurfal Aziz',
                      style: blackTextStyle.copyWith(
                        fontWeight: semibold,
                        fontSize: 16,
                      ),
                    ),
                    Text(
                      'P 1234 GG',
                      style: poppinsTextStyle.copyWith(
                        color: blackColor,
                        fontSize: 13,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(height: 30),

          // ORDER MASUK
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30),
            child: Text(
              'Order Masuk',
              style: blackTextStyle.copyWith(
                fontWeight: semibold,
                fontSize: 20,
              ),
            ),
          ),
          const SizedBox(height: 20),

          // GOOGLE MAP
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30),
            child: Image.network('assets/img/img_default.png'),
          ),
          const SizedBox(height: 20),

          // PROFILE CUSTOMER
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30),
            child: Row(
              children: [
                Image.network(
                  'https://ui-avatars.com/api/?name=Fauzan Abdillah&color=7F9CF5&background=EBF4FF&rounded=true&size=64',
                ),
                const SizedBox(width: 20),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Fauzan Abdillah',
                      style: blackTextStyle.copyWith(
                        fontWeight: semibold,
                        fontSize: 16,
                      ),
                    ),
                    Text(
                      'P 3456 JM',
                      style: poppinsTextStyle.copyWith(
                        color: blackColor,
                        fontSize: 13,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(height: 50),

          // BUTTON SAMPAI/SELESAI
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 30),
            width: double.infinity,
            height: 50,
            decoration: BoxDecoration(
              borderRadius: const BorderRadius.all(
                Radius.circular(10),
              ),
              color: blueColor,
            ),
            child: TextButton(
              onPressed: () {
                // Navigator.pushNamed(context, 'confirm');
              },
              child: Text(
                'Saya Sudah Sampai',
                // 'Selesaikan Servis',
                style: whiteTextStyle.copyWith(
                  fontWeight: semibold,
                  fontSize: 16,
                ),
              ),
            ),
          ),
          const SizedBox(height: 16),

          // BUTTON CALL CUSTOMER
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30),
            child: Row(
              children: [
                Container(
                  width: MediaQuery.of(context).size.width - 114,
                  height: 50,
                  decoration: BoxDecoration(
                    borderRadius: const BorderRadius.all(
                      Radius.circular(10),
                    ),
                    border: Border.all(color: darkGreyColor),
                  ),
                  child: TextButton(
                    onPressed: () {
                      // Navigator.pop(context);
                    },
                    child: Text(
                      'Hubungi Customer',
                      style: darkGreyTextStyle.copyWith(
                        fontWeight: semibold,
                        fontSize: 16,
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 4),
                Container(
                  width: 50,
                  height: 50,
                  decoration: BoxDecoration(
                    borderRadius: const BorderRadius.all(
                      Radius.circular(10),
                    ),
                    color: darkGreyColor,
                  ),
                  child: TextButton(
                    onPressed: () {
                      // Navigator.pop(context);
                    },
                    child: Icon(
                      Icons.call,
                      size: 20,
                      color: bgLightColor,
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 30),
        ],
      ),
    );
  }
}
