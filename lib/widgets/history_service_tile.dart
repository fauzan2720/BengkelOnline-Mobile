import 'package:bengkel_online/models/call_mechanic_model.dart';
import 'package:bengkel_online/util/themes.dart';
import 'package:flutter/material.dart';

class HistoryServiceTile extends StatelessWidget {
  const HistoryServiceTile(this.service, {Key? key}) : super(key: key);
  final CallMechanicModel service;

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
                service.typeOfWork!,
                style: blackTextStyle.copyWith(
                  fontSize: 16,
                  fontWeight: medium,
                ),
                overflow: TextOverflow.ellipsis,
              ),
              Row(
                children: [
                  Text(
                    '-Rp${service.totalPayment}',
                    style: redTextStyle.copyWith(
                      fontWeight: light,
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
                  Text(
                    ' | ${service.createdAt!.day}-${service.createdAt!.month}-${service.createdAt!.year}',
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
            service.status!,
            textAlign: TextAlign.right,
            style: service.status! == 'diselesaikan'
                ? greenTextStyle
                : yellowTextStyle,
          ),
        ],
      ),
    );
  }
}
