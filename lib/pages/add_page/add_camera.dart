import 'dart:convert';
import 'dart:typed_data';

import 'package:butter_app_project/model/save_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

class With_Camera extends StatefulWidget {
  const With_Camera({super.key});

  @override
  State<With_Camera> createState() => _With_CameraState();
}

class _With_CameraState extends State<With_Camera> {
  @override
  Widget build(BuildContext context) {
    return IconButton(
        onPressed: () async {

          try {
            XFile? pickedFile = await ImagePicker().pickImage(source: ImageSource.camera);

            if (pickedFile != null) {
              Future<Uint8List> compressImage(Uint8List originalImage) async {
                return await FlutterImageCompress.compressWithList(
                  originalImage,
                  quality: 50,
                );
              }
              Uint8List convert = await pickedFile.readAsBytes();
              Uint8List compressedImage = await compressImage(convert);

              Provider.of<GambarProvider>(context, listen: false).gantiGambar(compressedImage);
              String encodedImage = base64Encode(compressedImage);
              Provider.of<SaveUrl>(context, listen: false).simpanFotoMenu(encodedImage);

              print("Gambar berhasil diproses dan diunggah!");
            } else {
              print("Tidak ada gambar yang diambil.");
            }
          } catch (e) {
            print("Terjadi kesalahan saat mengambil gambar: $e");
          }
        },
        icon: Icon(Icons.camera_alt_outlined, size: 30),
      );
  }
}
