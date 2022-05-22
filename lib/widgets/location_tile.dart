import 'package:bengkel_online/theme.dart';
import 'package:flutter/material.dart';

class LocationTile extends StatelessWidget {
  const LocationTile({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
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

    return Container(
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
                  'Nama: Fauzan Abdillah',
                  style: blackTextStyle.copyWith(
                    fontWeight: medium,
                    fontSize: 12,
                  ),
                ),
                const SizedBox(height: 6),
                Text(
                  'Alamat: Jl. Imam Sukari',
                  style: blackTextStyle.copyWith(
                    fontWeight: medium,
                    fontSize: 12,
                  ),
                ),
                const SizedBox(height: 6),
                Text(
                  'Detail Lokasi: Warung Makan Nikmat Jl. Imam Sukari No. 85',
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
                  child:
                      buttonAction(Icons.edit, const Color(0xff65797A), () {}),
                ),
                const SizedBox(width: 6),
                Flexible(
                  flex: 1,
                  child: buttonAction(Icons.delete, primaryColor, () {}),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
