import 'package:bengkel_online/theme.dart';
import 'package:flutter/material.dart';

class VehicleTile extends StatelessWidget {
  const VehicleTile({Key? key}) : super(key: key);

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
                  'Data Kendaraan',
                  style: blackTextStyle.copyWith(
                    fontWeight: semibold,
                    fontSize: 16,
                  ),
                ),
                const SizedBox(height: 14),
                Text(
                  'Vario 125',
                  style: blackTextStyle.copyWith(
                    fontWeight: medium,
                    fontSize: 12,
                  ),
                ),
                const SizedBox(height: 6),
                Text(
                  'P 1234 JM',
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
                Image.asset(
                  'assets/img/img_default.png',
                  width: double.infinity,
                  fit: BoxFit.fill,
                ),
                const SizedBox(height: 15),

                // BUTTONS
                Row(
                  children: [
                    Flexible(
                      flex: 1,
                      child: buttonAction(
                          Icons.edit, const Color(0xff65797A), () {}),
                    ),
                    const SizedBox(width: 6),
                    Flexible(
                      flex: 1,
                      child: buttonAction(Icons.delete, primaryColor, () {}),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
