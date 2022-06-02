import 'package:bengkel_online/models/transaction_model.dart';
import 'package:bengkel_online/services/transaction_service.dart';
import 'package:flutter/material.dart';

class TransactionProvider with ChangeNotifier {
  List<TransactionModel> _history = [];

  List<TransactionModel> get history => _history;

  set history(List<TransactionModel> history) {
    _history = history;
    notifyListeners();
  }

  Future<void> getHistory({
    var token,
  }) async {
    try {
      List<TransactionModel> history =
          await TransactionService().getHistory(token: token);
      _history = history;
    } catch (e) {
      print(e);
    }
  }
}
