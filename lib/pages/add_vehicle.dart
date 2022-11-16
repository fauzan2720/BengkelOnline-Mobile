import 'dart:io';

import 'package:bengkel_online/providers/auth_provider.dart';
import 'package:bengkel_online/providers/vehicle_provider.dart';
import 'package:bengkel_online/themes/themes.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

class AddVehicle extends StatefulWidget {
  const AddVehicle({Key? key}) : super(key: key);

  @override
  State<AddVehicle> createState() => _AddVehicleState();
}

class _AddVehicleState extends State<AddVehicle> {
  // String baseUrl = AppConstants.baseUrl;

  // XFile? image;

  // List _images = [];
  dynamic selectedImage;
  final picker = ImagePicker();

  @override
  Widget build(BuildContext context) {
    VehicleProvider vehicleProvider = Provider.of<VehicleProvider>(context);
    AuthProvider authProvider = Provider.of<AuthProvider>(context);

    TextEditingController vehicleNameController =
        TextEditingController(text: '');
    TextEditingController numberPlateController =
        TextEditingController(text: '');

    handleCreateVehicle() async {
      if (vehicleNameController.text == '' ||
          numberPlateController.text == '') {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            backgroundColor: primaryColor,
            content: const Text(
              'Silahkan lengkapi inputan diatas!',
              textAlign: TextAlign.center,
            ),
          ),
        );
      } else if (await vehicleProvider.createVehicle(
        // selectedImage,
        // 'selectedImage',
        authProvider.user.token!,
        vehicleNameController.text,
        numberPlateController.text,
        'https://elitebba.com/wp-content/uploads/2017/04/default-image.jpg',
      )) {
        await Provider.of<VehicleProvider>(context, listen: false).getVehicles(
          authProvider.user.token.toString(),
        );
        Navigator.pushReplacementNamed(context, 'vehicle');

        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            backgroundColor: Colors.green,
            content: Text(
              'Berhasil ditambahkan.',
              textAlign: TextAlign.center,
            ),
          ),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            backgroundColor: primaryColor,
            content: const Text(
              'Gagal menambahkan kendaraan baru!',
              textAlign: TextAlign.center,
            ),
          ),
        );
      }
    }

    PreferredSizeWidget header() {
      return AppBar(
        backgroundColor: primaryColor,
        elevation: 0,
        title: Text(
          'Buat Kendaraan Baru',
          style: whiteTextStyle.copyWith(
            fontWeight: medium,
            fontSize: 18,
          ),
        ),
        centerTitle: true,
      );
    }

    Widget formInput(
      String text,
      TextEditingController controller,
      TextInputType keyboardType,
    ) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            text,
            style: blackTextStyle.copyWith(
              fontWeight: medium,
              fontSize: 16,
            ),
          ),
          const SizedBox(height: 12),
          Container(
            height: 50,
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
            child: TextFormField(
              keyboardType: keyboardType,
              controller: controller,
              style: poppinsTextStyle,
              decoration: InputDecoration(
                hintText: text,
                hintStyle: placeholderTextStyle,
                border: InputBorder.none,
              ),
            ),
          ),
          text == 'Nomor Plat'
              ? Container(
                  padding: const EdgeInsets.only(top: 10.0),
                  margin: const EdgeInsets.fromLTRB(10, 0, 30, 0),
                  child: Text(
                    "* contoh: P 1234 JM",
                    style: TextStyle(
                      color: iconColor,
                      fontSize: 12.0,
                    ),
                  ),
                )
              : SizedBox(),
        ],
      );
    }

    // ignore: unused_element
    Widget image() {
      return ClipRRect(
        borderRadius: BorderRadius.circular(10),
        child: selectedImage == null
            ? Stack(
                children: [
                  Image.asset('assets/img/img_default.png'),
                  GestureDetector(
                    onTap: getImage,
                    // onTap: () {
                    //   sendImage(ImageSource.camera);
                    // },
                    child: Center(
                      child: Container(
                        width: 132,
                        margin: const EdgeInsets.only(top: 150),
                        padding: const EdgeInsets.fromLTRB(16, 16, 0, 16),
                        decoration: BoxDecoration(
                          color: bgLightColor,
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(),
                        ),
                        child: Row(
                          children: [
                            Text(
                              'Ambil Foto',
                              style: blackTextStyle,
                            ),
                            const SizedBox(width: 7),
                            Icon(
                              Icons.camera_alt_outlined,
                              color: blackColor,
                              size: 18,
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              )
            : Image.file(selectedImage!),
      );
    }

    return Scaffold(
      appBar: header(),
      body: Container(
        margin: const EdgeInsets.all(20),
        child: ListView(
          children: [
            const SizedBox(height: 30),
            formInput(
                'Nama Kendaraan', vehicleNameController, TextInputType.text),
            const SizedBox(height: 20),
            formInput('Nomor Plat', numberPlateController, TextInputType.text),
            const SizedBox(height: 40),
            // image(),
            // const SizedBox(height: 40),

            // BUTOON
            Container(
              width: double.infinity,
              height: 40,
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
                onPressed: handleCreateVehicle,
                child: Text(
                  'Tambahkan',
                  style: poppinsTextStyle.copyWith(
                    fontWeight: bold,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Future sendImage(ImageSource media) async {
  //   var img = await picker.pickImage(source: media);

  //   var url = '$baseUrl/vehicles';

  //   var request = http.MultipartRequest('POST', Uri.parse(url));

  //   if (img != null) {
  //     var pic = await http.MultipartFile.fromPath("image", img.path);

  //     request.files.add(pic);

  //     await request.send().then((result) {
  //       http.Response.fromStream(result).then((response) {
  //         var message = jsonDecode(response.body);

  //         // show snackbar if input data successfully
  //         final snackBar = SnackBar(content: Text(message['message']));
  //         ScaffoldMessenger.of(context).showSnackBar(snackBar);

  //         //get new list images
  //         getImageServer();
  //       });
  //     }).catchError((e) {
  //       print(e);
  //     });
  //   }
  // }

  // Future getImageServer() async {
  //   try {
  //     final response = await http.get(Uri.parse(
  //         'http://192.168.1.4/latihan/flutter_upload_image/list.php'));

  //     if (response.statusCode == 200) {
  //       final data = jsonDecode(response.body);

  //       setState(() {
  //         _images = data;
  //       });
  //     }
  //   } catch (e) {
  //     print(e);
  //   }
  // }

  Future getImage() async {
    // buka kamera
    var photo = await picker.pickImage(source: ImageSource.camera);

    setState(() {
      selectedImage = File(photo!.path);
    });
  }
}
