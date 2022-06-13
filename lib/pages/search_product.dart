import 'package:bengkel_online/providers/product_provider.dart';
import 'package:bengkel_online/util/themes.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SearchProduct extends StatefulWidget {
  const SearchProduct({Key? key}) : super(key: key);

  @override
  State<SearchProduct> createState() => _SearchProductState();
}

class _SearchProductState extends State<SearchProduct> {
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    TextEditingController searchController = TextEditingController(text: '');

    handleSearch() async {
      setState(() {
        isLoading = true;
      });

      await Provider.of<ProductProvider>(context, listen: false)
          .getSearchProduct(searchController.text);

      Navigator.pushReplacementNamed(context, 'result-search');

      setState(() {
        isLoading = false;
      });
    }

    Widget inputSearch() {
      return Container(
        height: 50,
        margin: const EdgeInsets.fromLTRB(30, 0, 30, 0),
        padding: const EdgeInsets.symmetric(
          horizontal: 16,
        ),
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.25),
              spreadRadius: 0,
              blurRadius: 4,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Row(
          children: [
            GestureDetector(
              onTap: () {
                Navigator.pop(context);
              },
              child: Icon(
                Icons.keyboard_arrow_left,
                color: iconColor,
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: TextFormField(
                controller: searchController,
                autofocus: true,
                style: poppinsTextStyle,
                decoration: InputDecoration.collapsed(
                  hintText: 'Cari produk..',
                  hintStyle: placeholderTextStyle,
                ),
              ),
            ),
            const SizedBox(width: 18),
            GestureDetector(
              onTap: handleSearch,
              child: Icon(
                Icons.search,
                color: iconColor,
              ),
            ),
          ],
        ),
      );
    }

    return Scaffold(
      body: ListView(
        children: [
          const SizedBox(height: 30),
          inputSearch(),
          const SizedBox(height: 40),
        ],
      ),
    );
  }
}
