import 'package:bengkel_online/models/location_model.dart';
import 'package:bengkel_online/models/product_model.dart';
import 'package:bengkel_online/models/user_model.dart';
import 'package:bengkel_online/models/vehicle_model.dart';
import 'package:bengkel_online/providers/auth_provider.dart';
import 'package:bengkel_online/providers/call_mechanic_provider.dart';
import 'package:bengkel_online/providers/location_provider.dart';
import 'package:bengkel_online/providers/product_provider.dart';
import 'package:bengkel_online/providers/vehicle_provider.dart';
import 'package:bengkel_online/util/themes.dart';
import 'package:bengkel_online/widgets/loading_wdiget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CallMechanicPage extends StatefulWidget {
  const CallMechanicPage({Key? key}) : super(key: key);

  @override
  State<CallMechanicPage> createState() => _CallMechanicPageState();
}

class _CallMechanicPageState extends State<CallMechanicPage> {
  bool isLoading = false;
  String _typeOfWork = 'Servis Ringan';
  String _selectedPayment = 'Tunai';
  int productId = 0;
  double priceService = 50000;
  double priceOil = 0;

  @override
  Widget build(BuildContext context) {
    double totalPrice = (priceService + priceOil);

    AuthProvider authProvider = Provider.of<AuthProvider>(context);
    VehicleProvider vehicleProvider = Provider.of<VehicleProvider>(context);
    LocationProvider locationProvider = Provider.of<LocationProvider>(context);
    CallMechanicProvider callMechanicProvider =
        Provider.of<CallMechanicProvider>(context);
    ProductProvider productProvider = Provider.of<ProductProvider>(context);

    UserModel user = authProvider.user;
    VehicleModel vehicle = vehicleProvider.vehicles[0];
    LocationModel location = locationProvider.locations[0];

    TextEditingController problemController = TextEditingController(text: '');

    handleShowVehicle() async {
      await Provider.of<VehicleProvider>(context, listen: false).getVehicles(
        authProvider.user.token.toString(),
      );
      Navigator.pushNamed(context, 'vehicle');
    }

    handleShowLocation() async {
      await Provider.of<LocationProvider>(context, listen: false).getLocations(
        authProvider.user.token.toString(),
      );
      Navigator.pushNamed(context, 'location');
    }

    handleCallMechanic() async {
      setState(() {
        isLoading = true;
      });

      // jika inputan 'keluhan' kosong
      if (problemController.text == '') {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            backgroundColor: primaryColor,
            content: const Text(
              'Form keluhan wajib diisi!',
              textAlign: TextAlign.center,
            ),
          ),
        );
      } else if (productId == 0) {
        // jika user tidak ganti oli
        if (await callMechanicProvider.callMechanic(
          user.token.toString(),
          vehicle.id.toString(),
          location.id.toString(),
          _typeOfWork,
          problemController.text,
          _selectedPayment,
          totalPrice.toString(),
        )) {
          await Provider.of<CallMechanicProvider>(context, listen: false)
              .getHistoryServices(
            token: user.token!,
          );

          Future.delayed(
            const Duration(seconds: 2),
            () => Navigator.pushReplacementNamed(context, 'history'),
          );

          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              backgroundColor: Colors.green,
              content: Text(
                'Mekanik ditemukan.',
                textAlign: TextAlign.center,
              ),
            ),
          );
        }
      } else if (await callMechanicProvider.callMechanicWithProduct(
        // jika user ganti oli
        user.token.toString(),
        vehicle.id.toString(),
        location.id.toString(),
        productId.toString(),
        _typeOfWork,
        problemController.text,
        _selectedPayment,
        totalPrice.toString(),
      )) {
        await Provider.of<CallMechanicProvider>(context, listen: false)
            .getHistoryServices(
          token: user.token!,
        );

        Future.delayed(
          const Duration(seconds: 2),
          () => Navigator.pushReplacementNamed(context, 'history'),
        );

        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            backgroundColor: Colors.green,
            content: Text(
              'Mekanik ditemukan.',
              textAlign: TextAlign.center,
            ),
          ),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            backgroundColor: primaryColor,
            content: const Text(
              'Gagal Memanggil Mekanik!',
              textAlign: TextAlign.center,
            ),
          ),
        );
      }

      setState(() {
        isLoading = false;
      });
    }

    Widget showProductOils(
      ProductModel product,
    ) {
      return GestureDetector(
        onTap: () {
          setState(() {
            productId = product.id!;
            priceOil = product.price!;
            print('$productId - $priceOil');
          });
        },
        child: Container(
          width: 150,
          height: 223,
          margin: const EdgeInsets.only(right: 12),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            border: productId == product.id
                ? Border.all(color: blueColor)
                : Border.all(color: transparentColor),
            color: whiteColor,
          ),
          child: Container(
            margin: const EdgeInsets.symmetric(horizontal: 12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: Image.network(
                    product.galleries![0].url.toString(),
                    width: 126,
                    height: 136,
                    fit: BoxFit.contain,
                  ),
                ),
                const SizedBox(height: 12),
                Text(
                  '${product.productName}',
                  style: poppinsTextStyle.copyWith(
                    color: productId == product.id ? blueColor : blackColor,
                    fontWeight: medium,
                  ),
                ),
                const SizedBox(height: 6),
                Text(
                  'Rp${product.price}',
                  style: poppinsTextStyle.copyWith(
                    color: redColor,
                    fontSize: 12,
                  ),
                  overflow: TextOverflow.ellipsis,
                  maxLines: 1,
                ),
                const SizedBox(height: 10),
              ],
            ),
          ),
        ),
      );
    }

    Widget content() {
      return Container(
        padding: const EdgeInsets.all(30),
        child: ListView(
          children: [
            // HEADER
            Center(
              child: Text(
                'Panggil Mekanik',
                style: blackTextStyle.copyWith(
                  fontSize: 24,
                  fontWeight: bold,
                ),
              ),
            ),
            const SizedBox(height: 40),

            // DATA KENDARAAN
            Container(
              padding: const EdgeInsets.symmetric(
                vertical: 30,
                horizontal: 20,
              ),
              decoration: BoxDecoration(
                color: whiteColor,
                borderRadius: BorderRadius.circular(5),
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Flexible(
                    flex: 1,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Data Kendaraan',
                          style: blackTextStyle.copyWith(
                            fontWeight: semibold,
                            fontSize: 16,
                          ),
                        ),
                        const SizedBox(height: 14),
                        Text(
                          vehicle.vehicleName.toString(),
                          style: blackTextStyle.copyWith(
                            fontWeight: medium,
                            fontSize: 12,
                          ),
                        ),
                        const SizedBox(height: 6),
                        Text(
                          vehicle.numberPlate.toString(),
                          style: blackTextStyle.copyWith(
                            fontWeight: medium,
                            fontSize: 12,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Flexible(
                    flex: 1,
                    child: TextButton(
                      onPressed: handleShowVehicle,
                      child: Text(
                        'Ganti Kendaraan',
                        style: blackTextStyle.copyWith(
                          fontWeight: semibold,
                          fontSize: 14,
                          color: const Color(0xffCA4646),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 30),

            // LOKASI SAYA
            Container(
              padding: const EdgeInsets.symmetric(
                vertical: 30,
                horizontal: 20,
              ),
              decoration: BoxDecoration(
                color: whiteColor,
                borderRadius: BorderRadius.circular(5),
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Flexible(
                    flex: 1,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Lokasi Saya',
                          style: blackTextStyle.copyWith(
                            fontWeight: semibold,
                            fontSize: 16,
                          ),
                        ),
                        const SizedBox(height: 14),
                        Text(
                          'Nama: ${authProvider.user.fullname}',
                          style: blackTextStyle.copyWith(
                            fontWeight: medium,
                            fontSize: 12,
                          ),
                        ),
                        const SizedBox(height: 6),
                        Text(
                          'Alamat: ${location.address}',
                          style: blackTextStyle.copyWith(
                            fontWeight: medium,
                            fontSize: 12,
                          ),
                        ),
                        const SizedBox(height: 6),
                        Text(
                          'Detail Lokasi: ${location.detailAddress}',
                          style: blackTextStyle.copyWith(
                            fontWeight: medium,
                            fontSize: 12,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Flexible(
                    flex: 1,
                    child: TextButton(
                      onPressed: handleShowLocation,
                      child: Text(
                        'Ganti Alamat',
                        style: blackTextStyle.copyWith(
                          fontWeight: semibold,
                          fontSize: 14,
                          color: const Color(0xffCA4646),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 30),

            // JENIS PEKERJAAN
            Text(
              'Jenis Servis',
              style: blackTextStyle.copyWith(
                fontSize: 16,
                fontWeight: bold,
              ),
            ),
            const SizedBox(height: 10),
            Container(
              padding: const EdgeInsets.symmetric(
                horizontal: 16,
              ),
              width: double.infinity,
              decoration: BoxDecoration(
                color: bgLightColor,
                border: Border.all(color: greyColor),
                borderRadius: BorderRadius.circular(5),
              ),
              child: DropdownButton<String>(
                value: _typeOfWork,
                items: <String>['Servis Ringan', 'Servis Komplit']
                    .map((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
                onChanged: (value) {
                  setState(() {
                    _typeOfWork = value!;

                    if (_typeOfWork == 'Servis Ringan') {
                      priceService = 50000;
                    } else if (_typeOfWork == 'Servis Komplit') {
                      priceService = 100000;
                    }

                    print('value type of work: $_typeOfWork');
                    print('value price service: $priceService');
                  });
                },
              ),
            ),
            const SizedBox(height: 40),

            // GANTI OLI (OPSIONAL)
            Text(
              'Ganti Oli (Opsional)',
              style: blackTextStyle.copyWith(
                fontSize: 16,
                fontWeight: bold,
              ),
            ),
            const SizedBox(height: 10),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: productProvider.productoils
                    .map(
                      (e) => showProductOils(e),
                    )
                    .toList(),
              ),
            ),
            const SizedBox(height: 30),

            // KELUHAN
            Text(
              'Keluhan',
              style: blackTextStyle.copyWith(
                fontSize: 16,
                fontWeight: bold,
              ),
            ),
            const SizedBox(height: 10),
            TextFormField(
              maxLines: 5,
              controller: problemController,
              decoration: InputDecoration(
                helperMaxLines: 10,
                hintText: "Apa keluhan anda?",
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(5),
                ),
              ),
            ),
            const SizedBox(height: 30),

            // METODE PEMBAYARAN
            Text(
              'Metode Pembayaran',
              style: blackTextStyle.copyWith(
                fontSize: 16,
                fontWeight: bold,
              ),
            ),
            const SizedBox(height: 10),
            Container(
              padding: const EdgeInsets.symmetric(
                horizontal: 16,
              ),
              width: double.infinity,
              decoration: BoxDecoration(
                color: bgLightColor,
                border: Border.all(color: greyColor),
                borderRadius: BorderRadius.circular(5),
              ),
              child: DropdownButton<String>(
                value: _selectedPayment,
                items: <String>['Tunai'].map((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
                onChanged: (value) {
                  setState(() {
                    _selectedPayment = value!;
                    print('value payment gateway: $_selectedPayment');
                  });
                },
              ),
            ),
            const SizedBox(height: 40),

            // TOTAL PRICE
            Text(
              'Total Bayar: Rp$totalPrice',
              style: redTextStyle.copyWith(
                fontWeight: medium,
              ),
              textAlign: TextAlign.right,
            ),

            // BUTTONS
            Container(
              width: double.infinity,
              height: 50,
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
              margin: const EdgeInsets.only(top: 10),
              child: TextButton(
                onPressed: handleCallMechanic,
                child: Text(
                  'Panggil Sekarang',
                  style: whiteTextStyle.copyWith(
                    fontWeight: semibold,
                    fontSize: 16,
                  ),
                ),
              ),
            ),
            Container(
              width: double.infinity,
              height: 50,
              decoration: BoxDecoration(
                borderRadius: const BorderRadius.all(
                  Radius.circular(10),
                ),
                border: Border.all(color: primaryColor, width: 1),
                color: bgLightColor,
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
                  Navigator.pushReplacementNamed(context, 'home');
                },
                child: Text(
                  'Batalkan',
                  style: redTextStyle.copyWith(
                    fontWeight: semibold,
                    fontSize: 16,
                  ),
                ),
              ),
            ),
          ],
        ),
      );
    }

    return Scaffold(
      backgroundColor: bgLightColor,
      body:
          isLoading ? const LoadingWidget('Sedang Mencari Mekanik') : content(),
    );
  }
}
