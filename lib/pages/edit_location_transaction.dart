import 'package:bengkel_online/models/location_model.dart';
import 'package:bengkel_online/providers/auth_provider.dart';
import 'package:bengkel_online/providers/location_provider.dart';
import 'package:bengkel_online/util/themes.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class EditLocationTransaction extends StatefulWidget {
  const EditLocationTransaction(this.location, {Key? key}) : super(key: key);
  final LocationModel location;

  @override
  State<EditLocationTransaction> createState() =>
      _EditLocationTransactionState();
}

class _EditLocationTransactionState extends State<EditLocationTransaction> {
  @override
  Widget build(BuildContext context) {
    LocationProvider locationProvider = Provider.of<LocationProvider>(context);
    AuthProvider authProvider = Provider.of<AuthProvider>(context);

    TextEditingController alamatController =
        TextEditingController(text: widget.location.address);
    TextEditingController detailLokasiController =
        TextEditingController(text: widget.location.detailAddress);

    handleCreateLocation() async {
      if (alamatController.text == '' || detailLokasiController.text == '') {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            backgroundColor: primaryColor,
            content: const Text(
              'Silahkan lengkapi inputan diatas!',
              textAlign: TextAlign.center,
            ),
          ),
        );
      } else if (await locationProvider.updateLocation(
        authProvider.user.token!,
        widget.location.id.toString(),
        alamatController.text,
        detailLokasiController.text,
      )) {
        await Provider.of<LocationProvider>(context, listen: false)
            .getLocations(
          authProvider.user.token.toString(),
        );
        Navigator.pop(context);
        Navigator.pushReplacementNamed(context, 'location-transaction');

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
            formInput('Alamat', alamatController, TextInputType.text),
            const SizedBox(height: 20),
            formInput(
                'Detail Lokasi', detailLokasiController, TextInputType.text),
            const SizedBox(height: 40),

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
                onPressed: handleCreateLocation,
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
