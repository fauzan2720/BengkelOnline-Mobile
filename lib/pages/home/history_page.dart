import 'package:bengkel_online/providers/auth_provider.dart';
import 'package:bengkel_online/providers/call_mechanic_provider.dart';
import 'package:bengkel_online/providers/product_provider.dart';
import 'package:bengkel_online/providers/transaction_provider.dart';
import 'package:bengkel_online/providers/vehicle_provider.dart';
import 'package:bengkel_online/util/themes.dart';
import 'package:bengkel_online/widgets/empty_widget.dart';
import 'package:bengkel_online/widgets/history_service_tile.dart';
import 'package:bengkel_online/widgets/history_transaction_tile.dart';
import 'package:bengkel_online/widgets/loading_wdiget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HistoryPage extends StatefulWidget {
  const HistoryPage({Key? key}) : super(key: key);

  @override
  State<HistoryPage> createState() => _HistoryPageState();
}

class _HistoryPageState extends State<HistoryPage> {
  bool isLoading = false;
  int isSelected = 0;

  @override
  Widget build(BuildContext context) {
    AuthProvider authProvider = Provider.of<AuthProvider>(context);
    VehicleProvider vehicleProvider =
        Provider.of<VehicleProvider>(context, listen: false);
    ProductProvider productProvider = Provider.of<ProductProvider>(context);
    CallMechanicProvider callMechanicProvider =
        Provider.of<CallMechanicProvider>(context);
    TransactionProvider transactionProvider =
        Provider.of<TransactionProvider>(context);

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

    handleShowProducts() async {
      setState(() {
        isLoading = true;
      });

      if (productProvider.allProduct.isEmpty) {
        await Provider.of<ProductProvider>(context, listen: false)
            .getAllProducts();

        Navigator.pushNamed(context, 'products');
      } else {
        Navigator.pushNamed(context, 'products');
      }

      setState(() {
        isLoading = false;
      });
    }

    Widget header() {
      return AppBar(
        backgroundColor: primaryColor,
        automaticallyImplyLeading: false,
        elevation: 0,
        leading: IconButton(
          onPressed: () {
            Navigator.pushNamedAndRemoveUntil(
                context, 'home', (route) => false);
          },
          icon: Icon(
            Icons.arrow_back_ios,
            color: whiteColor,
          ),
        ),
        title: Text(
          isSelected == 0 ? 'Riwayat Servis' : 'Riwayat Pembelian',
          style: whiteTextStyle.copyWith(
            fontWeight: medium,
            fontSize: 18,
          ),
        ),
        centerTitle: true,
      );
    }

    Widget categoriesButton(
      int index,
      String text,
    ) {
      return GestureDetector(
        onTap: () async {
          if (index == 1 && transactionProvider.history.isEmpty) {
            await Provider.of<TransactionProvider>(context, listen: false)
                .getHistory(
              token: authProvider.user.token!,
            );

            Future.delayed(
              const Duration(seconds: 1),
              () => setState(() {
                isSelected = index;
              }),
            );
          } else {
            setState(() {
              isSelected = index;
            });
          }
        },
        child: Container(
          width: double.infinity,
          margin: const EdgeInsets.only(right: 16),
          padding: const EdgeInsets.symmetric(
            vertical: 10,
          ),
          decoration: BoxDecoration(
            color: isSelected == index ? primaryColor : transparentColor,
            borderRadius: BorderRadius.circular(12),
            border: isSelected == index
                ? Border.all(color: transparentColor)
                : Border.all(color: primaryColor, width: 1),
          ),
          child: Center(
            child: Text(
              text,
              style: poppinsTextStyle.copyWith(
                color: isSelected == index ? whiteColor : primaryColor,
                fontWeight: isSelected == index ? medium : light,
              ),
            ),
          ),
        ),
      );
    }

    Widget historyServices() {
      return Container(
        width: double.infinity,
        color: bgLightColor,
        padding: const EdgeInsets.symmetric(horizontal: 30),
        child: callMechanicProvider.historyServices.isEmpty
            ? isLoading
                ? const Padding(
                    padding: EdgeInsets.only(top: 170),
                    child: LoadingWidget('Mohon ditunggu'),
                  )
                : Padding(
                    padding: const EdgeInsets.only(top: 150),
                    child: EmptyWidget(
                      'Opss anda belum pernah melakukan servis dengan memanggil mekanik?',
                      'Yuk servis kendaraanmu dan tunggu dirumahmu',
                      'Panggil Mekanik',
                      handleCallMechanic,
                    ),
                  )
            : Column(
                children: callMechanicProvider.historyServices
                    .map(
                      (e) => HistoryServiceTile(e),
                    )
                    .toList(),
              ),
      );
    }

    Widget historyTransactions() {
      return Container(
        width: double.infinity,
        color: bgLightColor,
        padding: const EdgeInsets.symmetric(horizontal: 30),
        child: transactionProvider.history.isEmpty
            ? isLoading
                ? const Padding(
                    padding: EdgeInsets.only(top: 170),
                    child: LoadingWidget('Mohon ditunggu'),
                  )
                : Padding(
                    padding: const EdgeInsets.only(top: 150),
                    child: EmptyWidget(
                      'Opss transaksi anda masih kosong?',
                      'Yuk cari produk kesukaanmu',
                      'Lihat Produk',
                      handleShowProducts,
                    ),
                  )
            : Column(
                children: transactionProvider.history
                    .map(
                      (e) => HistoryTransactionTile(e),
                    )
                    .toList(),
              ),
      );
    }

    return SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          header(),
          const SizedBox(height: 30),
          Row(
            children: [
              const SizedBox(width: 30),
              Flexible(
                flex: 1,
                child: categoriesButton(
                  0,
                  'Servis',
                ),
              ),
              Flexible(
                flex: 1,
                child: categoriesButton(
                  1,
                  'Pembelian',
                ),
              ),
              const SizedBox(width: 14),
            ],
          ),
          const SizedBox(height: 20),
          isSelected == 0 ? historyServices() : historyTransactions(),
        ],
      ),
    );
  }
}
