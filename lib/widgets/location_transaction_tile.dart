import 'package:bengkel_online/models/location_model.dart';
import 'package:bengkel_online/pages/edit_location_transaction.dart';
import 'package:bengkel_online/providers/auth_provider.dart';
import 'package:bengkel_online/providers/location_provider.dart';
import 'package:bengkel_online/util/themes.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class LocationTransactionTile extends StatefulWidget {
  const LocationTransactionTile(this.location, {Key? key}) : super(key: key);
  final LocationModel location;

  @override
  State<LocationTransactionTile> createState() =>
      _LocationTransactionTileState();
}

class _LocationTransactionTileState extends State<LocationTransactionTile> {
  @override
  Widget build(BuildContext context) {
    AuthProvider authProvider = Provider.of<AuthProvider>(context);
    LocationProvider locationProvider = Provider.of<LocationProvider>(context);

    handleResult() async {
      await Provider.of<LocationProvider>(context, listen: false)
          .resultLocation(
        authProvider.user.token.toString(),
        widget.location.id.toString(),
      );
      Navigator.pop(context);
      Navigator.pushReplacementNamed(context, 'checkout');
    }

    handleButtonUpdate() {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => EditLocationTransaction(widget.location),
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

              if (await locationProvider.deleteLocation(
                authProvider.user.token!,
                widget.location.id.toString(),
              )) {
                await Provider.of<LocationProvider>(context, listen: false)
                    .getLocations(authProvider.user.token!);

                Future.delayed(
                  const Duration(seconds: 1),
                  () => Navigator.pushReplacementNamed(
                      context, 'location-transaction'),
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
                      'Gagal menghapus alamat!\nSilahkan coba lagi.',
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
                    'Lokasi Saya',
                    style: blackTextStyle.copyWith(
                      fontWeight: semibold,
                      fontSize: 16,
                    ),
                  ),
                  const SizedBox(height: 14),
                  Text(
                    'Nama: ${widget.location.user?.fullname}',
                    style: blackTextStyle.copyWith(
                      fontWeight: medium,
                      fontSize: 12,
                    ),
                  ),
                  const SizedBox(height: 6),
                  Text(
                    'Alamat: ${widget.location.address}',
                    style: blackTextStyle.copyWith(
                      fontWeight: medium,
                      fontSize: 12,
                    ),
                  ),
                  const SizedBox(height: 6),
                  Text(
                    'Detail Lokasi: ${widget.location.detailAddress}',
                    style: blackTextStyle.copyWith(
                      fontWeight: medium,
                      fontSize: 12,
                    ),
                  ),
                ],
              ),
            ),

            // BUTTONS
            Flexible(
              flex: 1,
              child: Row(
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
            ),
          ],
        ),
      ),
    );
  }
}
