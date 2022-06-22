import 'package:bengkel_online/pages/home/history_page.dart';
import 'package:flutter/material.dart';

class ShowHistoryTransactions extends StatelessWidget {
  const ShowHistoryTransactions({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: HistoryPage(),
    );
  }
}
