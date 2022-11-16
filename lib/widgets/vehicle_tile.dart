import 'package:bengkel_online/models/vehicle_model.dart';
import 'package:bengkel_online/pages/edit_vehiocle.dart';
import 'package:bengkel_online/providers/auth_provider.dart';
import 'package:bengkel_online/providers/location_provider.dart';
import 'package:bengkel_online/providers/vehicle_provider.dart';
import 'package:bengkel_online/themes/themes.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class VehicleTile extends StatefulWidget {
  const VehicleTile(this.vehicle, {Key? key}) : super(key: key);
  final VehicleModel vehicle;

  @override
  State<VehicleTile> createState() => _VehicleTileState();
}

class _VehicleTileState extends State<VehicleTile> {
  @override
  Widget build(BuildContext context) {
    AuthProvider authProvider = Provider.of<AuthProvider>(context);
    LocationProvider locationProvider = Provider.of<LocationProvider>(context);
    VehicleProvider vehicleProvider = Provider.of<VehicleProvider>(context);

    handleResult() async {
      if (locationProvider.locations.isEmpty) {
        await Provider.of<VehicleProvider>(context, listen: false)
            .resultVehicles(
          authProvider.user.token.toString(),
          widget.vehicle.id.toString(),
        );
        await Provider.of<LocationProvider>(context, listen: false)
            .getLocations(
          authProvider.user.token.toString(),
        );
        Navigator.pushNamed(context, 'location');
      } else {
        await Provider.of<VehicleProvider>(context, listen: false)
            .resultVehicles(
          authProvider.user.token.toString(),
          widget.vehicle.id.toString(),
        );
        Navigator.pushReplacementNamed(context, 'call');
      }
    }

    handleButtonUpdate() {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => EditVehicle(widget.vehicle),
        ),
      );
    }

    handleButtonDelete() {
      AlertDialog alertDialog = AlertDialog(
        title: const Text('Warning!!'),
        content: const Text('Apakah anda yakin ingin menghapus?'),
        actions: [
          TextButton(
            child: const Text('Batal'),
            onPressed: () => Navigator.of(context).pop(),
          ),
          TextButton(
            child: const Text('Yakin'),
            onPressed: () async {
              Navigator.pop(context);

              if (await vehicleProvider.deleteVehicle(
                authProvider.user.token!,
                widget.vehicle.id.toString(),
              )) {
                await Provider.of<VehicleProvider>(context, listen: false)
                    .getVehicles(authProvider.user.token!);
                Future.delayed(
                  const Duration(seconds: 1),
                  () => Navigator.pushReplacementNamed(context, 'vehicle'),
                );

                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    backgroundColor: Colors.green,
                    content: Text(
                      'Berhasil dihapus.',
                      textAlign: TextAlign.center,
                    ),
                  ),
                );
              } else {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    backgroundColor: Colors.red,
                    content: Text(
                      'Gagal menghapus kendaraan!\nSilahkan coba lagi.',
                      textAlign: TextAlign.center,
                    ),
                  ),
                );
              }
            },
          ),
        ],
      );
      showDialog(context: context, builder: (context) => alertDialog);
    }

    Widget buttonAction(
      IconData iconUrl,
      Color color,
      void Function()? onPressed,
    ) {
      return Container(
        padding: const EdgeInsets.symmetric(vertical: 5),
        decoration: BoxDecoration(
          borderRadius: const BorderRadius.all(
            Radius.circular(6),
          ),
          color: color,
        ),
        child: TextButton(
          onPressed: onPressed,
          child: Icon(
            iconUrl,
            color: whiteColor,
          ),
        ),
      );
    }

    return GestureDetector(
      onTap: handleResult,
      child: Container(
        margin: const EdgeInsets.symmetric(
          vertical: 10,
          horizontal: 20,
        ),
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
              flex: 2,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Kendaraan Saya',
                    style: blackTextStyle.copyWith(
                      fontWeight: semibold,
                      fontSize: 16,
                    ),
                  ),
                  const SizedBox(height: 14),
                  Text(
                    '${widget.vehicle.vehicleName}',
                    style: blackTextStyle.copyWith(
                      fontWeight: medium,
                      fontSize: 12,
                    ),
                  ),
                  const SizedBox(height: 6),
                  Text(
                    '${widget.vehicle.numberPlate}',
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
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // ClipRRect(
                  //   borderRadius: BorderRadius.circular(10),
                  //   child: Image.network(
                  //     '${widget.vehicle.photoUrl}',
                  //     width: double.infinity,
                  //     fit: BoxFit.fill,
                  //   ),
                  // ),
                  // const SizedBox(height: 15),

                  // BUTTONS
                  Row(
                    children: [
                      Flexible(
                        flex: 1,
                        child: buttonAction(Icons.edit, const Color(0xff65797A),
                            handleButtonUpdate),
                      ),
                      const SizedBox(width: 6),
                      Flexible(
                        flex: 1,
                        child: buttonAction(
                            Icons.delete, primaryColor, handleButtonDelete),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
