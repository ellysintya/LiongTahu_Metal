import 'dart:convert';
import 'dart:typed_data';
import 'dart:math';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class AllMenu extends StatefulWidget {
  const AllMenu({super.key});

  @override
  State<AllMenu> createState() => _AllMenuState();
}

class _AllMenuState extends State<AllMenu> {
  int jlh = 0 ;
  Uint8List? selectedImage;
  final CollectionReference Menu = FirebaseFirestore.instance.collection("Menu");

  void _incrementCounter() {
    setState(() {
      jlh++;
      print(jlh);
    });
  }

  void _DecrementCounter() {
    setState(() {
      jlh--;
      print(jlh);
    });
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(stream: Menu.snapshots(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        }

        if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        }

        if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
          return Center(child: Text('Tidak ada data.'));
        }

        final data = snapshot.data!.docs;

        return Expanded(
          child: GridView.builder(
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
            ),
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            itemCount: data.length,
            itemBuilder: (context, index) {
              final mn = data[index].data() as Map<String, dynamic>;
              // int totalPrice =  int.parse(mn["harga"]) * jlh ;
              String? base64String = mn["foto_menu"];
              if (base64String == null || base64String.isEmpty){
                Lottie.asset("assets/lottie/no pic.json");
              } else {
                Uint8List imageBytes = base64Decode(base64String);
                return Card(
                  shape: ContinuousRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  color: Colors.white,
                  child: Container(
                    width: 100,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: GestureDetector(
                      onTap: () {
                        showModalBottomSheet(context: context,
                            enableDrag: true,
                            isScrollControlled: true,
                            builder: (BuildContext context) {
                              return SingleChildScrollView(
                                scrollDirection: Axis.vertical,
                                child: Container(
                                  padding: EdgeInsets.all(20),
                                  width: MediaQuery
                                      .of(context)
                                      .size
                                      .width,
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment
                                        .start,
                                    mainAxisAlignment: MainAxisAlignment
                                        .end,
                                    children: [
                                      Image(image: MemoryImage(imageBytes)),

                                      SizedBox(height: 20,),
                                      Text(mn["nama"], style: TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold),),
                                      Text(mn["deskripsi"],
                                        style: TextStyle(fontSize: 15,
                                            color: Colors.grey
                                                .shade400),),
                                      SizedBox(height: 20),
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment
                                            .spaceBetween,
                                        children: [
                                          Row(
                                            children: [
                                              ElevatedButton(
                                                onPressed: _DecrementCounter,
                                                child: Icon(Icons.remove,
                                                  color: Colors.black,),
                                                style: ElevatedButton
                                                    .styleFrom(
                                                  shape: CircleBorder(
                                                      side: BorderSide(
                                                          color: Color(
                                                              0xffB8001F),
                                                          width: 2)
                                                  ),
                                                ),),
                                              Text('$jlh'),

                                              ElevatedButton(
                                                  onPressed: _incrementCounter,
                                                  child: Icon(Icons.add,
                                                    color: Colors.black,),
                                                  style: ElevatedButton
                                                      .styleFrom(
                                                      shape: CircleBorder(
                                                          side: BorderSide(
                                                              color: Color(
                                                                  0xff47663B),
                                                              width: 2)
                                                      ))
                                              ),
                                            ],
                                          ),
                                          Text(mn["harga"],
                                              style: TextStyle(
                                                  color: Color(
                                                      0xff47663B),
                                                  fontWeight: FontWeight
                                                      .bold,
                                                  fontSize: 15)
                                          ),
                                        ],
                                      ),
                                      SizedBox(height: 100,),
                                      Row(
                                        crossAxisAlignment: CrossAxisAlignment
                                            .center,
                                        mainAxisAlignment: MainAxisAlignment
                                            .spaceBetween,
                                        children: [
                                          Text(jlh > 0 ? "Rp.${int.parse(
                                              mn["harga"]) * jlh}" : "",
                                              style: TextStyle(
                                                  fontSize: 15,
                                                  fontWeight: FontWeight
                                                      .bold,
                                                  color: Color(
                                                      0xff47663B))),
                                          ElevatedButton(onPressed: () {
                                            selectedImage = base64Decode(mn["foto_menu"]);
                                            Navigator.of(context).pop();
                                            jlh = 0;
                                          },
                                            child: Text(
                                                jlh > 0 ? "Order" : "",
                                                style: TextStyle(
                                                  color: Colors.white,)),
                                            style: ElevatedButton
                                                .styleFrom(
                                                backgroundColor: jlh > 0
                                                    ? Color(0xff47663B)
                                                    : null,
                                                shape: ContinuousRectangleBorder(),
                                                minimumSize: Size(
                                                    MediaQuery
                                                        .of(context)
                                                        .size
                                                        .width / 2, 50)
                                            ),),
                                        ],
                                      )
                                    ],
                                  ),
                                ),
                              );
                            });
                      },
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
                              color: Color(0xff47663B), fontSize: 12),)
                        ],
                      ),
                    ),
                  ),
                );
              }
            },
          ),
        );
      },);
  }
}
