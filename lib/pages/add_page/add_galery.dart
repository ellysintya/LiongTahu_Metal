import 'dart:convert';
import 'dart:typed_data';

import 'package:butter_app_project/model/save_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
class WithGalery extends StatefulWidget {
  const WithGalery({super.key});

  @override
  State<WithGalery> createState() => _WithGaleryState();
}

class _WithGaleryState extends State<WithGalery> {
  @override
  Widget build(BuildContext context) {
    return IconButton(
        onPressed: () async {
          XFile? pickedFile = await ImagePicker().pickImage(source: ImageSource.gallery);
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
          }else {
            print("Tidak ada gambar yang dipilih.");
          }
        },
        icon: Icon(Icons.file_copy, size: 30),

    );
  }
}
