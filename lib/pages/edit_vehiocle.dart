import 'package:bengkel_online/models/vehicle_model.dart';
import 'package:bengkel_online/providers/auth_provider.dart';
import 'package:bengkel_online/providers/vehicle_provider.dart';
import 'package:bengkel_online/themes/themes.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class EditVehicle extends StatefulWidget {
  const EditVehicle(this.vehicle, {Key? key}) : super(key: key);
  final VehicleModel vehicle;

  @override
  State<EditVehicle> createState() => _EditVehicleState();
}

class _EditVehicleState extends State<EditVehicle> {
  @override
  Widget build(BuildContext context) {
    VehicleProvider vehicleProvider = Provider.of<VehicleProvider>(context);
    AuthProvider authProvider = Provider.of<AuthProvider>(context);

    TextEditingController vehicleNameController =
        TextEditingController(text: widget.vehicle.vehicleName);
    TextEditingController numberPlateController =
        TextEditingController(text: widget.vehicle.numberPlate);

    handleCreateVehicle() async {
      if (vehicleNameController.text == '' ||
          numberPlateController.text == '') {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            backgroundColor: primaryColor,
            content: const Text(
              'Silahkan lengkapi inputan diatas!',
              textAlign: TextAlign.center,
            ),
          ),
        );
      } else if (await vehicleProvider.updateVehicle(
        authProvider.user.token!,
        widget.vehicle.id.toString(),
        vehicleNameController.text,
        numberPlateController.text,
        widget.vehicle.photoUrl!,
      )) {
        await Provider.of<VehicleProvider>(context, listen: false).getVehicles(
          authProvider.user.token.toString(),
        );
        Navigator.pop(context);
        Navigator.pushReplacementNamed(context, 'vehicle');

        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            backgroundColor: Colors.green,
            content: Text(
              'Berhasil diperbarui.',
              textAlign: TextAlign.center,
            ),
          ),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            backgroundColor: primaryColor,
            content: const Text(
              'Gagal diperbarui!',
              textAlign: TextAlign.center,
            ),
          ),
        );
      }
    }

    PreferredSizeWidget header() {
      return AppBar(
        backgroundColor: primaryColor,
        elevation: 0,
        title: Text(
          'Perbarui Kendaraan',
          style: whiteTextStyle.copyWith(
            fontWeight: medium,
            fontSize: 18,
          ),
        ),
        centerTitle: true,
      );
    }

    Widget formInput(
      String text,
      TextEditingController controller,
      TextInputType keyboardType,
    ) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            text,
            style: blackTextStyle.copyWith(
              fontWeight: medium,
              fontSize: 16,
            ),
          ),
          const SizedBox(height: 12),
          Container(
            height: 50,
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
            child: TextFormField(
              keyboardType: keyboardType,
              controller: controller,
              style: poppinsTextStyle,
              decoration: InputDecoration(
                hintText: text,
                hintStyle: placeholderTextStyle,
                border: InputBorder.none,
              ),
            ),
          ),
          text == 'Nomor Plat'
              ? Container(
                  padding: const EdgeInsets.only(top: 10.0),
                  margin: const EdgeInsets.fromLTRB(10, 0, 30, 0),
                  child: Text(
                    "* contoh: P 1234 JM",
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

    return Scaffold(
      appBar: header(),
      body: Container(
        margin: const EdgeInsets.all(20),
        child: ListView(
          children: [
            const SizedBox(height: 30),
            formInput(
                'Nama Kendaraan', vehicleNameController, TextInputType.text),
            const SizedBox(height: 20),
            formInput('Nomor Plat', numberPlateController, TextInputType.text),
            const SizedBox(height: 40),
            // ClipRRect(
            //     borderRadius: BorderRadius.circular(10),
            //     child: Image.asset('assets/img/img_default.png')),
            // const SizedBox(height: 40),

            // BUTOON
            Container(
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
              margin: const EdgeInsets.only(top: 16),
              child: TextButton(
                onPressed: handleCreateVehicle,
                child: Text(
                  'Perbarui',
                  style: poppinsTextStyle.copyWith(
                    fontWeight: bold,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
