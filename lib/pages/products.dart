import 'package:bengkel_online/providers/product_provider.dart';
import 'package:bengkel_online/util/themes.dart';
import 'package:bengkel_online/widgets/product_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:provider/provider.dart';

class ProductsPage extends StatefulWidget {
  const ProductsPage({Key? key}) : super(key: key);

  @override
  State<ProductsPage> createState() => _ProductsPageState();
}

class _ProductsPageState extends State<ProductsPage> {
  @override
  Widget build(BuildContext context) {
    ProductProvider productProvider = Provider.of<ProductProvider>(context);

    PreferredSizeWidget header() {
      return AppBar(
        backgroundColor: primaryColor,
        automaticallyImplyLeading: false,
        elevation: 0,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(
            Icons.arrow_back_ios,
            color: whiteColor,
          ),
        ),
        title: Text(
          'Semua Produk',
          style: whiteTextStyle.copyWith(
            fontWeight: medium,
            fontSize: 18,
          ),
        ),
        centerTitle: true,
      );
    }

    return Scaffold(
      backgroundColor: bgLightColor,
      appBar: header(),
      body: Padding(
        padding: const EdgeInsets.all(30),
        child: StaggeredGrid.count(
          mainAxisSpacing: 12,
          crossAxisCount: 2,
          children: productProvider.allProduct
              .map(
                (e) => ProductCard(e),
              )
              .toList(),
        ),
      ),
    );
  }
}
