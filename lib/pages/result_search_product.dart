import 'package:bengkel_online/providers/product_provider.dart';
import 'package:bengkel_online/util/themes.dart';
import 'package:bengkel_online/widgets/product_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:provider/provider.dart';

class ResultSearchProductsPage extends StatefulWidget {
  const ResultSearchProductsPage({Key? key}) : super(key: key);

  @override
  State<ResultSearchProductsPage> createState() =>
      _ResultSearchProductsPageState();
}

class _ResultSearchProductsPageState extends State<ResultSearchProductsPage> {
  @override
  Widget build(BuildContext context) {
    ProductProvider productProvider = Provider.of<ProductProvider>(context);

    handleRefresh() async {
      Navigator.pop(context);
    }

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
            Icons.arrow_back,
            color: whiteColor,
          ),
        ),
        title: Text(
          'Hasil Pencarian',
          style: whiteTextStyle.copyWith(
            fontWeight: medium,
            fontSize: 18,
          ),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: handleRefresh,
            icon: Icon(
              Icons.refresh,
              color: whiteColor,
            ),
          ),
          const SizedBox(width: 10),
          IconButton(
            onPressed: () {
              Navigator.pushReplacementNamed(context, 'search');
            },
            icon: Icon(
              Icons.search,
              color: whiteColor,
            ),
          ),
          const SizedBox(width: 10),
        ],
      );
    }

    Widget result() {
      return Padding(
        padding: const EdgeInsets.all(30),
        child: StaggeredGrid.count(
          mainAxisSpacing: 12,
          crossAxisCount: 2,
          children: productProvider.searchProduct
              .map(
                (e) => Hero(tag: 'product', child: ProductCard(e)),
              )
              .toList(),
        ),
      );
    }

    Widget noResult() {
      return Center(
        child: Container(
          width: double.infinity,
          color: whiteColor,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                'assets/img/ic_cart_shop.png',
                width: 80,
              ),
              const SizedBox(height: 20),
              Text(
                'Opps, produk yang dicari tidak ada',
                style: blackTextStyle.copyWith(
                  fontSize: 16,
                  fontWeight: medium,
                ),
              ),
              const SizedBox(height: 12),
              Text(
                'Cari produk impianmu kembali',
                style: greyTextStyle,
                textAlign: TextAlign.center,
              ),
              Container(
                margin: const EdgeInsets.only(top: 30),
                width: 196,
                height: 44,
                child: TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Text(
                    'Semua Produk',
                    style: whiteTextStyle.copyWith(
                      fontSize: 16,
                      fontWeight: medium,
                    ),
                  ),
                  style: TextButton.styleFrom(
                    backgroundColor: primaryColor,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                ),
              ),
              Container(
                margin: const EdgeInsets.only(top: 12),
                width: 196,
                height: 44,
                child: TextButton(
                  onPressed: () {
                    Navigator.pushReplacementNamed(context, 'search');
                  },
                  child: Text(
                    'Cari Produk',
                    style: whiteTextStyle.copyWith(
                      fontSize: 16,
                      fontWeight: medium,
                    ),
                  ),
                  style: TextButton.styleFrom(
                    backgroundColor: const Color(0xff39374B),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      );
    }

    return Scaffold(
      backgroundColor: bgLightColor,
      appBar: header(),
      body: productProvider.searchProduct.isEmpty ? noResult() : result(),
    );
  }
}
