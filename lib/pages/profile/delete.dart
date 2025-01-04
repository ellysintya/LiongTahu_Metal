import 'dart:convert';
import 'dart:typed_data';

import 'package:butter_app_project/model/save_helper.dart';
import 'package:butter_app_project/pages/profile/update.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:lottie/lottie.dart';

class Delete extends StatefulWidget {
  const Delete({super.key});

  @override
  State<Delete> createState() => _DeleteState();
}

class _DeleteState extends State<Delete> {
  TextEditingController searchController = TextEditingController();
  Uint8List? selectedImage;
  FirebaseFirestore db = FirebaseFirestore.instance;
  final CollectionReference Menu = FirebaseFirestore.instance.collection("Menu");
  ListOrder list_order = ListOrder();


  void DeleteMenu(String docId) async {
    try {
      await db.collection("Menu").doc(docId).delete();
      print("Data berhasil dihapus: $docId");
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("Berhasil hapus"),
          backgroundColor: Colors.red,
          duration: Duration(seconds: 2),
        ),
      );
    } catch (e) {
      print("Error saat menghapus data: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
    appBar: AppBar(
      backgroundColor: Colors.white,
      automaticallyImplyLeading: false,
      title: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: TextField(
              controller: searchController,
              decoration: InputDecoration(
                border: InputBorder.none,
                filled: true,
                fillColor: Colors.grey.shade100,
                hintText: "Search on LTM",
                hintStyle: TextStyle(
                  color: Color(0xffB8001F),
                  fontSize: 15,
                ),
                prefixIcon: Icon(
                  Icons.search,
                  color: Color(0xffB8001F),
                ),

              ),
              onChanged: (value) {
                setState(() {});}
          ),
        ),
      ),
    ),
    body: Container(
      decoration: BoxDecoration(color: Colors.white),
      child: StreamBuilder(stream: searchController.text.isEmpty ? Menu.snapshots() :
      Menu.where("nama" , isGreaterThanOrEqualTo: searchController.text).where("nama", isLessThan: searchController.text + "z").snapshots(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: SpinKitChasingDots(
              color: Color(0xffB8001F),
              size: 50.0,
            ),);
          }

          if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          }

          if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
            return Center(child:  Lottie.asset("assets/lottie/no data.json"));
          }

          final data = snapshot.data!.docs;

          return Expanded(
            child: GridView.builder(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 0.8
              ),
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemCount: data.length,
              itemBuilder: (context, index) {
                final String docId = data[index].id;
                final mn = data[index].data() as Map<String, dynamic>;
                // int totalPrice =  int.parse(mn["harga"]) * jlh ;
                String? base64String = mn["foto_menu"];
                if (base64String == null || base64String.isEmpty){
                  Lottie.asset("assets/lottie/no pic.json");
                } else {
                  Uint8List imageBytes = base64Decode(base64String);
                  return Container(
                    // height: MediaQuery.of(context).size.height,
                    child: Card(
                      shape: ContinuousRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      color: Colors.white,
                      child: Container(
                        width: 100,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                        ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              ClipRRect(
                                borderRadius: BorderRadius.circular(10),
                                child: Image.memory(
                                  imageBytes,
                                  fit: BoxFit.cover
                                  ,
                                  height: 100,
                                  width: 100,
                                ),
                              ),
                              SizedBox(height: 20,),
                              Text(mn["nama"], style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.bold),),
                              SizedBox(height: 5),
                              Text("Rp ${mn["harga"]}", style: TextStyle(
                                  color: Color(0xff47663B), fontSize: 12),),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  IconButton(onPressed: (){
                                    Navigator.of(context).push(MaterialPageRoute(builder: (context) => Update( menu : mn , docId: docId , fotomenu: imageBytes),));
                                  },
                                      icon: Icon(Icons.edit_outlined , size: 20, color: Colors.green,)),
                                  IconButton(onPressed: (){
                                    showDialog(context: context,
                                        builder: (context) {
                                          return Dialog(
                                            backgroundColor: Colors.white,
                                            child: Container(
                                              height: 150,
                                              width: 200,
                                              child: Column(
                                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                                crossAxisAlignment: CrossAxisAlignment.center,
                                                children: [
                                                  Text("Want delete this item?" , style: TextStyle(fontSize: 20),),
                                                  Row(
                                                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                                    crossAxisAlignment: CrossAxisAlignment.center,
                                                    children: [
                                                      ElevatedButton(onPressed: (){
                                                        Navigator.of(context).pop();
                                                      },
                                                          child: Text("No" , style: TextStyle(color: Colors.black),) ,
                                                        style: ElevatedButton.styleFrom(
                                                          shape: ContinuousRectangleBorder(
                                                            borderRadius: BorderRadius.circular(10)
                                                          ),
                                                          backgroundColor: Colors.grey.shade100
                                                        ),),
                                                      ElevatedButton(onPressed: (){
                                                        DeleteMenu(docId);
                                                      },
                                                          child: Text("Yes" , style: TextStyle(color: Colors.white),),
                                                        style: ElevatedButton.styleFrom(
                                                          shape: ContinuousRectangleBorder(
                                                          borderRadius: BorderRadius.circular(10)
                                                      ),
                                                      backgroundColor: Color(0xffB8001F)
                                                      ),),
                                                    ],
                                                  )
                                                ],
                                              ),
                                            ),
                                          );},);
                                  },
                                      icon: Icon(Icons.delete , size: 20, color: Color(0xffB8001F),))
                                ],
                              )
                            ],
                          ),
                        ),
                    
                    ),
                  );
                }
              },
            ),
          );
        },),
    )
    );
  }
}
