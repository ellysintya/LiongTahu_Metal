
import 'package:butter_app_project/model/save_helper.dart';
import 'package:butter_app_project/pages/add_page/add_camera.dart';
import 'package:butter_app_project/pages/add_page/add_galery.dart';
import 'package:butter_app_project/pages/add_page/data_input.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';


class AddMenus extends StatefulWidget {
  const AddMenus({super.key});

  @override
  State<AddMenus> createState() => _AddMenusState();
}

class _AddMenusState extends State<AddMenus> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          decoration: BoxDecoration(color: Colors.white),
          padding: EdgeInsets.all(15),
          child: SafeArea(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              // mainAxisSize: MainAxisSize.min,
              children: [
                GestureDetector(
                  onTap: () {
                    showModalBottomSheet(
                      context: context,
                      builder: (context) {
                        return Container(
                          padding: EdgeInsets.all(5),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              With_Camera(),
                              WithGalery(),
                            ],
                          ),
                        );
                      },
                    );
                  },
                  child: Align(
                    alignment: Alignment.center,
                    child: Container(
                      width: 300,
                      height: 300,
                      decoration: BoxDecoration(
                        image: Provider.of<GambarProvider>(context).gambar != null
                            ? DecorationImage(
                          image: MemoryImage(Provider.of<GambarProvider>(context).gambar),
                          fit: BoxFit.cover,
                        )
                            : null,
                      ),
                      child: Provider.of<GambarProvider>(context).gambar == null
                          ? Lottie.asset(
                        'assets/lottie/camera.json',
                        fit: BoxFit.contain,
                      )
                          : null,
                    ),
                  ),
                ),
                SizedBox(height: 30),
                DataInput(),
            
              ],
            ),
          ),
        ),
      ),
    );
  }
}



SnackBar Snackbar() {
  return SnackBar(
    content: Text("Add menu"),
    behavior: SnackBarBehavior.floating,
    action: SnackBarAction(label: "Cancel", onPressed: () {}),
  );
}


