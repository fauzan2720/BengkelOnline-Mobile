import 'package:bengkel_online/theme.dart';
import 'package:flutter/material.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({Key? key}) : super(key: key);

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  bool showPassword = true;
  bool showConfirmPassword = true;

  @override
  Widget build(BuildContext context) {
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

    Widget nameInput() {
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
              Icons.person,
              color: iconColor,
            ),
            const SizedBox(
              width: 18,
            ),
            Expanded(
              child: TextFormField(
                autofocus: true,
                keyboardType: TextInputType.name,
                style: poppinsTextStyle,
                decoration: InputDecoration.collapsed(
                  hintText: 'Nama Lengkap',
                  hintStyle: placeholderTextStyle,
                ),
              ),
            ),
          ],
        ),
      );
    }

    Widget phoneInput() {
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
              Icons.call,
              color: iconColor,
            ),
            const SizedBox(
              width: 18,
            ),
            Expanded(
              child: TextFormField(
                autofocus: true,
                keyboardType: TextInputType.number,
                style: poppinsTextStyle,
                decoration: InputDecoration.collapsed(
                  hintText: 'No. Handphone',
                  hintStyle: placeholderTextStyle,
                ),
              ),
            ),
          ],
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

    Widget pinInput() {
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
              Icons.confirmation_number,
              color: iconColor,
            ),
            const SizedBox(
              width: 18,
            ),
            Expanded(
              child: TextFormField(
                autofocus: true,
                keyboardType: TextInputType.number,
                style: poppinsTextStyle,
                decoration: InputDecoration.collapsed(
                  hintText: 'Buat PIN',
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

    Widget confirmPasswordInput() {
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
                style: poppinsTextStyle,
                obscureText: showConfirmPassword,
                decoration: InputDecoration(
                  suffixIcon: Builder(
                    builder: (context) {
                      return GestureDetector(
                        onTap: () {
                          setState(() {
                            showConfirmPassword = !showConfirmPassword;
                          });
                        },
                        child: Icon(
                          showConfirmPassword
                              ? Icons.visibility_off
                              : Icons.visibility,
                          color: iconColor,
                        ),
                      );
                    },
                  ),
                  hintText: 'Konfirmasi Password',
                  hintStyle: placeholderTextStyle,
                  border: InputBorder.none,
                ),
              ),
            ),
          ],
        ),
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
          onPressed: () {
            Navigator.pushNamed(context, 'login');
          },
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
              Navigator.pushNamedAndRemoveUntil(
                  context, 'login', (route) => false);
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
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Image.asset(
                  'assets/img/asset_bg.png',
                  height: 215,
                ),
                const SizedBox(height: 400),
                Image.asset(
                  'assets/img/asset_bg2.png',
                  width: double.infinity,
                ),
              ],
            ),
            Column(
              children: [
                const SizedBox(height: 150),
                nameInput(),
                const SizedBox(height: 30),
                phoneInput(),
                const SizedBox(height: 30),
                emailInput(),
                const SizedBox(height: 30),
                pinInput(),
                const SizedBox(height: 30),
                passwordInput(),
                const SizedBox(height: 30),
                confirmPasswordInput(),
                const SizedBox(height: 62),
                buttonRegistrasi(),
                const SizedBox(height: 30),
                buttonLogin(),
              ],
            ),
          ],
        ),
      );
    }

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
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
      ),
    );
  }
}
