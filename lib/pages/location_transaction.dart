import 'package:bengkel_online/providers/location_provider.dart';
import 'package:bengkel_online/themes/themes.dart';
import 'package:bengkel_online/widgets/empty_widget.dart';
import 'package:bengkel_online/widgets/location_transaction_tile.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class LocationTransactionPage extends StatelessWidget {
  const LocationTransactionPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    LocationProvider locationProvider = Provider.of<LocationProvider>(context);

    PreferredSizeWidget header() {
      return AppBar(
        backgroundColor: primaryColor,
        elevation: 0,
        title: Text(
          'Pilih Lokasi Sekarang',
          style: whiteTextStyle.copyWith(
            fontWeight: medium,
            fontSize: 18,
          ),
        ),
        centerTitle: true,
      );
    }

    return Scaffold(
      backgroundColor: bgLightColor,
      appBar: header(),
      body: locationProvider.locations.isEmpty
          ? EmptyWidget('Opps, alamat kosong',
              'Belum ada alamat yang didaftarkan', 'Tambah Alamat', () {
              Navigator.pushNamed(context, 'add-location-transaction');
            })
          : ListView(
              children: [
                Column(
                  children: locationProvider.locations
                      .map(
                        (e) => LocationTransactionTile(e),
                      )
                      .toList(),
                ),
                Container(
                  margin: const EdgeInsets.symmetric(
                    vertical: 20,
                    horizontal: 20,
                  ),
                  width: double.infinity,
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
                  child: TextButton(
                    onPressed: () {
                      Navigator.pushNamed(context, 'add-location-transaction');
                    },
                    child: Text(
                      'Tambah Lokasi',
                      style: poppinsTextStyle.copyWith(
                        fontWeight: bold,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ],
            ),
    );
  }
}
