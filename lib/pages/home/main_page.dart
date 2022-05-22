import 'package:bengkel_online/pages/home/call_mechanic_page.dart';
import 'package:bengkel_online/pages/home/cart_page.dart';
import 'package:bengkel_online/pages/home/home_page.dart';
import 'package:bengkel_online/pages/home/profile_page.dart';
import 'package:bengkel_online/pages/home/transactions_page.dart';
import 'package:bengkel_online/theme.dart';
import 'package:flutter/material.dart';

class MainPage extends StatefulWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  int currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    Widget customBottomNav() {
      return Container(
        margin: const EdgeInsets.fromLTRB(20, 0, 20, 20),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(30),
          child: BottomAppBar(
            shape: const CircularNotchedRectangle(),
            notchMargin: 12,
            clipBehavior: Clip.antiAlias,
            child: BottomNavigationBar(
              backgroundColor: primaryColor,
              currentIndex: currentIndex,
              onTap: (value) {
                print(value);
                setState(() {
                  currentIndex = value;
                });
              },
              type: BottomNavigationBarType.fixed,
              items: [
                BottomNavigationBarItem(
                  icon: Container(
                    margin: const EdgeInsets.only(
                      top: 15,
                    ),
                    child: Icon(
                      Icons.home,
                      size: 30,
                      color: currentIndex == 0 ? greyColor : whiteColor,
                    ),
                  ),
                  label: '',
                ),
                BottomNavigationBarItem(
                  icon: Container(
                    margin: const EdgeInsets.only(
                      top: 15,
                    ),
                    child: Icon(
                      Icons.call,
                      size: 30,
                      color: currentIndex == 1 ? greyColor : whiteColor,
                    ),
                  ),
                  label: '',
                ),
                BottomNavigationBarItem(
                  icon: Container(
                    margin: const EdgeInsets.only(
                      top: 15,
                    ),
                    child: Icon(
                      Icons.shopping_bag_rounded,
                      size: 30,
                      color: currentIndex == 2 ? greyColor : whiteColor,
                    ),
                  ),
                  label: '',
                ),
                BottomNavigationBarItem(
                  icon: Container(
                    margin: const EdgeInsets.only(
                      top: 15,
                    ),
                    child: Icon(
                      Icons.list_alt,
                      size: 30,
                      color: currentIndex == 3 ? greyColor : whiteColor,
                    ),
                  ),
                  label: '',
                ),
                BottomNavigationBarItem(
                  icon: Container(
                    margin: const EdgeInsets.only(
                      top: 15,
                    ),
                    child: Icon(
                      Icons.person,
                      size: 30,
                      color: currentIndex == 4 ? greyColor : whiteColor,
                    ),
                  ),
                  label: '',
                ),
              ],
            ),
          ),
        ),
      );
    }

    Widget body() {
      switch (currentIndex) {
        case 0:
          return const HomePage();
        case 1:
          return const CallMechanicPage();
        case 2:
          return const CartPage();
        case 3:
          return const TransactionsPage();
        case 4:
          return const ProfilePage();
        default:
          return const HomePage();
      }
    }

    return Scaffold(
      body: body(),
      bottomNavigationBar: customBottomNav(),
    );
  }
}
