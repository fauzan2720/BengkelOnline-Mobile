import 'package:bengkel_online/models/cart_model.dart';
import 'package:bengkel_online/util/themes.dart';
import 'package:flutter/material.dart';

class CheckoutCard extends StatelessWidget {
  const CheckoutCard(this.cart, {Key? key}) : super(key: key);
  final CartModel cart;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 12),
      padding: const EdgeInsets.symmetric(
        horizontal: 12,
        vertical: 20,
      ),
      decoration: BoxDecoration(
        color: whiteColor,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            width: 60,
            height: 60,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              image: DecorationImage(
                image: NetworkImage(
                  cart.product!.galleries![0].url!,
                ),
              ),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  cart.product!.productName!,
                  style: blackTextStyle.copyWith(
                    fontWeight: semibold,
                    fontSize: 14,
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
                Text(
                  'Rp${cart.product!.price}',
                  style: redTextStyle.copyWith(
                    fontWeight: regular,
                    fontSize: 14,
                  ),
                ),
              ],
            ),
          ),
          Text(
            '${cart.quantity} Items',
            style: greyTextStyle.copyWith(
              fontWeight: regular,
              fontSize: 12,
            ),
          ),
        ],
      ),
    );
  }
}
