import 'package:bengkel_online/models/user_model.dart';
import 'package:bengkel_online/providers/auth_provider.dart';
import 'package:bengkel_online/themes/themes.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class EditPasswordPage extends StatefulWidget {
  const EditPasswordPage({Key? key}) : super(key: key);

  @override
  State<EditPasswordPage> createState() => _EditPasswordPageState();
}

class _EditPasswordPageState extends State<EditPasswordPage> {
  bool showPassword = true;

  @override
  Widget build(BuildContext context) {
    AuthProvider authProvider = Provider.of<AuthProvider>(context);
    UserModel user = authProvider.user;

    TextEditingController newPasswordController =
        TextEditingController(text: '');
    TextEditingController confirmNewPasswordController =
        TextEditingController(text: '');

    handleUpdate() async {
      if (newPasswordController.text.isEmpty ||
          confirmNewPasswordController.text.isEmpty) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            backgroundColor: primaryColor,
            content: const Text(
              'Masukkan password dengan benar!',
              textAlign: TextAlign.center,
            ),
          ),
        );
      } else if (newPasswordController.text ==
          confirmNewPasswordController.text) {
        if (await authProvider.updatePassword(
          token: user.token!,
          password: newPasswordController.text,
        )) {
          Navigator.pushReplacementNamed(context, 'home');
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              backgroundColor: greenColor,
              content: const Text(
                'Password berhasil diperbarui',
                textAlign: TextAlign.center,
              ),
            ),
          );
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              backgroundColor: primaryColor,
              content: const Text(
                'Gagal Update Password!',
                textAlign: TextAlign.center,
              ),
            ),
          );
        }
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            backgroundColor: primaryColor,
            content: const Text(
              'Password tidak sesuai!',
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
            Navigator.pop(context);
          },
          icon: Icon(
            Icons.close,
            color: whiteColor,
          ),
        ),
        title: Text(
          'Perbarui Password',
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
                  hintText: placeholder,
                  hintStyle: placeholderTextStyle,
                  border: InputBorder.none,
                  suffixIcon: urlIcon == Icons.lock_outline
                      ? Builder(
                          builder: (context) {
                            return GestureDetector(
                              onTap: () {
                                setState(() {
                                  showPassword = !showPassword;
                                });
                              },
                              child: Icon(
                                showPassword
                                    ? Icons.visibility_off
                                    : Icons.visibility,
                                color: iconColor,
                              ),
                            );
                          },
                        )
                      : null,
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
            formInput(
              Icons.lock_outlined,
              'Masukkan Password Baru',
              newPasswordController,
              true,
            ),
            formInput(
              Icons.lock_outlined,
              'Konfirmasi Masukkan Password Baru',
              confirmNewPasswordController,
              true,
            ),
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
