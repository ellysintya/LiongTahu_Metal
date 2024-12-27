import 'dart:ffi';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:lottie/lottie.dart';
class PaymentPage extends StatefulWidget {
  const PaymentPage({super.key});

  @override
  State<PaymentPage> createState() => _PaymentPageState();
}

class _PaymentPageState extends State<PaymentPage> {
  final FirebaseFirestore db = FirebaseFirestore.instance;
  final CollectionReference Payments = FirebaseFirestore.instance.collection("Payment");

  void DeletePayment(String docId) async {
    try {
      await db.collection("Payment").doc(docId).delete();
    } catch (e) {
      print("Error saat menghapus data: $e");
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(color: Colors.white),
        child:StreamBuilder(
          stream: Payments.snapshots(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: SpinKitChasingDots(
          color: Color(0xffB8001F),
          size: 50.0,
          ),);}

        if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        }

        if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
          return Center(child: Lottie.asset("assets/lottie/no data.json"));
        }

        var data = snapshot.data!.docs;


        return GridView.builder(
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            // childAspectRatio: 0.5
            // crossAxisSpacing: 10,
            // mainAxisSpacing: 10,
          ),
          itemCount: data.length,
          itemBuilder: (context, index) {
            final Payment = data[index].data() as Map<String, dynamic>;
            final String docId = data[index].id;
            double totalAmount = 0 ;
            for (var item in Payment["item"]) {
              totalAmount += (item['total_harga'] as num).toDouble();
            }

            return Card(
              color: Colors.white,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Cashier: ${Payment['nama_kasir']}',
                          style: TextStyle(fontWeight: FontWeight.bold)),
                      SizedBox(height: 5),
                      Text('${Payment['no_meja']}'),
                      SizedBox(height: 10),
                      Text('Items:'),
                      for (var item in Payment['item'])
                        Text(' - ${item['nama_menu']} x${item['jumlah']}',
                            style: TextStyle(fontSize: 11)),
                      SizedBox(height: 10),
                      Text('Total: ${totalAmount}',
                          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                      SizedBox(height: 10),
                      ElevatedButton(
                        onPressed: () async {
                          try {
                            var data = {
                              'tanggal': FieldValue.serverTimestamp(),
                              "no_meja": Payment["no_meja"],
                              "nama_kasir": Payment["nama_kasir"],
                              "Total": totalAmount,
                            };

                            await FirebaseFirestore.instance
                                .collection('History')
                                .add(data);
                            print("Data berhasil disimpan ke History!");

                            DeletePayment(docId);
                          } catch (e) {
                            print("Terjadi kesalahan: $e");
                          }
                        },
                        child: Text(
                          'Payment',
                          style: TextStyle(color: Colors.white),
                        ),
                        style: ElevatedButton.styleFrom(
                          shape: ContinuousRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          backgroundColor: Color(0xff47663B),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        );
      },
    )

    ),
    );
  }
}