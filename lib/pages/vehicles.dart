import 'package:bengkel_online/providers/vehicle_provider.dart';
import 'package:bengkel_online/themes/themes.dart';
import 'package:bengkel_online/widgets/empty_widget.dart';
import 'package:bengkel_online/widgets/vehicle_tile.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class VehiclePage extends StatefulWidget {
  const VehiclePage({Key? key}) : super(key: key);

  @override
  State<VehiclePage> createState() => _VehiclePageState();
}

class _VehiclePageState extends State<VehiclePage> {
  @override
  Widget build(BuildContext context) {
    VehicleProvider vehicleProvider = Provider.of<VehicleProvider>(context);

    PreferredSizeWidget header() {
      return AppBar(
        backgroundColor: primaryColor,
        elevation: 0,
        title: Text(
          'Pilih Kendaraan',
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
      body: vehicleProvider.vehicles.isEmpty
          ? EmptyWidget('Opps, kendaaraan kosong',
              'Belum ada kendaraan yang didaftarkan', 'Tambah Kendaraan', () {
              Navigator.pushNamed(context, 'add-vehicle');
            })
          : ListView(
              children: [
                Column(
                  children: vehicleProvider.vehicles
                      .map(
                        (e) => VehicleTile(e),
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
                      Navigator.pushReplacementNamed(context, 'add-vehicle');
                    },
                    child: Text(
                      'Tambah Kendaraan',
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
