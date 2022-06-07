import 'package:bengkel_online/models/cart_model.dart';
import 'package:bengkel_online/providers/cart_provider.dart';
import 'package:bengkel_online/util/themes.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CartCard extends StatelessWidget {
  const CartCard(this.cart, {Key? key}) : super(key: key);
  final CartModel cart;

  @override
  Widget build(BuildContext context) {
    CartProvider cartProvider = Provider.of<CartProvider>(context);

    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: whiteColor,
        borderRadius: BorderRadius.circular(12),
      ),
      margin: const EdgeInsets.fromLTRB(0, 12, 0, 0),
      padding: const EdgeInsets.fromLTRB(16, 10, 16, 10),
      child: Column(
        children: [
          Row(
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
              Column(
                children: [
                  GestureDetector(
                    onTap: () {
                      cartProvider.addQuantity(cart.id!);
                    },
                    child: Image.asset(
                      'assets/img/btn_add.png',
                      width: 16,
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    cart.quantity.toString(),
                    style: blackTextStyle.copyWith(
                      fontWeight: medium,
                      fontSize: 14,
                    ),
                  ),
                  const SizedBox(height: 2),
                  GestureDetector(
                    onTap: () {
                      cartProvider.reduceQuantity(cart.id!);
                    },
                    child: Image.asset(
                      'assets/img/btn_reduce.png',
                      width: 16,
                    ),
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: 12),
          GestureDetector(
            onTap: () {
              cartProvider.removeCart(cart.id!);
            },
            child: Row(
              children: [
                Image.asset(
                  'assets/img/ic_remove.png',
                  width: 12,
                ),
                const SizedBox(width: 4),
                Text(
                  'Remove',
                  style: redTextStyle.copyWith(
                    fontSize: 12,
                    fontWeight: light,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
