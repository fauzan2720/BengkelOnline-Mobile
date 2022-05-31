import 'package:bengkel_online/providers/location_provider.dart';
import 'package:bengkel_online/util/themes.dart';
import 'package:bengkel_online/widgets/location_tile.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class LocationPage extends StatelessWidget {
  const LocationPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    LocationProvider locationProvider = Provider.of<LocationProvider>(context);

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
            Icons.arrow_back_ios,
            color: whiteColor,
          ),
        ),
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
      body: ListView(
        children: [
          Column(
            children: locationProvider.locations
                .map(
                  (e) => LocationTile(e),
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
                Navigator.pushReplacementNamed(context, 'add-location');
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
