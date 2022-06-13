import 'dart:convert';

import 'package:bengkel_online/models/cart_model.dart';
import 'package:bengkel_online/models/transaction_model.dart';
import 'package:bengkel_online/util/app_constants.dart';
import 'package:http/http.dart' as http;

class TransactionService {
  String baseUrl = AppConstants.baseUrl;

  Future<List<TransactionModel>> getHistory({
    var token,
  }) async {
    var url = '$baseUrl/transactions';

    var response = await http.get(
      Uri.parse(url),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': token,
      },
    );

    // print(response.body);

    if (response.statusCode == 200) {
      List data = jsonDecode(response.body)['data']['data'];
      List<TransactionModel> history = [];

      for (var item in data) {
        history.add(TransactionModel.fromJson(item));
      }

      return history;
    } else {
      throw Exception('Gagal Get Transactions!');
    }
  }

  Future<bool> checkout(
    String token,
    int locationId,
    double total,
    double shippingPrice,
    double totalPayment,
    List<CartModel> carts,
  ) async {
    var url = '$baseUrl/transactions';
    var headers = {
      'Content-Type': 'application/json',
      'Authorization': token,
    };
    var body = jsonEncode(
      {
        'location_id': locationId,
        'total': total,
        'shipping_price': shippingPrice,
        'total_payment': totalPayment,
        'items': carts
            .map(
              (cart) => {
                'id': cart.product!.id,
                'quantity': cart.quantity,
              },
            )
            .toList(),
        'status': "PENDING",
      },
    );

    var response = await http.post(
      Uri.parse(url),
      headers: headers,
      body: body,
    );

    // print(response.body);

    if (response.statusCode == 200) {
      return true;
    } else {
      throw Exception('Gagal Melakukan Checkout!');
    }
  }
}
