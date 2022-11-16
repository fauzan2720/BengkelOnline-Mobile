import 'package:bengkel_online/models/call_mechanic_model.dart';
import 'package:bengkel_online/themes/themes.dart';
import 'package:flutter/material.dart';

class HistoryServiceDetail extends StatelessWidget {
  const HistoryServiceDetail(this.callMechanic, {Key? key}) : super(key: key);
  final CallMechanicModel callMechanic;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: [
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
          // Row(
          //   mainAxisAlignment: MainAxisAlignment.center,
          //   children: [
          //     Image.asset(
          //       'assets/img/ic_whatsapp.png',
          //       height: 40,
          //     ),
          //     const SizedBox(width: 14),
          //     Image.asset(
          //       'assets/img/ic_sms.png',
          //       height: 40,
          //     ),
          //     const SizedBox(width: 14),
          //     Image.asset(
          //       'assets/img/ic_telephone.png',
          //       height: 40,
          //     ),
          //   ],
          // ),
          // const SizedBox(height: 36),

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
                      '1. Tanggal',
                      style: blackTextStyle,
                    ),
                    Text(
                      '${callMechanic.createdAt!.day}-${callMechanic.createdAt!.month}-${callMechanic.createdAt!.year}',
                      style: blackTextStyle,
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      '2. Jenis Servis',
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
                      '3. Masalah',
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
                      '4. Metode Pembayaran',
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

          // BUTTON BACK
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
                'Kembali',
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
