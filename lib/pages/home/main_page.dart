import 'package:bengkel_online/pages/home/home_page.dart';
import 'package:bengkel_online/pages/home/profile_page.dart';
import 'package:bengkel_online/pages/home/history_page.dart';
import 'package:bengkel_online/providers/auth_provider.dart';
import 'package:bengkel_online/providers/call_mechanic_provider.dart';
import 'package:bengkel_online/providers/vehicle_provider.dart';
import 'package:bengkel_online/util/themes.dart';
import 'package:bengkel_online/widgets/loading_wdiget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MainPage extends StatefulWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  int currentIndex = 0;
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    AuthProvider authProvider = Provider.of<AuthProvider>(context);
    VehicleProvider vehicleProvider =
        Provider.of<VehicleProvider>(context, listen: false);
    CallMechanicProvider callMechanicProvider =
        Provider.of<CallMechanicProvider>(context);

    setState(() {
      if (authProvider.user.roles == 'MEKANIK') {
        Navigator.pushNamedAndRemoveUntil(
            context, 'mechanic-home', (route) => false);
      }
    });

    handleCallMechanic() async {
      setState(() {
        isLoading = true;
      });

      if (vehicleProvider.vehicles.isEmpty) {
        await vehicleProvider.getVehicles(
          authProvider.user.token.toString(),
        );
        Navigator.pushNamed(context, 'vehicle');
      } else {
        Navigator.pushNamed(context, 'vehicle');
      }

      setState(() {
        isLoading = false;
      });
    }

    handleCart() async {
      setState(() {
        isLoading = true;
      });

      Navigator.pushNamed(context, 'cart');

      setState(() {
        isLoading = false;
      });
    }

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
              onTap: (value) async {
                print(value);

                if (value == 3) {
                  if (callMechanicProvider.historyServices.isEmpty) {
                    setState(() {
                      isLoading = true;
                    });

                    await Provider.of<CallMechanicProvider>(context,
                            listen: false)
                        .getHistoryServices(
                      token: authProvider.user.token!,
                    );

                    Future.delayed(
                      const Duration(seconds: 1),
                      () => setState(() {
                        currentIndex = value;
                      }),
                    );

                    setState(() {
                      isLoading = false;
                    });
                  } else {
                    setState(() {
                      currentIndex = value;
                    });
                  }
                } else {
                  setState(() {
                    currentIndex = value;
                  });
                }
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
                  icon: GestureDetector(
                    onTap: handleCallMechanic,
                    child: Container(
                      margin: const EdgeInsets.only(
                        top: 15,
                      ),
                      child: Icon(
                        Icons.moped,
                        size: 30,
                        color: currentIndex == 1 ? greyColor : whiteColor,
                      ),
                    ),
                  ),
                  label: '',
                ),
                BottomNavigationBarItem(
                  icon: GestureDetector(
                    onTap: handleCart,
                    child: Container(
                      margin: const EdgeInsets.only(
                        top: 15,
                      ),
                      child: Icon(
                        Icons.shopping_bag_rounded,
                        size: 30,
                        color: currentIndex == 2 ? greyColor : whiteColor,
                      ),
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
        case 3:
          return const HistoryPage();
        case 4:
          return const ProfilePage();
        default:
          return const HomePage();
      }
    }

    return Scaffold(
      body: isLoading ? const LoadingWidget('Mohon Ditunggu') : body(),
      bottomNavigationBar: customBottomNav(),
    );
  }
}
