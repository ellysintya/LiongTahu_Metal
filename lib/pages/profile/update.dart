import 'package:butter_app_project/model/save_helper.dart';
import 'package:butter_app_project/pages/add_page/add_camera.dart';
import 'package:butter_app_project/pages/add_page/add_galery.dart';
import 'package:butter_app_project/pages/profile/delete.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';

class Update extends StatefulWidget {
  final fotomenu ;
  final menu ;
  final String docId;
  const Update({required this.fotomenu, required this.menu,required this.docId ,super.key});

  @override
  State<Update> createState() => _UpdateState();
}

class _UpdateState extends State<Update> {
  final _fromKey = GlobalKey<FormState>();
  FirebaseFirestore db = FirebaseFirestore.instance;
  String? _selectedOption = "liong tahu" ;
  late TextEditingController nama ;
  late TextEditingController harga ;
  late TextEditingController deskripsi ;


  void initState(){
    nama = TextEditingController(text: widget.menu["nama"]);
    harga = TextEditingController(text: widget.menu["harga"]);
    deskripsi = TextEditingController(text: widget.menu["deskripsi"]);
    _selectedOption = widget.menu["jenis"];
    super.initState();
  }

  @override
  void dispose() {
    nama.dispose();
    harga.dispose();
    deskripsi.dispose();
    super.dispose();
  }


  void UpdateMhs() async{
    try{

      Map<String, dynamic> newData = {
        "nama": nama.text,
        "harga": harga.text,
        "deskripsi": deskripsi.text,
        'jenis' : _selectedOption,
        'foto_menu' :  Provider.of<SaveUrl>(context , listen : false).FotoMenuUrl
      };
      await db.collection("Menu").doc(widget.docId).update(newData);
      print("Sucess update");
      Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(builder: (context) => Delete()),
              (Route<dynamic> route) => false);
    }catch(e){}
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.all(15),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
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
                          : null
                      // DecorationImage(image: MemoryImage(widget.fotomenu)),
                    ),
                    child: Provider.of<GambarProvider>(context).gambar == null
                        ? Image(image: MemoryImage(widget.fotomenu))
                        : null,
                  ),
                ),
              ),
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
            ), ElevatedButton(
                  onPressed: () {
                    setState(() {
                      UpdateMhs();
                    });
                  },
                  child: const Text("Save", style: TextStyle(color: Colors.white),),
                  style: ElevatedButton.styleFrom(
                    shape: ContinuousRectangleBorder(borderRadius: BorderRadius.circular(10)),
                      backgroundColor: Color(0xffB8001F),
                      fixedSize: Size.fromWidth(MediaQuery.of(context).size.width)
                  )
              ),
          ]
          ),
        ),
      )

    );
  }
}
