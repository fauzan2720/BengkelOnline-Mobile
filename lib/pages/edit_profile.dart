import 'package:bengkel_online/models/user_model.dart';
import 'package:bengkel_online/providers/auth_provider.dart';
import 'package:bengkel_online/util/themes.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class EditProfilePage extends StatefulWidget {
  const EditProfilePage({Key? key}) : super(key: key);

  @override
  State<EditProfilePage> createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  @override
  Widget build(BuildContext context) {
    AuthProvider authProvider = Provider.of<AuthProvider>(context);
    UserModel user = authProvider.user;

    TextEditingController nameController =
        TextEditingController(text: user.fullname);
    TextEditingController phoneController =
        TextEditingController(text: user.phoneNumber);
    // TextEditingController pinController =
    //     TextEditingController(text: user.pinNumber);

    handleUpdate() async {
      if (nameController.text.isEmpty ||
          phoneController.text.isEmpty) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            backgroundColor: primaryColor,
            content: const Text(
              'Masih ada inputan yang kosong!',
              textAlign: TextAlign.center,
            ),
          ),
        );
      } else if (await authProvider.update(
        token: user.token.toString(),
        fullname: nameController.text,
        phoneNumber: phoneController.text,
        // pinNumber: pinController.text,
      )) {
        Navigator.pushNamed(context, 'home');
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            backgroundColor: greenColor,
            content: const Text(
              'Profil berhasil diperbarui',
              textAlign: TextAlign.center,
            ),
          ),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            backgroundColor: primaryColor,
            content: const Text(
              'Gagal Update Profil!',
              textAlign: TextAlign.center,
            ),
          ),
        );
      }
    }

    PreferredSizeWidget header() {
      return AppBar(
        backgroundColor: primaryColor,
        automaticallyImplyLeading: false,
        elevation: 0,
        leading: IconButton(
          onPressed: () {
            Navigator.pushReplacementNamed(context, 'home');
          },
          icon: Icon(
            Icons.close,
            color: whiteColor,
          ),
        ),
        title: Text(
          'Perbarui Profile',
          style: whiteTextStyle.copyWith(
            fontWeight: medium,
            fontSize: 18,
          ),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: handleUpdate,
            icon: Icon(
              Icons.check,
              color: whiteColor,
            ),
          ),
          const SizedBox(width: 10),
        ],
      );
    }

    Widget formInput(
      IconData urlIcon,
      String placeholder,
      TextEditingController controller,
      bool obsureText,
    ) {
      return Container(
        height: 50,
        margin: const EdgeInsets.only(top: 20),
        padding: const EdgeInsets.symmetric(
          horizontal: 16,
        ),
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.25),
              spreadRadius: 0,
              blurRadius: 4,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Row(
          children: [
            Icon(
              urlIcon,
              color: iconColor,
            ),
            const SizedBox(
              width: 18,
            ),
            Expanded(
              child: TextFormField(
                obscureText: obsureText,
                controller: controller,
                style: poppinsTextStyle,
                decoration: InputDecoration(
                  hintStyle: placeholderTextStyle,
                  border: InputBorder.none,
                ),
              ),
            ),
          ],
        ),
      );
    }

    Widget content() {
      return Container(
        padding: const EdgeInsets.symmetric(horizontal: 30),
        width: double.infinity,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(height: 70),
            Image.network(
              'https://ui-avatars.com/api/?name=${user.fullname}&color=7F9CF5&background=EBF4FF&rounded=true&size=100',
            ),
            const SizedBox(height: 20),
            formInput(
              Icons.person,
              'Nama Lengkap',
              nameController,
              false,
            ),
            formInput(
              Icons.phone,
              'No. Handphone',
              phoneController,
              false,
            ),
            // formInput(
            //   Icons.confirmation_number,
            //   'Nomor Pin (6 digit)',
            //   pinController,
            //   true,
            // ),
            const SizedBox(height: 30),
          ],
        ),
      );
    }

    return Scaffold(
      backgroundColor: bgLightColor,
      appBar: header(),
      body: content(),
      resizeToAvoidBottomInset: false,
    );
  }
}
