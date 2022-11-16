import 'package:bengkel_online/themes/themes.dart';
import 'package:flutter/material.dart';

class LoadingLightButton extends StatelessWidget {
  const LoadingLightButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 190,
      height: 40,
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.all(
          Radius.circular(10),
        ),
        color: whiteColor,
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
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
            width: 16,
            height: 16,
            child: CircularProgressIndicator(
              strokeWidth: 2,
              valueColor: AlwaysStoppedAnimation(
                primaryColor,
              ),
            ),
          ),
          const SizedBox(
            width: 4,
          ),
          Text(
            'Loading',
            style: poppinsTextStyle.copyWith(
              fontWeight: bold,
              color: primaryColor,
            ),
          ),
        ],
      ),
    );
  }
}
