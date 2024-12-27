

import 'dart:convert';
import 'dart:typed_data';

import 'package:butter_app_project/authentication/welcome.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:lottie/lottie.dart';

class OrderBasket extends StatefulWidget {
  const OrderBasket({super.key});

  @override
  State<OrderBasket> createState() => _OrderBasketState();
}

class _OrderBasketState extends State<OrderBasket> {
  String? selectedValue;
  final List<String> items = ['Table 1', 'Table 2', 'Table 3' , 'Table 4' , 'Table 5' , 'Table 6'];
  final CollectionReference Card_Order = FirebaseFirestore.instance.collection("Card_Order");
  FirebaseAuth auth = FirebaseAuth.instance;
  TextEditingController nama_kasir = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  int currentCategory = 0;

  void Logout(BuildContext context) async{
    await auth.signOut();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text("Logged Out"),
        backgroundColor: Colors.green,
        duration: Duration(seconds: 2), // Durasi tampil snackbar
      ),
    );
    Navigator.of(context).push(MaterialPageRoute(builder: (context) => Welcome_Page(),));
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: Color(0xffB8001F)),
        title: TextField(
          controller: nama_kasir,
          decoration: InputDecoration(
            enabledBorder: UnderlineInputBorder(borderSide: BorderSide(color: Color(0xffB8001F))),
            focusedBorder: UnderlineInputBorder(borderSide: BorderSide(color: Color(0xffB8001F))),
            hintText: "Cashier's Name",
            hintStyle: TextStyle(
              fontSize: 12
            ),
          ),
          cursorColor: Color(0xffB8001F),
        ),
        actions: [
        DropdownButton<String>(
        value: selectedValue,
        hint: Text('Table Number'),
        onChanged: (String? newValue) {
          setState(() {
            selectedValue = newValue;
          });
        },
        items: items.map<DropdownMenuItem<String>>((String value) {
          return DropdownMenuItem<String>(
            value: value,
            child: Text(value),
          );
        }).toList(),
      )
        ],
        backgroundColor: Color(0x33B8001F),
      ),
      body: Container(
        decoration: BoxDecoration(color: Colors.white),
        child: SafeArea(
          child: StreamBuilder(
            stream: Card_Order.snapshots(),

            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(child: SpinKitChasingDots(
                  color: Color(0xffB8001F),
                  size: 50.0,
                ));
              }

              if (snapshot.hasError) {
                return Center(child: Text('Error: ${snapshot.error}'));
              }

              if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                return Center(child: Lottie.asset("assets/lottie/no data.json"));
              }

              final data = snapshot.data!.docs;

              return Expanded(
                child: ListView.builder(
                  itemCount: data.length,
                  itemBuilder: (context, index) {
                    final mn = data[index].data() as Map<String, dynamic>;
                    String? base64String = mn["foto_menu"];
                    if (base64String == null || base64String.isEmpty) {
                      Lottie.asset("assets/lottie/no pic.json");
                    } else {
                      Uint8List imageBytes = base64Decode(base64String);
                      return SingleChildScrollView(
                        // scrollDirection: Axis.horizontal,
                        child: Card(
                          elevation: 5,
                          surfaceTintColor: Color(0xffB8001F),
                          shadowColor: Color(0xffB8001F),
                          shape: ContinuousRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          color: Colors.white,
                          child: Container(
                            padding: EdgeInsets.all(20),
                            width: 100,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                            ),
                              child:
                                  SingleChildScrollView(
                                    scrollDirection: Axis.horizontal,
                                    child: Row(
                                      children: [
                                        ClipRRect(
                                          borderRadius: BorderRadius.circular(10),
                                          child: Image.memory(imageBytes,
                                            fit: BoxFit.cover,
                                            height: 100,
                                            width: 100,
                                          ),
                                        ),
                                        SizedBox(width: 20,),
                                        Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Text(mn["nama_menu"]),
                                            Row(
                                              children: [
                                                Text(mn["harga_satuan"]),
                                                SizedBox(width: 15,),
                                                Text("x${mn["jumlah"].toString()}"),
                                                SizedBox(width: 50),
                                                Text(mn["total_harga"].toString() , style: TextStyle(color: Color(0xff47663B))),
                                              ],
                                        ),
                                            Align(child: Icon(Icons.delete , color: Color(0xffB8001F),), alignment: Alignment.bottomRight,),
                                      ],
                                    ),
                          ],
                                    ),
                                  ),
                            ),
                          ),

                      );
                    }
                  },
                ),
              );
            },
          ),
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        color: Colors.white,
          child: StreamBuilder<QuerySnapshot>(
            stream: Card_Order.snapshots(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return SizedBox.shrink() ;
              }
              if (!snapshot.hasData) {
                return Center(child: Text('No Data Available'));
              }
              var items = snapshot.data!.docs.map((doc) {
                int harga = int.parse(doc['harga_satuan'].toString());
                int jumlah = int.parse(doc['jumlah'].toString());
                int totalHarga = harga * jumlah;

                return {
                  'nama_menu': doc['nama_menu'],
                  'jumlah': jumlah,
                  'total_harga': totalHarga,
                };
              }).toList();

              return ElevatedButton(
                onPressed: snapshot.hasData && snapshot.data!.docs.isNotEmpty ? () async {
                  if (nama_kasir.text.isEmpty) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text("Chasier's name")),
                    );
                    return;
                  } else if (selectedValue == null){
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text("Table Number None")),
                    );
                    return;
                  }else {
                    try {
                      var data = {
                        'tanggal': FieldValue.serverTimestamp(),
                        "no_meja" : selectedValue,
                        "nama_kasir": nama_kasir.text,
                        "item": items,
                      };

                      await FirebaseFirestore.instance.collection('Payment')
                          .add(data);
                      print("Data berhasil disimpan!");
                      var snapshot = await Card_Order.get();
                      for (var doc in snapshot.docs){
                        await doc.reference.delete();
                      }
                    } catch (e) {
                      print("Terjadi kesalahan: $e");
                    }
                    nama_kasir.clear();
                    selectedValue = null;
                  }
                } : null ,
                  child: Text('Payment' , style: TextStyle(color: Colors.white),),
                  style: ElevatedButton.styleFrom(
                  shape: ContinuousRectangleBorder(
                  borderRadius: BorderRadius.circular(10)
                  ),
                  backgroundColor: Color(0xff47663B)
                  ),
              );
            },
          ),

      ),
    );
  }
}


