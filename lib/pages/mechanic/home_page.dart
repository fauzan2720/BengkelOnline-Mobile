import 'package:bengkel_online/models/call_mechanic_model.dart';
import 'package:bengkel_online/providers/auth_provider.dart';
import 'package:bengkel_online/providers/call_mechanic_provider.dart';
import 'package:bengkel_online/util/themes.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MechanicHomePage extends StatefulWidget {
  const MechanicHomePage({Key? key}) : super(key: key);

  @override
  State<MechanicHomePage> createState() => _MechanicHomePageState();
}

class _MechanicHomePageState extends State<MechanicHomePage> {
  @override
  Widget build(BuildContext context) {
    AuthProvider authProvider = Provider.of<AuthProvider>(context);
    CallMechanicProvider callMechanicProvider =
        Provider.of<CallMechanicProvider>(context);
    CallMechanicModel callMechanic = callMechanicProvider.historyServices[0];

    handleLogout() async {
      AlertDialog alertDialog = AlertDialog(
        title: const Text('Warning!!'),
        content: const Text('Apakah anda yakin ingin keluar?'),
        actions: [
          TextButton(
            child: const Text('Batal'),
            onPressed: () => Navigator.of(context).pop(),
          ),
          TextButton(
              child: const Text('Yakin'),
              onPressed: () async {
                Navigator.pop(context);

                if (await authProvider.logout(authProvider.user.token!)) {
                  Navigator.pushNamedAndRemoveUntil(
                      context, 'login', (route) => false);
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      backgroundColor: greenColor,
                      content: const Text(
                        'Berhasil Logout',
                        textAlign: TextAlign.center,
                      ),
                    ),
                  );
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      backgroundColor: primaryColor,
                      content: const Text(
                        'Gagal Logout',
                        textAlign: TextAlign.center,
                      ),
                    ),
                  );
                }
              }),
        ],
      );
      showDialog(context: context, builder: (context) => alertDialog);
    }

    handleButtonService() {
      AlertDialog alertDialog = AlertDialog(
        title: const Text('Warning!!'),
        content: const Text('Apakah anda yakin menyelesaikan servis?'),
        actions: [
          TextButton(
            child: const Text('Batal'),
            onPressed: () => Navigator.of(context).pop(),
          ),
          TextButton(
            child: const Text('Yakin'),
            onPressed: () async {
              Navigator.pop(context);

              // Programm untuk update status servis disini
            },
          ),
        ],
      );
      showDialog(context: context, builder: (context) => alertDialog);
    }

    Widget content() {
      return ListView(
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
                    GestureDetector(
                      onTap: handleLogout,
                      child: Text(
                        'Logout',
                        style: redTextStyle.copyWith(),
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
          // Padding(
          //   padding: const EdgeInsets.symmetric(horizontal: 30),
          //   child: Image.network('assets/img/img_default.png'),
          // ),
          // const SizedBox(height: 20),

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

          // BUTTON SAMPAI/SELESAI
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 30),
            width: double.infinity,
            height: 50,
            decoration: BoxDecoration(
              borderRadius: const BorderRadius.all(
                Radius.circular(10),
              ),
              color: redColor,
            ),
            child: TextButton(
              onPressed: handleButtonService,
              child: Text(
                'Selesaikan Servis',
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
      );
    }

    return Scaffold(
      backgroundColor: bgLightColor,
      body: content(),
    );
  }
}
