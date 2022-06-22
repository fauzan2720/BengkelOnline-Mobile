import 'package:bengkel_online/models/user_model.dart';
import 'package:bengkel_online/providers/auth_provider.dart';
import 'package:bengkel_online/util/themes.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    AuthProvider authProvider = Provider.of<AuthProvider>(context);
    UserModel user = authProvider.user;

    maintanance() {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          backgroundColor: greenColor,
          content: const Text(
            'Fitur dalam tahap pengembangan',
            textAlign: TextAlign.center,
          ),
        ),
      );
    }

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

                if (await authProvider.logout(user.token!)) {
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

    Widget header() {
      return AppBar(
        backgroundColor: primaryColor,
        automaticallyImplyLeading: false,
        elevation: 0,
        flexibleSpace: SafeArea(
          child: Container(
            padding: const EdgeInsets.all(
              30,
            ),
            child: Row(
              children: [
                Image.network(
                  'https://ui-avatars.com/api/?name=${user.fullname}&color=7F9CF5&background=EBF4FF&rounded=true&size=64',
                ),
                const SizedBox(
                  width: 16,
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Hallo, ${user.fullname}',
                        style: whiteTextStyle.copyWith(
                          fontSize: 24,
                          fontWeight: semibold,
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
              ],
            ),
          ),
        ),
      );
    }

    Widget menuItem(
      void Function()? onTap,
      String text,
      Color color,
    ) {
      return GestureDetector(
        onTap: onTap,
        child: Container(
          margin: const EdgeInsets.only(top: 16),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                text,
                style: poppinsTextStyle.copyWith(
                  color: color,
                ),
              ),
              Icon(
                Icons.chevron_right,
                color: color,
              ),
            ],
          ),
        ),
      );
    }

    Widget content() {
      return Expanded(
        child: Container(
          width: double.infinity,
          padding: const EdgeInsets.symmetric(
            horizontal: 30,
          ),
          decoration: BoxDecoration(
            color: bgLightColor,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 40),
              Text(
                'Akun',
                style: blackTextStyle.copyWith(
                  fontSize: 16,
                  fontWeight: semibold,
                ),
              ),
              menuItem(
                () {
                  Navigator.pushNamed(context, 'edit-profile');
                },
                'Perbarui Profil',
                blackColor,
              ),
              menuItem(
                () {
                  Navigator.pushNamed(context, 'edit-password');
                },
                'Ubah Kata Sandi',
                blackColor,
              ),
              const SizedBox(height: 20),
              Text(
                'Umum',
                style: blackTextStyle.copyWith(
                  fontSize: 16,
                  fontWeight: semibold,
                ),
              ),
              menuItem(
                maintanance,
                'FAQ',
                blackColor,
              ),
              menuItem(
                maintanance,
                'Beri Penilaian Aplikasi',
                blackColor,
              ),
              menuItem(
                handleLogout,
                'Keluar',
                redColor,
              ),
            ],
          ),
        ),
      );
    }

    return Column(
      children: [
        header(),
        content(),
      ],
    );
  }
}
