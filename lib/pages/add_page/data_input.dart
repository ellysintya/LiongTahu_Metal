import 'package:butter_app_project/model/save_helper.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:provider/provider.dart';

class DataInput extends StatefulWidget {
  const DataInput({super.key});

  @override
  State<DataInput> createState() => _DataInputState();
}

class _DataInputState extends State<DataInput> {
  FirebaseFirestore db = FirebaseFirestore.instance ;
  String? _selectedOption = "liong tahu" ;

  TextEditingController nama = TextEditingController();
  TextEditingController harga = TextEditingController();
  TextEditingController penjualan = TextEditingController();
  TextEditingController foto_menu = TextEditingController();
  TextEditingController jenis = TextEditingController();
  TextEditingController deskripsi = TextEditingController();

  @override
  void dispose() {
    nama.dispose();
    penjualan.dispose();
    harga.dispose();
    jenis.dispose();
    foto_menu.dispose();
    deskripsi.dispose();
    super.dispose();
  }


  void CreateMenu() async {
    try{
      db.collection("Menu").doc().set({"nama" : nama.text , "harga" : harga.text ,"foto_menu" : Provider.of<SaveUrl>(context , listen : false).FotoMenuUrl , "jenis" : _selectedOption , "deskripsi" : deskripsi.text});
      print("Success");
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("Berhasil Tertambah"),
          backgroundColor: Colors.green,
          duration: Duration(seconds: 2),
        ),
      );
    }catch(e){
      print(e);

    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
     crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text("Name" ,textAlign: TextAlign.left,),
        TextField(
          controller: nama,
          decoration: InputDecoration(
            hintText: "name of menu",
            hintStyle: TextStyle(
                color: Colors.grey.shade500,
                // fontWeight: FontWeight.bold,
                fontSize: 15),
            border: InputBorder.none,
            filled: true,
            fillColor: Colors.grey.shade100,

          ),
          style: TextStyle(
            color: Colors.black,
          ),
        ), SizedBox(height: 10),
        Text("Price"),
        TextField(
          controller: harga,
          inputFormatters: [
            FilteringTextInputFormatter.digitsOnly,
            LengthLimitingTextInputFormatter(10)
          ],
          decoration: InputDecoration(
            hintText: "price of menu",
            hintStyle: TextStyle(
                color: Colors.grey.shade500,
                // fontWeight: FontWeight.bold,
                fontSize: 15),
            border: InputBorder.none,
            filled: true,
            fillColor: Colors.grey.shade100,

          ),
          style: TextStyle(
            color: Colors.black,
          ),
        ),
        SizedBox(height: 10),
        Text("Description"),
        TextField(
          controller: deskripsi,
          decoration: InputDecoration(
            hintText: "Description of menu",
            hintStyle: TextStyle(
                color: Colors.grey.shade500,
                // fontWeight: FontWeight.bold,
                fontSize: 15),
            border: InputBorder.none,
            filled: true,
            fillColor: Colors.grey.shade100,

          ),
          style: TextStyle(
            color: Colors.black,
          ),
        ),
        SizedBox(height: 30),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: [
              Radio(value: "liong tahu",
                groupValue: _selectedOption,
                onChanged: (String? value) {
                  setState(() {
                    _selectedOption = value;
                  });
                },
              ),
              Text("Liong Tahu", style: TextStyle(fontSize: 12)),

              Radio(value: "minum",
                groupValue: _selectedOption,
                onChanged: (String? value) {
                  setState(() {
                    _selectedOption = value;
                  });
                },
              ),
              Text("Beverage", style: TextStyle(fontSize: 12)),

              Radio(value: "mie",
                groupValue: _selectedOption,
                onChanged: (String? value) {
                  setState(() {
                    _selectedOption = value;
                  });
                },
              ),
              Text("Bakmie", style: TextStyle(fontSize: 12)),

              Radio(value: "rice",
                groupValue: _selectedOption,
                onChanged: (String? value) {
                  setState(() {
                    _selectedOption = value;
                  });
                },
              ),
              Text("Rice", style: TextStyle(fontSize: 12)),
            ],
          ),
        ),
        SizedBox(height: 20),
        Align(
          alignment: Alignment.bottomRight,
          child: ElevatedButton(
            onPressed: () async {
              if (nama.text.isEmpty) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text("nama tidak boleh kosong")),
                );
                return;
              } else if (harga.text.isEmpty) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text("harga tidak boleh kosong")),
                );
              } else {
                showDialog(
                  context: context,
                  builder: (context) {
                    return Center(
                      child: SpinKitChasingDots(
                        color: Color(0xffB8001F),
                        size: 50.0,
                      ),
                    );
                  },
                );

                await Future.delayed(Duration(seconds: 2));


                Navigator.of(context).pop();
                CreateMenu();
                nama.text = '';
                harga.text = '';
                deskripsi.text = '';
              }

            },
            child: Text("Add menu"),
            style: ElevatedButton.styleFrom(
              shape: ContinuousRectangleBorder(
                  borderRadius: BorderRadius.circular(10)
              ),
              backgroundColor: Color(0xffB8001F),
              foregroundColor: Colors.white,
            ),
          ),
        ),

      ],
    );
  }
}
