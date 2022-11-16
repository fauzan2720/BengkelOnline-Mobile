import 'package:bengkel_online/models/product_model.dart';
import 'package:bengkel_online/pages/product_detail.dart';
import 'package:bengkel_online/themes/themes.dart';
import 'package:flutter/material.dart';

class ProductCard extends StatelessWidget {
  const ProductCard(this.product, {Key? key}) : super(key: key);
  final ProductModel product;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ProductDetailPage(product),
          ),
        );
      },
      child: Container(
        width: 150,
        height: 223,
        margin: const EdgeInsets.only(right: 12),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
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
                maxLines: 1,
                style: blackTextStyle.copyWith(
                  fontWeight: medium,
                ),
              ),
              const SizedBox(height: 6),
              Text(
                'Rp${product.price}',
                style: redTextStyle.copyWith(
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
}
