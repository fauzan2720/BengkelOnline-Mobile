import 'package:bengkel_online/models/call_mechanic_model.dart';
import 'package:bengkel_online/providers/call_mechanic_provider.dart';
import 'package:bengkel_online/themes/themes.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CallMechanic extends StatelessWidget {
  const CallMechanic({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    CallMechanicProvider callMechanicProvider =
        Provider.of<CallMechanicProvider>(context);
    CallMechanicModel callMechanic = callMechanicProvider.callMechanics[0];

    return Scaffold(
      body: ListView(
        children: [
          Stack(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: Image.network(
                  // '${callMechanic.vehicle!.photoUrl}',
                  'https://ui-avatars.com/api/?name=${callMechanic.mechanic}&color=7F9CF5&background=EBF4FF&rounded=true&size=64',
                  width: double.infinity,
                ),
              ),
              GestureDetector(
                onTap: () => Navigator.pushReplacementNamed(context, 'home'),
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    vertical: 30,
                    horizontal: 20,
                  ),
                  child: Image.asset(
                    'assets/img/ic_back.png',
                    width: 60,
                  ),
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
              children: [
                Image.network(
                  'https://ui-avatars.com/api/?name=${callMechanic.mechanic}&color=7F9CF5&background=EBF4FF&rounded=true&size=64',
                ),
                const SizedBox(width: 20),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      callMechanic.mechanic!,
                      style: blackTextStyle.copyWith(
                        fontWeight: semibold,
                        fontSize: 16,
                      ),
                    ),
                    Text(
                      'Status: ${callMechanic.status}',
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
              border: Border.all(color: greyColor),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Detail Servis:',
                  style: blackTextStyle.copyWith(
                    fontWeight: medium,
                    fontSize: 16,
                  ),
                ),
                const SizedBox(height: 6),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      '1. Jenis Servis',
                      style: blackTextStyle,
                    ),
                    Text(
                      callMechanic.typeOfWork!,
                      style: blackTextStyle,
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      '2. Masalah',
                      style: blackTextStyle,
                    ),
                    Text(
                      callMechanic.detailProblem!,
                      style: blackTextStyle,
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      '3. Metode Pembayaran',
                      style: blackTextStyle,
                    ),
                    Text(
                      callMechanic.paymentMethod!,
                      style: blackTextStyle,
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      '5. Total Bayar',
                      style: blackTextStyle,
                    ),
                    Text(
                      callMechanic.totalPayment!,
                      style: blackTextStyle,
                    ),
                  ],
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
                Navigator.pushReplacementNamed(context, 'home');
              },
              child: Text(
                'Kembali ke Beranda',
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
                // Navigator.pop(context);
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
