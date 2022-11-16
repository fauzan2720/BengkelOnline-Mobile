import 'package:bengkel_online/providers/auth_provider.dart';
import 'package:bengkel_online/themes/themes.dart';
import 'package:bengkel_online/widgets/loading_button.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({Key? key}) : super(key: key);

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  bool showPassword = true;
  bool showPassword2 = true;
  bool isLoading = false;

  TextEditingController nameController = TextEditingController(text: '');
  TextEditingController phoneController = TextEditingController(text: '');
  TextEditingController emailController = TextEditingController(text: '');
  // TextEditingController pinController = TextEditingController(text: '');
  TextEditingController passwordController = TextEditingController(text: '');
  TextEditingController confirmPasswordController =
      TextEditingController(text: '');

  @override
  Widget build(BuildContext context) {
    AuthProvider authProvider = Provider.of<AuthProvider>(context);

    handleSignUp() async {
      setState(() {
        isLoading = true;
      });

      if (nameController.text.isEmpty ||
          phoneController.text.isEmpty ||
          emailController.text.isEmpty ||
          // pinController.text.isEmpty ||
          passwordController.text.isEmpty ||
          confirmPasswordController.text.isEmpty) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            backgroundColor: primaryColor,
            content: const Text(
              'Masih ada inputan yang kosong!',
              textAlign: TextAlign.center,
            ),
          ),
        );
        // } else if (pinController.text.length != 6) {
        //   ScaffoldMessenger.of(context).showSnackBar(
        //     SnackBar(
        //       backgroundColor: primaryColor,
        //       content: const Text(
        //         'Buat pin dengan 6 digit',
        //         textAlign: TextAlign.center,
        //       ),
        //     ),
        //   );
      } else if (passwordController.text != confirmPasswordController.text) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            backgroundColor: primaryColor,
            content: const Text(
              'Konfirmasi Password Salah',
              textAlign: TextAlign.center,
            ),
          ),
        );
      } else if (passwordController.text.length < 8) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            backgroundColor: primaryColor,
            content: const Text(
              'Password minimal 8 karakter',
              textAlign: TextAlign.center,
            ),
          ),
        );
      } else if (await authProvider.register(
        fullname: nameController.text,
        phoneNumber: phoneController.text,
        email: emailController.text,
        // pin: pinController.text,
        password: passwordController.text,
      )) {
        Navigator.pushReplacementNamed(context, 'home');
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            backgroundColor: greenColor,
            content: const Text(
              'Registrasi berhasil!',
              textAlign: TextAlign.center,
            ),
          ),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            backgroundColor: primaryColor,
            content: const Text(
              'Nomor telepon atau email ada yang sudah terdaftar, silahkan ganti yang lain.',
              textAlign: TextAlign.center,
            ),
          ),
        );
      }

      setState(() {
        isLoading = false;
      });
    }

    Widget logo() {
      return Center(
        child: Container(
          margin: const EdgeInsets.only(top: 90),
          width: 145,
          height: 145,
          decoration: ShapeDecoration(
            shape: const CircleBorder(),
            color: primaryColor,
          ),
          child: Padding(
            padding: const EdgeInsets.all(10),
            child: Container(
              decoration: const ShapeDecoration(
                color: Colors.white,
                shape: CircleBorder(),
              ),
              child: Padding(
                padding: const EdgeInsets.all(18.0),
                child: Image.asset(
                  'assets/img/logo.png',
                ),
              ),
            ),
          ),
        ),
      );
    }

    Widget formInput(
      IconData urlIcon,
      String placeholder,
      TextEditingController controller,
      bool obsureText,
      TextInputType keyboardType,
    ) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: 50,
            margin: const EdgeInsets.fromLTRB(30, 0, 30, 0),
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
                    keyboardType: keyboardType,
                    obscureText: obsureText,
                    controller: controller,
                    style: poppinsTextStyle,
                    decoration: InputDecoration(
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
                      hintText: placeholder,
                      hintStyle: placeholderTextStyle,
                      border: InputBorder.none,
                    ),
                  ),
                ),
              ],
            ),
          ),
          obsureText
              ? Container(
                  padding: const EdgeInsets.only(top: 10.0),
                  margin: const EdgeInsets.fromLTRB(40, 0, 30, 0),
                  child: Text(
                    "* Minimal 6 karakter",
                    style: TextStyle(
                      color: iconColor,
                      fontSize: 12.0,
                    ),
                  ),
                )
              : SizedBox(),
        ],
      );
    }

    Widget formConfirmPassword(
      IconData urlIcon,
      String placeholder,
      TextEditingController controller,
      bool obsureText,
      TextInputType keyboardType,
    ) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: 50,
            margin: const EdgeInsets.fromLTRB(30, 0, 30, 0),
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
                    keyboardType: keyboardType,
                    obscureText: obsureText,
                    controller: controller,
                    style: poppinsTextStyle,
                    decoration: InputDecoration(
                      suffixIcon: urlIcon == Icons.lock_outline
                          ? Builder(
                              builder: (context) {
                                return GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      showPassword2 = !showPassword2;
                                    });
                                  },
                                  child: Icon(
                                    showPassword2
                                        ? Icons.visibility_off
                                        : Icons.visibility,
                                    color: iconColor,
                                  ),
                                );
                              },
                            )
                          : null,
                      hintText: placeholder,
                      hintStyle: placeholderTextStyle,
                      border: InputBorder.none,
                    ),
                  ),
                ),
              ],
            ),
          ),
          obsureText
              ? Container(
                  padding: const EdgeInsets.only(top: 10.0),
                  margin: const EdgeInsets.fromLTRB(40, 0, 30, 0),
                  child: Text(
                    "* Minimal 6 karakter",
                    style: TextStyle(
                      color: iconColor,
                      fontSize: 12.0,
                    ),
                  ),
                )
              : SizedBox(),
        ],
      );
    }

    Widget buttonRegistrasi() {
      return Container(
        width: 190,
        height: 40,
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
        margin: const EdgeInsets.only(top: 16),
        child: TextButton(
          onPressed: handleSignUp,
          child: Text(
            'Daftar',
            style: poppinsTextStyle.copyWith(
              fontWeight: bold,
              color: Colors.white,
            ),
          ),
        ),
      );
    }

    Widget buttonLogin() {
      return Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            'Sudah punya akun?',
            style: poppinsTextStyle.copyWith(
              color: primaryColor,
            ),
            textAlign: TextAlign.end,
          ),
          const SizedBox(width: 5),
          GestureDetector(
            onTap: () {
              Navigator.pushReplacementNamed(context, 'login');
            },
            child: Text(
              'Login yuk',
              style: poppinsTextStyle.copyWith(
                fontWeight: semibold,
                color: primaryColor,
              ),
              textAlign: TextAlign.end,
            ),
          ),
        ],
      );
    }

    Widget body() {
      return Container(
        margin: const EdgeInsets.only(top: 160),
        width: double.infinity,
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(
            top: Radius.circular(30),
          ),
        ),
        child: Stack(
          children: [
            SizedBox(
              height: MediaQuery.of(context).size.height - 150,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Image.asset(
                    'assets/img/asset_bg.png',
                    height: 215,
                  ),
                  Image.asset(
                    'assets/img/asset_bg2.png',
                    width: double.infinity,
                  ),
                ],
              ),
            ),
            Column(
              children: [
                const SizedBox(height: 150),
                formInput(Icons.person, 'Nama Lengkap', nameController, false,
                    TextInputType.name),
                const SizedBox(height: 30),
                formInput(Icons.phone, 'No. Handphone', phoneController, false,
                    TextInputType.phone),
                const SizedBox(height: 30),
                formInput(Icons.email, 'Email', emailController, false,
                    TextInputType.emailAddress),
                const SizedBox(height: 30),
                // formInput(Icons.confirmation_number, 'Nomor Pin (6 digit)',
                //     pinController, false, TextInputType.number),
                // const SizedBox(height: 30),
                formInput(Icons.lock_outline, 'Password', passwordController,
                    showPassword, TextInputType.text),
                const SizedBox(height: 30),
                formConfirmPassword(
                    Icons.lock_outline,
                    'Konfirmasi Password',
                    confirmPasswordController,
                    showPassword2,
                    TextInputType.text),
                const SizedBox(height: 62),
                isLoading ? const LoadingButton() : buttonRegistrasi(),
                const SizedBox(height: 30),
                buttonLogin(),
              ],
            ),
          ],
        ),
      );
    }

    return Scaffold(
      backgroundColor: primaryColor,
      body: ListView(
        children: [
          Stack(
            children: [
              body(),
              logo(),
            ],
          ),
        ],
      ),
    );
  }
}
