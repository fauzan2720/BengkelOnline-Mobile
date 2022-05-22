import 'package:bengkel_online/theme.dart';
import 'package:flutter/material.dart';

class CallMechanicPage extends StatefulWidget {
  const CallMechanicPage({Key? key}) : super(key: key);

  @override
  State<CallMechanicPage> createState() => _CallMechanicPageState();
}

class _CallMechanicPageState extends State<CallMechanicPage> {
  int? _typyOfWork = 1;
  int? _oilChange = 0;
  String _selectedPayment = 'Tunai';

  @override
  Widget build(BuildContext context) {
    Widget radioJenisKendaraan(
      int value,
      String text,
    ) {
      return Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Radio(
              value: value,
              groupValue: _typyOfWork,
              onChanged: (value) {
                setState(
                  () {
                    _typyOfWork = value as int?;
                  },
                );
              }),
          const SizedBox(width: 10),
          Text(
            text,
            style: blackTextStyle,
          ),
        ],
      );
    }

    Widget radioGantiOli(
      int value,
      String text,
    ) {
      return Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Radio(
              value: value,
              groupValue: _oilChange,
              onChanged: (value) {
                setState(
                  () {
                    _oilChange = value as int?;
                  },
                );
              }),
          const SizedBox(width: 10),
          Text(
            text,
            style: blackTextStyle,
          ),
        ],
      );
    }

    return Container(
      decoration: BoxDecoration(
        color: bgLightColor,
      ),
      padding: const EdgeInsets.all(30),
      child: ListView(
        children: [
          // HEADER
          Text(
            'Panggil Mekanik',
            style: blackTextStyle.copyWith(
              fontSize: 24,
              fontWeight: bold,
            ),
          ),
          const SizedBox(height: 40),

          // DATA KENDARAAN
          Container(
            padding: const EdgeInsets.symmetric(
              vertical: 30,
              horizontal: 20,
            ),
            decoration: BoxDecoration(
              color: whiteColor,
              borderRadius: BorderRadius.circular(5),
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Data Kendaraan',
                      style: blackTextStyle.copyWith(
                        fontWeight: semibold,
                        fontSize: 16,
                      ),
                    ),
                    const SizedBox(height: 14),
                    Text(
                      'Vario 125',
                      style: blackTextStyle.copyWith(
                        fontWeight: medium,
                        fontSize: 12,
                      ),
                    ),
                    const SizedBox(height: 6),
                    Text(
                      'P 1234 JM',
                      style: blackTextStyle.copyWith(
                        fontWeight: medium,
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Image.asset(
                      'assets/img/img_default.png',
                      width: 100,
                      height: 100,
                      fit: BoxFit.fill,
                    ),

                    // BUTTON
                    Container(
                      width: 100,
                      height: 30,
                      decoration: BoxDecoration(
                        borderRadius: const BorderRadius.all(
                          Radius.circular(10),
                        ),
                        gradient: const LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [
                            Color(0xffF30F0F),
                            Color(0xffD3717C),
                          ],
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.25),
                            spreadRadius: 0,
                            blurRadius: 4,
                            offset: const Offset(0, 4),
                          ),
                        ],
                      ),
                      margin: const EdgeInsets.only(top: 16),
                      child: TextButton(
                        onPressed: () {
                          Navigator.pushNamed(context, 'vehicle');
                        },
                        child: Text(
                          'Edit',
                          style: poppinsTextStyle.copyWith(
                            fontWeight: bold,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(height: 30),

          // LOKASI SAYA
          Container(
            padding: const EdgeInsets.symmetric(
              vertical: 30,
              horizontal: 20,
            ),
            decoration: BoxDecoration(
              color: whiteColor,
              borderRadius: BorderRadius.circular(5),
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Flexible(
                  flex: 1,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Lokasi Saya',
                        style: blackTextStyle.copyWith(
                          fontWeight: semibold,
                          fontSize: 16,
                        ),
                      ),
                      const SizedBox(height: 14),
                      Text(
                        'Nama: Fauzan Abdillah',
                        style: blackTextStyle.copyWith(
                          fontWeight: medium,
                          fontSize: 12,
                        ),
                      ),
                      const SizedBox(height: 6),
                      Text(
                        'Alamat: Jl. Imam Sukari',
                        style: blackTextStyle.copyWith(
                          fontWeight: medium,
                          fontSize: 12,
                        ),
                      ),
                      const SizedBox(height: 6),
                      Text(
                        'Detail Lokasi: Warung Makan Nikmat',
                        style: blackTextStyle.copyWith(
                          fontWeight: medium,
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ),
                ),
                Flexible(
                  flex: 1,
                  child: TextButton(
                    onPressed: () {
                      Navigator.pushNamed(context, 'location');
                    },
                    child: Text(
                      'Ganti Alamat',
                      style: blackTextStyle.copyWith(
                        fontWeight: semibold,
                        fontSize: 14,
                        color: const Color(0xffCA4646),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 30),

          // RADIO BUTTON
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // DETAIL LOKASI SAYA
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Jenis Pekerjaan',
                    style: blackTextStyle.copyWith(
                      fontSize: 16,
                      fontWeight: bold,
                    ),
                  ),
                  const SizedBox(height: 10),
                  radioGantiOli(0, 'None'),
                  radioGantiOli(1, 'Servis Ringan'),
                  radioGantiOli(2, 'Servis Komplit'),
                  radioGantiOli(3, 'Ganti Accu'),
                  radioGantiOli(4, 'Ganti Oli Gardan'),
                  radioGantiOli(5, 'Air Radiator'),
                  radioGantiOli(6, 'Busi'),
                ],
              ),

              // GANTI OLI (OPSIONAL)
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Ganti Oli (Opsional)',
                    style: blackTextStyle.copyWith(
                      fontSize: 16,
                      fontWeight: bold,
                    ),
                  ),
                  const SizedBox(height: 10),
                  radioJenisKendaraan(1, 'None'),
                  radioJenisKendaraan(2, 'MPX2'),
                  radioJenisKendaraan(3, 'MPX1 0.8L'),
                  radioJenisKendaraan(4, 'MPX1 1L'),
                  radioJenisKendaraan(5, 'MPX1 1.2L'),
                  radioJenisKendaraan(6, 'MPX3'),
                  radioJenisKendaraan(7, 'SPX2'),
                  radioJenisKendaraan(8, 'SPX1 0.8L'),
                  radioJenisKendaraan(9, 'SPX1 1L'),
                  radioJenisKendaraan(10, 'SPX1 1.2L'),
                ],
              ),
            ],
          ),
          const SizedBox(height: 30),

          // KELUHAN
          Text(
            'Keluhan',
            style: blackTextStyle.copyWith(
              fontSize: 16,
              fontWeight: bold,
            ),
          ),
          const SizedBox(height: 10),
          TextFormField(
            decoration: InputDecoration(
              helperMaxLines: 10,
              hintText: "Apa keluhan anda?",
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(5),
              ),
            ),
          ),
          const SizedBox(height: 30),

          // METODE PEMBAYARAN
          Container(
            padding: const EdgeInsets.symmetric(
              horizontal: 16,
            ),
            width: double.infinity,
            decoration: BoxDecoration(
              color: whiteColor,
              border: Border.all(),
              borderRadius: BorderRadius.circular(5),
            ),
            child: DropdownButton<String>(
              value: _selectedPayment,
              items: <String>['Tunai', 'Indomart', 'Alfamart', 'GoPay', 'OVO']
                  .map((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
              onChanged: (value) {
                setState(() {
                  _selectedPayment = value!;
                });
              },
            ),
          ),
          const SizedBox(height: 40),

          // BUTTON
          Container(
            width: double.infinity,
            height: 50,
            decoration: BoxDecoration(
              borderRadius: const BorderRadius.all(
                Radius.circular(10),
              ),
              gradient: const LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Color(0xffF30F0F),
                  Color(0xffD3717C),
                ],
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.25),
                  spreadRadius: 0,
                  blurRadius: 4,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            margin: const EdgeInsets.only(top: 16),
            child: TextButton(
              onPressed: () {
                Navigator.pushNamed(context, 'call-mechanic');
              },
              child: Text(
                'Panggil Sekarang',
                style: whiteTextStyle.copyWith(
                  fontWeight: semibold,
                  fontSize: 16,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
