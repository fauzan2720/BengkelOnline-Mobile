import 'package:bengkel_online/providers/auth_provider.dart';
import 'package:bengkel_online/util/themes.dart';
import 'package:bengkel_online/widgets/loading_button.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool showPassword = true;
  bool isLoading = false;

  TextEditingController emailController = TextEditingController(text: '');
  TextEditingController passwordController = TextEditingController(text: '');

  @override
  Widget build(BuildContext context) {
    AuthProvider authProvider = Provider.of<AuthProvider>(context);

    // saveLoginStatus() async {
    //   SharedPreferences pref = await SharedPreferences.getInstance();
    //   pref.setBool("isLogedIn", true);
    // }

    handleLogin() async {
      setState(() {
        isLoading = true;
      });

      if (await authProvider.login(
        email: emailController.text,
        password: passwordController.text,
      )) {
        // saveLoginStatus();
        // print(saveLoginStatus().then((value) => value));

        Navigator.pushReplacementNamed(context, 'home');
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            backgroundColor: primaryColor,
            content: const Text(
              'Email atau Password yang dimasukkan salah!',
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
              child: Image.asset(
                'assets/img/logo.png',
              ),
            ),
          ),
        ),
      );
    }

    Widget emailInput() {
      return Container(
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
              Icons.mail,
              color: iconColor,
            ),
            const SizedBox(
              width: 18,
            ),
            Expanded(
              child: TextFormField(
                controller: emailController,
                autofocus: true,
                keyboardType: TextInputType.emailAddress,
                style: poppinsTextStyle,
                decoration: InputDecoration.collapsed(
                  hintText: 'Email',
                  hintStyle: placeholderTextStyle,
                ),
              ),
            ),
          ],
        ),
      );
    }

    Widget passwordInput() {
      return Container(
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
              Icons.lock_outline,
              color: iconColor,
            ),
            const SizedBox(
              width: 18,
            ),
            Expanded(
              child: TextFormField(
                controller: passwordController,
                style: poppinsTextStyle,
                obscureText: showPassword,
                decoration: InputDecoration(
                  suffixIcon: Builder(
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
                  ),
                  hintText: 'Password',
                  hintStyle: placeholderTextStyle,
                  border: InputBorder.none,
                ),
              ),
            ),
          ],
        ),
      );
    }

    Widget buttonLogin() {
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
          onPressed: handleLogin,
          child: Text(
            'Masuk',
            style: poppinsTextStyle.copyWith(
              fontWeight: bold,
              color: Colors.white,
            ),
          ),
        ),
      );
    }

    Widget buttonRegistrasi() {
      return Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            'Belum punya akun?',
            style: poppinsTextStyle.copyWith(
              color: primaryColor,
            ),
            textAlign: TextAlign.end,
          ),
          const SizedBox(width: 5),
          GestureDetector(
            onTap: () {
              Navigator.pushReplacementNamed(context, 'registrasi');
            },
            child: Text(
              'Daftar yuk',
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
                emailInput(),
                const SizedBox(height: 30),
                passwordInput(),
                const SizedBox(height: 23),
                Container(
                  width: double.infinity,
                  margin: const EdgeInsets.symmetric(horizontal: 30),
                  child: Text(
                    'Lupa Password?',
                    style: poppinsTextStyle.copyWith(
                      fontWeight: semibold,
                      color: const Color(0xff508BFF),
                    ),
                    textAlign: TextAlign.end,
                  ),
                ),
                const SizedBox(height: 62),
                isLoading ? const LoadingButton() : buttonLogin(),
                const SizedBox(height: 30),
                buttonRegistrasi(),
              ],
            )
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
