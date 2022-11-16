import 'package:bengkel_online/models/transaction_model.dart';
import 'package:bengkel_online/themes/themes.dart';
import 'package:flutter/material.dart';

class HistoryTransactionTile extends StatelessWidget {
  const HistoryTransactionTile(this.transaction, {Key? key}) : super(key: key);
  final TransactionModel transaction;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 12),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Text(
                // 'nama produk',
                '${transaction.items![0].quantity} barang',
                style: blackTextStyle.copyWith(
                  fontSize: 16,
                  fontWeight: medium,
                ),
                overflow: TextOverflow.ellipsis,
              ),
              Row(
                children: [
                  Text(
                    '-Rp${transaction.totalPayment}',
                    style: redTextStyle.copyWith(
                      fontWeight: light,
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
                  Text(
                    ' | ${transaction.createdAt!.day}-${transaction.createdAt!.month}-${transaction.createdAt!.year}',
                    style: blackTextStyle.copyWith(
                      fontWeight: light,
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ],
          ),
          Text(
            transaction.status!,
            textAlign: TextAlign.right,
            style: transaction.status! == 'selesai'
                ? greenTextStyle
                : yellowTextStyle,
          ),
        ],
      ),
    );
  }
}
